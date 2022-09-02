import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dicoding_submission/repository/models/dataUniversitas.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(data: [], status: HomeStatus.initial)) {
    on<InitialData>((event, emit) async {
      try {
        emit(state.copyWith(data: [], status: HomeStatus.loading));
        await Future.delayed(Duration(seconds: 2)).then((_) async {
          var jsonText =
              await rootBundle.loadString('assets/data/dataUniversitas.json');

          if (jsonText != null) {
            DataUniversitas dataUniversitas =
                DataUniversitas.fromJson(jsonDecode(jsonText));
            emit(state.copyWith(
                data: dataUniversitas.data, status: HomeStatus.success));
          } else {
            emit(state.copyWith(data: [], status: HomeStatus.error));
          }
        });
      } catch (error) {
        emit(state.copyWith(data: [], status: HomeStatus.error));
      }
    });

    on<RefreshData>((event, emit) async {
      try {
        emit(state.copyWith(data: [], status: HomeStatus.loading));
        await Future.delayed(Duration(seconds: 2)).then((_) async {
          var jsonText =
              await rootBundle.loadString('assets/data/dataUniversitas.json');

          if (jsonText != null) {
            DataUniversitas dataUniversitas =
                DataUniversitas.fromJson(jsonDecode(jsonText));
            emit(state.copyWith(
                data: dataUniversitas.data, status: HomeStatus.success));
          } else {
            emit(state.copyWith(data: [], status: HomeStatus.error));
          }
        });
      } catch (error) {
        emit(state.copyWith(data: [], status: HomeStatus.error));
      }
    });
  }
}
