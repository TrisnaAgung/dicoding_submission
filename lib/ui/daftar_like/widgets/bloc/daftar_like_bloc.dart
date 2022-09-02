import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dicoding_submission/repository/models/dataLike.dart';
import 'package:dicoding_submission/repository/models/dataUniversitas.dart';
import 'package:dicoding_submission/ui/home/widgets/bloc/home_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'daftar_like_event.dart';
part 'daftar_like_state.dart';

class DaftarLikeBloc extends Bloc<DaftarLikeEvent, DaftarLikeState> {
  DaftarLikeBloc()
      : super(DaftarLikeState(data: [], status: DaftarLikeStatus.initial)) {
    on<InitialDaftar>((event, emit) async {
      try {
        emit(state.copyWith(data: [], status: DaftarLikeStatus.loading));
        await Future.delayed(Duration(seconds: 2)).then((_) async {
          var like = event.loginData.getString("like");
          List<DataUniv> dataUniv = [];

          if (like != null && like != "") {
            DataLike dataLike = DataLike.fromJson(jsonDecode(like));

            for (var i = 0; i < event.dataUniv.length; i++) {
              final indexLike = dataLike.data
                  .indexWhere((element) => element.id == event.dataUniv[i].id);

              if (indexLike != -1) {
                dataUniv.add(event.dataUniv[i]);
              }
            }

            emit(state.copyWith(
                data: dataUniv, status: DaftarLikeStatus.success));
          } else {
            emit(state.copyWith(
                data: dataUniv, status: DaftarLikeStatus.success));
          }
        });
      } catch (error) {
        emit(state.copyWith(data: [], status: DaftarLikeStatus.error));
      }
    });
    on<RefreshDaftar>((event, emit) async {
      try {
        emit(state.copyWith(data: [], status: DaftarLikeStatus.loading));
        await Future.delayed(Duration(seconds: 2)).then((_) async {
          var like = event.loginData.getString("like");
          List<DataUniv> dataUniv = [];

          if (like != null && like != "") {
            DataLike dataLike = DataLike.fromJson(jsonDecode(like));

            for (var i = 0; i < event.dataUniv.length; i++) {
              final indexLike = dataLike.data
                  .indexWhere((element) => element.id == event.dataUniv[i].id);

              if (indexLike != -1) {
                dataUniv.add(event.dataUniv[i]);
              }
            }

            emit(state.copyWith(
                data: dataUniv, status: DaftarLikeStatus.success));
          } else {
            emit(state.copyWith(
                data: dataUniv, status: DaftarLikeStatus.success));
          }
        });
      } catch (error) {
        emit(state.copyWith(data: [], status: DaftarLikeStatus.error));
      }
    });
  }
}
