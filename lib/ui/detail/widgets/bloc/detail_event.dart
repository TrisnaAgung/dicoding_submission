part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class InitialDetail extends DetailEvent {
  final DataUniv dataUniv;
  final SharedPreferences loginData;

  InitialDetail({required this.dataUniv, required this.loginData});

  @override
  List<Object> get props => [dataUniv, loginData];
}

class LikeDetail extends DetailEvent {
  final DataUniv dataUniv;
  final SharedPreferences loginData;
  final bool like;

  LikeDetail(
      {required this.dataUniv, required this.loginData, required this.like});

  @override
  List<Object> get props => [dataUniv, loginData, like];
}
