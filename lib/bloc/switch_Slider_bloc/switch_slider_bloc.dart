import 'package:bloc/bloc.dart';
import 'package:blocprovider/bloc/switch_Slider_bloc/switch_slider_event.dart';
import 'package:blocprovider/bloc/switch_Slider_bloc/switch_slider_state.dart';

class SwitchAndSliderBloc extends Bloc<SwitchAndSliderEvents, SwitchAndSliderStates>{
  SwitchAndSliderBloc():super(const SwitchAndSliderStates()){
    on<EnableOrDisableSwitch>(_enableOrDisableSwitch);
    on<SliderEvent>(_slider);
  }
  void _enableOrDisableSwitch(EnableOrDisableSwitch events, Emitter<SwitchAndSliderStates>emit){
    emit(state.copyWith(isSwitch: !state.isSwitch));
  }
  void _slider(SliderEvent events, Emitter<SwitchAndSliderStates>emit){
    emit(state.copyWith(slider: events.slider.toDouble()));
  }
}