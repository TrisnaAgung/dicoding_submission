part of 'home_bloc.dart';

enum HomeStatus { initial, success, error, loading }

extension HomeStatusX on HomeStatus {
  bool get isInitial => this == HomeStatus.initial;
  bool get isSuccess => this == HomeStatus.success;
  bool get isError => this == HomeStatus.error;
  bool get isLoading => this == HomeStatus.loading;
}

class HomeState extends Equatable {
  final List<DataUniv> data;
  final HomeStatus status;

  HomeState({required this.data, required this.status});

  @override
  // TODO: implement props
  List<Object> get props => [data, status];

  HomeState copyWith({
    required List<DataUniv> data,
    required HomeStatus status,
  }) {
    return HomeState(
      data: data,
      status: status,
    );
  }
}
