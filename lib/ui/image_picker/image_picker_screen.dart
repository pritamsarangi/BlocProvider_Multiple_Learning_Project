

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/image_picker_bloc/image_picker_bloc.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Bloc'),
      ),
      body: Center(
        child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
            builder: (context, state){
              if(state.file == null){
              return  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      context.read<ImagePickerBloc>().add(GalleryImagePicker());
                    },
                    child: const CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.photo),
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: (){
                      context.read<ImagePickerBloc>().add(CameraImagePicker());
                    },
                    child: const CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.camera_alt),
                    ),
                  )
                ],
              );
            } else{
                return Image.file(File(state.file!.path));
              }
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.add),
      ),
    );
  }
}
