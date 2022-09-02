part of 'detail_bloc.dart';

enum DetailStatus { initial, success, error, loading }

extension DetailStatusX on DetailStatus {
  bool get isInitial => this == DetailStatus.initial;
  bool get isSuccess => this == DetailStatus.success;
  bool get isError => this == DetailStatus.error;
  bool get isLoading => this == DetailStatus.loading;
}

class DetailState extends Equatable {
  final bool like;
  final DetailStatus status;

  DetailState({required this.like, required this.status});

  @override
  // TODO: implement props
  List<Object> get props => [like, status];

  DetailState copyWith({
    required bool like,
    required DetailStatus status,
  }) {
    return DetailState(
      like: like,
      status: status,
    );
  }
}
