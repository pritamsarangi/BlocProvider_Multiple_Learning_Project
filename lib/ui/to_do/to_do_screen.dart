import 'package:blocprovider/bloc/to_do_bloc/todo_bloc.dart';
import 'package:blocprovider/bloc/to_do_bloc/todo_event.dart';
import 'package:blocprovider/bloc/to_do_bloc/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        centerTitle: true,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        if (state.todoList.isEmpty) {
          return const Center(child: Text('No todo found'));
        } else if (state.todoList.isNotEmpty) {
          return ListView.builder(
              itemCount: state.todoList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.todoList[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<TodoBloc>().add(RemoveTodoEvent(task: state.todoList[index]));
                    },
                  ),
                );
              });
        } else {
          return const SizedBox();
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for(int i = 0; i<16; i++) {
            context.read<TodoBloc>().add(AddTodoEvent(task: 'Task'+i.toString()));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
