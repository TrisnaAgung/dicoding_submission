part of 'daftar_favorite_bloc.dart';

abstract class DaftarFavoriteEvent extends Equatable {
  const DaftarFavoriteEvent();
}

class InitialDaftar extends DaftarFavoriteEvent {
  final List<DataUniv> dataUniv;
  final SharedPreferences loginData;

  InitialDaftar({required this.dataUniv, required this.loginData});

  @override
  List<Object> get props => [dataUniv, loginData];
}

class RefreshDaftar extends DaftarFavoriteEvent {
  final List<DataUniv> dataUniv;
  final SharedPreferences loginData;

  RefreshDaftar({required this.dataUniv, required this.loginData});

  @override
  List<Object> get props => [dataUniv, loginData];
}
