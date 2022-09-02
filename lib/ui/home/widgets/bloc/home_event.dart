part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class InitialData extends HomeEvent {
  @override
  List<Object> get props => [];
}

class RefreshData extends HomeEvent {
  @override
  List<Object> get props => [];
}
