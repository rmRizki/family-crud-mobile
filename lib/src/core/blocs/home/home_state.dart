part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadInProgress extends HomeState {}

class HomeLoadSuccess extends HomeState {
  final List<Family> families;

  const HomeLoadSuccess({@required this.families}) : assert(families != null);

  @override
  List<Object> get props => [families];
}

class HomeMessage extends HomeState {
  final String message;

  const HomeMessage({@required this.message}) : assert(message != null);

  @override
  List<Object> get props => [message];
}

class HomeLoadFailure extends HomeState {
  final dynamic err;

  HomeLoadFailure({@required this.err});

  List<Object> get props => [err];
}
