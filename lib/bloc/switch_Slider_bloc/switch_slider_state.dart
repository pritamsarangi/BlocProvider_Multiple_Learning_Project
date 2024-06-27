import 'package:equatable/equatable.dart';

class SwitchAndSliderStates extends Equatable{
  final bool isSwitch;
  final double slider;
  const SwitchAndSliderStates({
    this.isSwitch = false ,
    this.slider = 1.0
});
  SwitchAndSliderStates copyWith({bool? isSwitch, double? slider}){
    return SwitchAndSliderStates(
      isSwitch : isSwitch ?? this.isSwitch,
      slider : slider ?? this.slider,
    );
  }
  @override
  List<Object?> get props => [isSwitch, slider];
}