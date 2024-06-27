import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/image_picker_utils.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePickerUtils imagePickerUtils;
  ImagePickerBloc(this.imagePickerUtils) : super(const ImagePickerState()){
    on<CameraImagePicker>(_cameraImagePicker);
    on<GalleryImagePicker>(_galleryImagePicker);
  }
  void _cameraImagePicker(CameraImagePicker event, Emitter<ImagePickerState> emit)async{
    XFile? file = await imagePickerUtils.cameraImagePicker();
    emit(state.copyWith(file: file));
  }
  void _galleryImagePicker(GalleryImagePicker event, Emitter<ImagePickerState> emit)async{
    XFile? file = await imagePickerUtils.pickImageFromGallery();
    emit(state.copyWith(file: file));
  }
}
