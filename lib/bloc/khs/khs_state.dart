part of 'khs_bloc.dart';

@freezed
class KhsState with _$KhsState {
  const factory KhsState.initial() = _Initial;
  const factory KhsState.loading() = _Loading;
  const factory KhsState.loaded(List<Khs> data) = _Loaded;
  const factory KhsState.error() = _Error;
}
