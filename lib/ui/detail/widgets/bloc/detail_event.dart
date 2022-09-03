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

class FavoriteDetail extends DetailEvent {
  final DataUniv dataUniv;
  final SharedPreferences loginData;
  final bool fav;

  FavoriteDetail(
      {required this.dataUniv, required this.loginData, required this.fav});

  @override
  List<Object> get props => [dataUniv, loginData, fav];
}
