import 'package:blocprovider/bloc/favourite_list_bloc/favourite_list_bloc.dart';
import 'package:blocprovider/bloc/posts_bloc/posts_api_bloc.dart';
import 'package:blocprovider/bloc/switch_Slider_bloc/switch_slider_bloc.dart';
import 'package:blocprovider/bloc/to_do_bloc/todo_bloc.dart';
import 'package:blocprovider/repository/favourite_repository.dart';
import 'package:blocprovider/ui/counter/counter_screen.dart';
import 'package:blocprovider/ui/favourite_item_list/favourite_item_list_screen.dart';
import 'package:blocprovider/ui/image_picker/image_picker_screen.dart';
import 'package:blocprovider/ui/login/login_screen.dart';
import 'package:blocprovider/ui/posts_api/posts_api_screen.dart';
import 'package:blocprovider/ui/to_do/to_do_screen.dart';
import 'package:blocprovider/utils/image_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter_bloc/counter_bloc.dart';
import 'bloc/image_picker_bloc/image_picker_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      //BlocProvider(create: (_) => CounterBloc()),
      BlocProvider(create: (_) => SwitchAndSliderBloc()),
      BlocProvider(create: (_) => ImagePickerBloc(ImagePickerUtils())),
      BlocProvider(create: (_) => TodoBloc()),
      BlocProvider(create: (_) => FavouriteListBloc(FavouriteRepository())),
      BlocProvider(create: (_) => PostBloc()),

    ],
     child:MaterialApp(
          debugShowCheckedModeBanner: false,
       themeMode: ThemeMode.dark,
       theme: ThemeData(
         brightness: Brightness.dark,
         primarySwatch: Colors.blue,
       ),
       home: LoginScreen(),
          ),

        );
  }
}
