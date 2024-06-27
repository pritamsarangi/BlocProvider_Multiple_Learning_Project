import 'package:blocprovider/bloc/favourite_list_bloc/favourite_list_bloc.dart';
import 'package:blocprovider/bloc/favourite_list_bloc/favourite_list_state.dart';
import 'package:blocprovider/bloc/favourite_list_bloc/favouritte_list_event.dart';
import 'package:blocprovider/model/favourite_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteItemListScreen extends StatefulWidget {
  const FavouriteItemListScreen({super.key});

  @override
  State<FavouriteItemListScreen> createState() =>
      _FavouriteItemListScreenState();
}

class _FavouriteItemListScreenState extends State<FavouriteItemListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FavouriteListBloc>().add(FetchFavouriteList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Item List App'),
        actions: [
          BlocBuilder<FavouriteListBloc, FavouriteListStates>(
            builder: (context, state) {
              return Visibility(
                visible: state.tempFavouriteList.isNotEmpty ? true : false,
                child: IconButton(
                    onPressed: () {
                      context.read<FavouriteListBloc>().add(DeleteItem());
                    },
                    icon: Icon(Icons.delete, color: Colors.red)),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<FavouriteListBloc, FavouriteListStates>(
          builder: (context, state) {
            switch (state.listStatus) {
              case ListStatus.loading:
                return Center(child: CircularProgressIndicator());
              case ListStatus.failure:
                return Text('something went wrong');
              case ListStatus.success:
                return ListView.builder(
                    itemCount: state.favouriteItemList.length,
                    itemBuilder: (context, index) {
                      final item = state.favouriteItemList[index];
                      return Card(
                        child: ListTile(
                          leading: Checkbox(
                              value: state.tempFavouriteList
                                      .contains(state.favouriteItemList[index])
                                  ? true
                                  : false,
                              onChanged: (bool? value) {
                                FavouriteItemModel item =
                                    state.favouriteItemList[index];
                                if (value!) {
                                  context
                                      .read<FavouriteListBloc>()
                                      .add(SelectItem(item: item));
                                } else {
                                  context
                                      .read<FavouriteListBloc>()
                                      .add(UnSelectItem(item: item));
                                }
                              }),
                          title: Text(state.favouriteItemList[index].value, style: TextStyle(
                            decoration: state.tempFavouriteList.contains(state.favouriteItemList[index])? TextDecoration.lineThrough: TextDecoration.none,
                            color: state.tempFavouriteList.contains(state.favouriteItemList[index])? Colors.red : Colors.white
                          ),),
                          trailing: IconButton(
                            onPressed: () {
                              FavouriteItemModel itemModel = FavouriteItemModel(
                                  id: item.id,
                                  value: item.value,
                                  isFavourite: item.isFavourite ? false : true);
                              context
                                  .read<FavouriteListBloc>()
                                  .add(FavouriteItem(item: itemModel));
                            },
                            icon: Icon(item.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_outline),
                          ),
                        ),
                      );
                    });
            }
          },
        ),
      ),
    );
  }
}
