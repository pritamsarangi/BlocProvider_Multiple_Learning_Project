import 'package:blocprovider/bloc/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Page'),
          centerTitle: true,
          elevation: 20,
          shadowColor: Colors.deepPurple[500],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        body: BlocProvider(
          create: (_) => _loginBloc,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (current, previous) =>
                      current.email != previous.email,
                  builder: (context, state) {
                    return Card(
                      elevation: 20,
                      shadowColor: Colors.deepPurple[800],
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        focusNode: emailFocusNode,
                        decoration: const InputDecoration(
                            labelText: 'Email', border: OutlineInputBorder()),
                        onChanged: (value) {
                          context
                              .read<LoginBloc>()
                              .add(EmailChanged(email: value));
                        },
                        onFieldSubmitted: (value) {},
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (current, previous) =>
                      current.password != previous.password,
                  builder: (context, state) {
                    return Card(
                      elevation: 20,
                      shadowColor: Colors.deepPurple[800],
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        focusNode: passwordFocusNode,
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder()),
                        onChanged: (value) {
                          context
                              .read<LoginBloc>()
                              .add(PasswordChanged(password: value));
                        },
                        onFieldSubmitted: (value) {},
                      ),
                    );
                  },
                ),
                const SizedBox(height: 50),
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state.loginStatus == LoginStatus.error) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                            SnackBar(content: Text(state.message.toString())));
                    }
                    if (state.loginStatus == LoginStatus.loading) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                            SnackBar(content: Text('Submitting')));
                    }
                    if (state.loginStatus == LoginStatus.success) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                            SnackBar(content: Text('Login Successfull')));
                    }

                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (current, previous) => false,
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(LoginApi());
                          },
                          child: Text('Login'),
                          style: ButtonStyle(
                              elevation: MaterialStatePropertyAll(10)));
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
