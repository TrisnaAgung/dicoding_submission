part of 'daftar_like_bloc.dart';

enum DaftarLikeStatus { initial, success, error, loading }

extension DaftarLikeStatusX on DaftarLikeStatus {
  bool get isInitial => this == DaftarLikeStatus.initial;
  bool get isSuccess => this == DaftarLikeStatus.success;
  bool get isError => this == DaftarLikeStatus.error;
  bool get isLoading => this == DaftarLikeStatus.loading;
}

class DaftarLikeState extends Equatable {
  final List<DataUniv> data;
  final DaftarLikeStatus status;

  DaftarLikeState({required this.data, required this.status});

  @override
  // TODO: implement props
  List<Object> get props => [data, status];

  DaftarLikeState copyWith({
    required List<DataUniv> data,
    required DaftarLikeStatus status,
  }) {
    return DaftarLikeState(
      data: data,
      status: status,
    );
  }
}
