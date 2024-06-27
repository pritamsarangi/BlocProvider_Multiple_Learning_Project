import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/switch_Slider_bloc/switch_slider_bloc.dart';
import '../../bloc/switch_Slider_bloc/switch_slider_event.dart';
import '../../bloc/switch_Slider_bloc/switch_slider_state.dart';

class SwitchAndSliderScreen extends StatelessWidget {
  const SwitchAndSliderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Switch And Slider Screen'),
      ),
      body: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('notification'),
                BlocBuilder<SwitchAndSliderBloc, SwitchAndSliderStates>(
                  buildWhen: (previous, current) => previous.isSwitch != current.isSwitch,
                  builder:(context, state){
                    return Switch(value: state.isSwitch, onChanged: (newValue){
                      context.read<SwitchAndSliderBloc>().add(EnableOrDisableSwitch());
                    } );
                  }
                )
              ],
            ),
            const SizedBox(height: 30),
            BlocBuilder<SwitchAndSliderBloc, SwitchAndSliderStates>(
              buildWhen: (previous, current) => previous.slider != current.slider,
              builder: (context, state){
                return Container(
                  height: 200,
                  color: Colors.red.withOpacity(state.slider),
                );
              },
            ),
            const SizedBox(height: 50),
            BlocBuilder<SwitchAndSliderBloc, SwitchAndSliderStates>(builder: (context, state){
              return Slider(value: state.slider, onChanged: (value){
                context.read<SwitchAndSliderBloc>().add(SliderEvent(slider: value));
              });
            })
          ],
        ),

      ),
    );
  }
}
