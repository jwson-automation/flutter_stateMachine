// 상태를 정의한다.
import 'dart:async';

sealed class LoginState {
  const LoginState();

  factory LoginState.initial() = InitialState;

  factory LoginState.loading() = LoadingState;

  factory LoginState.loaded({required String data}) = LoadedState;

  factory LoginState.success() = SuccessState;

  factory LoginState.error({required String error}) = ErrorState;
}

class InitialState extends LoginState {}

class LoadingState extends LoginState {}

class LoadedState extends LoginState {
  const LoadedState({required this.data});

  final String data;
}

class SuccessState extends LoginState {}

class ErrorState extends LoginState {
  const ErrorState({required this.error});

  final String error;
}

// 액션을 정의한다.
sealed class Action {}

class LoginAction extends Action {
  LoginAction({required this.id, required this.password});

  final String id;
  final String password;
}

// 스테이트 머신을 정의한다.
class LoginStateMachine {
  LoginStateMachine(this.api) {
    _stateStreamController.add(state);
  }

  final String api;
  final _stateStreamController = StreamController<LoginState>.broadcast();
  LoginState _state = LoginState.initial();

  Stream<LoginState> get stateStream => _stateStreamController.stream;

  LoginState get state => _state;

  set state(LoginState value) {
    _state = value;
    _stateStreamController.add(value);
  }

  void dispatch(Action action) async {
    if (action is LoginAction) {
      print(state);
      state = LoginState.loading();
      print(state);

      await Future.delayed(const Duration(seconds: 2));
      // API 호출
      if (action.id == 'test' && action.password == 'test') {
        state = LoginState.success();
        print(state);
      } else {
        state = LoginState.error(error: 'error');
        print(state);
      }
    }
  }
}
