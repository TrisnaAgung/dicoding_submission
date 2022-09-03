part of 'daftar_favorite_bloc.dart';

enum DaftarFavoriteStatus { initial, success, error, loading }

extension DaftarFavoriteStatusX on DaftarFavoriteStatus {
  bool get isInitial => this == DaftarFavoriteStatus.initial;
  bool get isSuccess => this == DaftarFavoriteStatus.success;
  bool get isError => this == DaftarFavoriteStatus.error;
  bool get isLoading => this == DaftarFavoriteStatus.loading;
}

class DaftarFavoriteState extends Equatable {
  final List<DataUniv> data;
  final DaftarFavoriteStatus status;

  DaftarFavoriteState({required this.data, required this.status});

  @override
  // TODO: implement props
  List<Object> get props => [data, status];

  DaftarFavoriteState copyWith({
    required List<DataUniv> data,
    required DaftarFavoriteStatus status,
  }) {
    return DaftarFavoriteState(
      data: data,
      status: status,
    );
  }
}
