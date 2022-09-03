import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dicoding_submission/repository/models/dataFavorite.dart';
import 'package:dicoding_submission/repository/models/dataUniversitas.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'daftar_favorite_event.dart';
part 'daftar_favorite_state.dart';

class DaftarFavoriteBloc
    extends Bloc<DaftarFavoriteEvent, DaftarFavoriteState> {
  DaftarFavoriteBloc()
      : super(DaftarFavoriteState(
            data: [], status: DaftarFavoriteStatus.initial)) {
    on<InitialDaftar>((event, emit) async {
      try {
        emit(state.copyWith(data: [], status: DaftarFavoriteStatus.loading));
        await Future.delayed(Duration(seconds: 2)).then((_) async {
          var fav = event.loginData.getString("favorite");
          List<DataUniv> dataUniv = [];

          if (fav != null && fav != "") {
            DataFavorite dataFavorite = DataFavorite.fromJson(jsonDecode(fav));

            for (var i = 0; i < event.dataUniv.length; i++) {
              final indexFav = dataFavorite.data
                  .indexWhere((element) => element.id == event.dataUniv[i].id);

              if (indexFav != -1) {
                dataUniv.add(event.dataUniv[i]);
              }
            }

            emit(state.copyWith(
                data: dataUniv, status: DaftarFavoriteStatus.success));
          } else {
            emit(state.copyWith(
                data: dataUniv, status: DaftarFavoriteStatus.success));
          }
        });
      } catch (error) {
        emit(state.copyWith(data: [], status: DaftarFavoriteStatus.error));
      }
    });
    on<RefreshDaftar>((event, emit) async {
      try {
        emit(state.copyWith(data: [], status: DaftarFavoriteStatus.loading));
        await Future.delayed(Duration(seconds: 2)).then((_) async {
          var fav = event.loginData.getString("favorite");
          List<DataUniv> dataUniv = [];

          if (fav != null && fav != "") {
            DataFavorite dataFavorite = DataFavorite.fromJson(jsonDecode(fav));

            for (var i = 0; i < event.dataUniv.length; i++) {
              final indexFav = dataFavorite.data
                  .indexWhere((element) => element.id == event.dataUniv[i].id);

              if (indexFav != -1) {
                dataUniv.add(event.dataUniv[i]);
              }
            }

            emit(state.copyWith(
                data: dataUniv, status: DaftarFavoriteStatus.success));
          } else {
            emit(state.copyWith(
                data: dataUniv, status: DaftarFavoriteStatus.success));
          }
        });
      } catch (error) {
        emit(state.copyWith(data: [], status: DaftarFavoriteStatus.error));
      }
    });
  }
}
