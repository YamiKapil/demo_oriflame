abstract class GenericState {}

class InitialState extends GenericState {}

class LoadingState extends GenericState {}

class LoadedState<T> extends GenericState {
  final T? response;
  LoadedState({this.response});
}

class ErrorState extends GenericState {
  final String exception;
  ErrorState(this.exception);
}
