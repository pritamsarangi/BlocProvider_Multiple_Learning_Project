import 'package:equatable/equatable.dart';

abstract class SwitchAndSliderEvents extends Equatable{
  const SwitchAndSliderEvents();
  @override
  List<Object> get props => [];
}
class EnableOrDisableSwitch extends SwitchAndSliderEvents{}
class SliderEvent extends SwitchAndSliderEvents{
  const SliderEvent ({required this.slider});
  final double slider;
  @override
  List<Object> get props => [slider];
}