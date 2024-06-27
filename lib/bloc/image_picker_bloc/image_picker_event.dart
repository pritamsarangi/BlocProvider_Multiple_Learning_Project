part of 'image_picker_bloc.dart';

abstract class ImagePickerEvent extends Equatable{
  const ImagePickerEvent();
  @override
  List<Object?> get props => [];
}
class CameraImagePicker extends ImagePickerEvent {
  const CameraImagePicker();
  @override
  List<Object?> get props => [];
}
class GalleryImagePicker extends ImagePickerEvent {
  const GalleryImagePicker();
  @override
  List<Object?> get props => [];
}