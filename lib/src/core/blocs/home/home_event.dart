part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeRequested extends HomeEvent {}

class HomeCreated extends HomeEvent {
  final int parentId;
  final String nama, kelamin;

  HomeCreated({
    @required this.nama,
    @required this.kelamin,
    @required this.parentId,
  });
}

class HomeUpdated extends HomeEvent {
  final int id, parentId;
  final String nama, kelamin;

  HomeUpdated({
    @required this.id,
    @required this.nama,
    @required this.kelamin,
    @required this.parentId,
  });
}

class HomeDeleted extends HomeEvent {
  final int id;

  HomeDeleted({@required this.id});
}
