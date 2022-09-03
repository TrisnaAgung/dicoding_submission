part of 'detail_bloc.dart';

enum DetailStatus { initial, success, error, loading }

extension DetailStatusX on DetailStatus {
  bool get isInitial => this == DetailStatus.initial;
  bool get isSuccess => this == DetailStatus.success;
  bool get isError => this == DetailStatus.error;
  bool get isLoading => this == DetailStatus.loading;
}

class DetailState extends Equatable {
  final bool fav;
  final bool first;
  final DetailStatus status;

  DetailState({required this.fav, required this.first, required this.status});

  @override
  // TODO: implement props
  List<Object> get props => [fav, first, status];

  DetailState copyWith({
    required bool fav,
    required bool first,
    required DetailStatus status,
  }) {
    return DetailState(
      fav: fav,
      first: first,
      status: status,
    );
  }
}
