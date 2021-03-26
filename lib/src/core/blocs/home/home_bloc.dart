import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:family/src/core/models/family.dart';
import 'package:family/src/core/repositories/repositories.dart';
import 'package:flutter/widgets.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({@required this.repository}) : super(HomeInitial());

  final FamilyRepository repository;

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeRequested) {
      yield* _mapHomeRequestedToState(event);
    } else if (event is HomeCreated) {
      yield* _mapHomeCreatedToState(event);
    } else if (event is HomeUpdated) {
      yield* _mapHomeUpdatedToState(event);
    } else if (event is HomeDeleted) {
      yield* _mapHomeDeletedToState(event);
    }
  }

  Stream<HomeState> _mapHomeRequestedToState(HomeRequested event) async* {
    yield HomeLoadInProgress();
    try {
      final List<Family> data = await repository.getList();
      yield HomeLoadSuccess(families: data);
    } catch (err) {
      print(err);
      yield HomeLoadFailure(err: err);
    }
  }

  Stream<HomeState> _mapHomeCreatedToState(HomeCreated event) async* {
    yield HomeLoadInProgress();
    try {
      final String data =
          await repository.create(event.nama, event.kelamin, event.parentId);
      yield HomeMessage(message: data);
    } catch (err) {
      print(err);
      yield HomeLoadFailure(err: err);
    }
  }

  Stream<HomeState> _mapHomeUpdatedToState(HomeUpdated event) async* {
    yield HomeLoadInProgress();
    try {
      final String data = await repository.update(
          event.id, event.nama, event.kelamin, event.parentId);
      yield HomeMessage(message: data);
    } catch (err) {
      print(err);
      yield HomeLoadFailure(err: err);
    }
  }

  Stream<HomeState> _mapHomeDeletedToState(HomeDeleted event) async* {
    yield HomeLoadInProgress();
    try {
      final String data = await repository.delete(event.id);
      yield HomeMessage(message: data);
    } catch (err) {
      print(err);
      yield HomeLoadFailure(err: err);
    }
  }
}
