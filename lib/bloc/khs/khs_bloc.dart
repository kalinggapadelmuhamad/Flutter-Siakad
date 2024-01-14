import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siakad_app/data/datasource/khs_remote_datasource.dart';
import 'package:flutter_siakad_app/data/models/response/khs_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'khs_event.dart';
part 'khs_state.dart';
part 'khs_bloc.freezed.dart';

class KhsBloc extends Bloc<KhsEvent, KhsState> {
  KhsBloc() : super(const _Initial()) {
    on<_GetKhs>((event, emit) async {
      emit(const _Loading());
      final result = await KhsRemoteDataSource().getKhs();
      result.fold(
        (l) => emit(const _Error()),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
