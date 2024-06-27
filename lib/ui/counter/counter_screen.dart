import 'package:blocprovider/ui/posts_api/posts_api_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/counter_bloc/counter_bloc.dart';
import '../../bloc/counter_bloc/counter_event.dart';
import '../../bloc/counter_bloc/counter_state.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  late CounterBloc _counterBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _counterBloc = CounterBloc();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _counterBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _counterBloc,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 20,
          shadowColor: Colors.deepPurple[200],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Text('Counter App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PostsScreen()));
                },
                child: const Text('Next Screen'),
                style: ButtonStyle(elevation: MaterialStatePropertyAll(10))),
            BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.counter.toString(),
                    style: TextStyle(fontSize: 60),
                  ),
                ),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<CounterBloc, CounterState>(
                  buildWhen: (current, previous) => false,
                    builder: (context, state) {
                  return ElevatedButton(
                      onPressed: () {
                        context.read<CounterBloc>().add(IncrementCounter());
                      },
                      child: Icon(Icons.arrow_upward_rounded),
                      style:
                          ButtonStyle(elevation: MaterialStatePropertyAll(10)));
                }),
                SizedBox(width: 20),
                BlocBuilder<CounterBloc, CounterState>(
                    buildWhen: (current, previous) => false,
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: () {
                            context.read<CounterBloc>().add(DecrementCounter());
                          },
                          child: Icon(Icons.arrow_downward_rounded),
                          style:
                          ButtonStyle(elevation: MaterialStatePropertyAll(10)));
                    }),
                SizedBox(width: 20),
                BlocBuilder<CounterBloc, CounterState>(
                    buildWhen: (current, previous) => false,
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<CounterBloc>().add(ResetCounter());
                        },
                        child: Icon(Icons.refresh_rounded),
                        style: ButtonStyle(elevation: MaterialStatePropertyAll(10)),
                      );
                    }),

              ],
            )
          ],
        ),
      ),
    );
  }
}
