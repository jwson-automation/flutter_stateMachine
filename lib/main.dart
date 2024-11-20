import 'package:flutter/material.dart';
import 'package:sample/stateMachine.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: StateMachineScreen());
  }
}

class StateMachineScreen extends StatefulWidget {
  const StateMachineScreen({super.key});

  @override
  State<StateMachineScreen> createState() => _StateMachineScreenState();
}

class _StateMachineScreenState extends State<StateMachineScreen> {
  @override
  Widget build(BuildContext context) {
    final LoginStateMachine loginStateMachine =
        LoginStateMachine("jungwoo_api_key");
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Machine'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<LoginState>(
                stream: loginStateMachine.stateStream,
                builder: (context, snapshot) {
                  final state = snapshot.data ?? loginStateMachine.state;
                  return switch (state) {
                    InitialState() => Text('Initial State'),
                    LoadedState() => Text('Loaded State'),
                    LoadingState() => Text('Loading State'),
                    ErrorState() => Text('Error State'),
                    SuccessState() => Text('Success State'),
                  };
                }),
            TextButton(onPressed: (){
              loginStateMachine.dispatch(LoginAction(id: 'test', password: 'test'));
            }, child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
