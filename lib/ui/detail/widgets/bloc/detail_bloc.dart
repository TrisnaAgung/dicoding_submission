import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dicoding_submission/repository/models/dataFavorite.dart';
import 'package:dicoding_submission/repository/models/dataUniversitas.dart';
import 'package:dicoding_submission/ui/home/widgets/bloc/home_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc()
      : super(DetailState(
            fav: false, first: true, status: DetailStatus.initial)) {
    on<InitialDetail>((event, emit) async {
      try {
        emit(state.copyWith(
            fav: false, first: true, status: DetailStatus.loading));
        await Future.delayed(Duration(seconds: 1)).then((_) async {
          var fav = event.loginData.getString("favorite");

          if (fav != null && fav != "") {
            DataFavorite dataFavorite = DataFavorite.fromJson(jsonDecode(fav));

            final indexFav = dataFavorite.data
                .indexWhere((element) => element.id == event.dataUniv.id);

            if (indexFav != -1) {
              emit(state.copyWith(
                  fav: true, first: true, status: DetailStatus.success));
            } else {
              emit(state.copyWith(
                  fav: false, first: true, status: DetailStatus.success));
            }
          } else {
            emit(state.copyWith(
                fav: false, first: true, status: DetailStatus.success));
          }
        });
      } catch (error) {
        emit(state.copyWith(
            fav: false, first: true, status: DetailStatus.error));
      }
    });

    on<FavoriteDetail>((event, emit) async {
      try {
        emit(state.copyWith(
            fav: event.fav, first: true, status: DetailStatus.success));
        var fav = event.loginData.getString("favorite");
        bool favValue = event.fav;

        if (fav != null && fav != "") {
          DataFavorite dataFavorite = DataFavorite.fromJson(jsonDecode(fav));
          if (!event.fav) {
            favValue = true;
            Datum datum = Datum(id: event.dataUniv.id, favorite: true);
            dataFavorite.data.add(datum);
          } else {
            favValue = false;
            final indexFav = dataFavorite.data
                .indexWhere((element) => element.id == event.dataUniv.id);
            if (indexFav != -1) {
              dataFavorite.data.removeAt(indexFav);
            }
          }
          event.loginData.setString("favorite", jsonEncode(dataFavorite));
          emit(state.copyWith(
              fav: favValue, first: false, status: DetailStatus.success));
        } else {
          List<Datum> listFav = [];
          Datum datum = Datum(id: event.dataUniv.id, favorite: true);
          listFav.add(datum);
          DataFavorite dataFavorite = DataFavorite(data: listFav);
          event.loginData.setString("favorite", jsonEncode(dataFavorite));
          emit(state.copyWith(
              fav: true, first: false, status: DetailStatus.success));
        }
      } catch (error) {
        emit(state.copyWith(
            fav: false, first: true, status: DetailStatus.error));
      }
    });
  }
}
