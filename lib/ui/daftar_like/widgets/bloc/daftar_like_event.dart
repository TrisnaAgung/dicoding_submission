part of 'daftar_like_bloc.dart';

abstract class DaftarLikeEvent extends Equatable {
  const DaftarLikeEvent();
}

class InitialDaftar extends DaftarLikeEvent {
  final List<DataUniv> dataUniv;
  final SharedPreferences loginData;

  InitialDaftar({required this.dataUniv, required this.loginData});

  @override
  List<Object> get props => [dataUniv, loginData];
}

class RefreshDaftar extends DaftarLikeEvent {
  final List<DataUniv> dataUniv;
  final SharedPreferences loginData;

  RefreshDaftar({required this.dataUniv, required this.loginData});

  @override
  List<Object> get props => [dataUniv, loginData];
}
