import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dicoding_submission/repository/models/dataLike.dart';
import 'package:dicoding_submission/repository/models/dataUniversitas.dart';
import 'package:dicoding_submission/ui/home/widgets/bloc/home_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailState(like: false, status: DetailStatus.initial)) {
    on<InitialDetail>((event, emit) async {
      try {
        emit(state.copyWith(like: false, status: DetailStatus.loading));
        await Future.delayed(Duration(seconds: 1)).then((_) async {
          var like = event.loginData.getString("like");

          if (like != null && like != "") {
            DataLike dataLike = DataLike.fromJson(jsonDecode(like));

            final indexLike = dataLike.data
                .indexWhere((element) => element.id == event.dataUniv.id);

            if (indexLike != -1) {
              emit(state.copyWith(like: true, status: DetailStatus.success));
            } else {
              emit(state.copyWith(like: false, status: DetailStatus.success));
            }
          } else {
            emit(state.copyWith(like: false, status: DetailStatus.success));
          }
        });
      } catch (error) {
        emit(state.copyWith(like: false, status: DetailStatus.error));
      }
    });

    on<LikeDetail>((event, emit) async {
      try {
        emit(state.copyWith(like: event.like, status: DetailStatus.success));
        var like = event.loginData.getString("like");
        bool likeValue = event.like;

        if (like != null && like != "") {
          DataLike dataLike = DataLike.fromJson(jsonDecode(like));
          if (!event.like) {
            likeValue = true;
            Datum datum = Datum(id: event.dataUniv.id, like: true);
            dataLike.data.add(datum);
          } else {
            likeValue = false;
            final indexLike = dataLike.data
                .indexWhere((element) => element.id == event.dataUniv.id);
            if (indexLike != -1) {
              dataLike.data.removeAt(indexLike);
            }
          }
          event.loginData.setString("like", jsonEncode(dataLike));
          emit(state.copyWith(like: likeValue, status: DetailStatus.success));
        } else {
          List<Datum> listLike = [];
          Datum datum = Datum(id: event.dataUniv.id, like: true);
          listLike.add(datum);
          DataLike dataLike = DataLike(data: listLike);
          event.loginData.setString("like", jsonEncode(dataLike));
          emit(state.copyWith(like: true, status: DetailStatus.success));
        }
      } catch (error) {
        emit(state.copyWith(like: false, status: DetailStatus.error));
      }
    });
  }
}
