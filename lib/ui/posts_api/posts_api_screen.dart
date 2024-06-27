import 'package:blocprovider/bloc/posts_bloc/posts_api_event.dart';
import 'package:blocprovider/bloc/posts_bloc/posts_api_state.dart';
import 'package:blocprovider/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/counter_bloc/counter_bloc.dart';
import '../../bloc/counter_bloc/counter_state.dart';
import '../../bloc/posts_bloc/posts_api_bloc.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PostBloc>().add(PostFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bloc Get Api'),
        elevation: 20,
        shadowColor: Colors.deepPurple[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        actions: [],
      ),
      body: BlocBuilder<PostBloc, PostsState>(builder: (context, state) {
        switch (state.postStatus) {
          case PostStatus.loading:
            return Center(child: CircularProgressIndicator());
          case PostStatus.faliure:
            return Center(child: Text(state.message.toString()));
          case PostStatus.suecss:
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'search for email ',
                      prefixIcon: Icon(Icons.search_rounded),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    onChanged: (filterKey) {
                      context.read<PostBloc>().add(SearchItem(filterKey));
                    },
                  ),
                ),
                Expanded(
                  child: state.searchMessage.isNotEmpty
                      ? Center(child: Text(state.searchMessage.toString()))
                      : ListView.builder(
                          itemCount: state.tempPostList.isEmpty
                              ? state.postList.length
                              : state.tempPostList.length,
                          itemBuilder: (context, index) {
                            if (state.tempPostList.isNotEmpty) {
                              final item = state.tempPostList[index];
                              return Card(
                                elevation: 10,
                                margin: EdgeInsets.all(5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: ListTile(
                                  leading: Text(item.id.toString()),
                                  title: Text(item.email.toString()),
                                  subtitle: Text(item.body.toString()),
                                ),
                              );
                            } else {
                              final item = state.postList[index];
                              return Card(
                                elevation: 10,
                                margin: EdgeInsets.all(5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: ListTile(
                                  leading: Text(item.id.toString()),
                                  title: Text(item.email.toString()),
                                  subtitle: Text(item.body.toString()),
                                ),
                              );
                            }
                          }),
                ),
              ],
            );
        }
      }),
    );
  }
}
