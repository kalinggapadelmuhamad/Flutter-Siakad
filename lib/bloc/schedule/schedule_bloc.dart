import 'package:bloc/bloc.dart';
import 'package:flutter_siakad_app/data/datasource/schedule_remote_datasource.dart';
import 'package:flutter_siakad_app/data/models/response/schedule_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';
part 'schedule_bloc.freezed.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(const _Initial()) {
    on<_GetSchedule>((event, emit) async {
      emit(const _Loading());
      final result = await ScheduleRemoteDatasource().getSchedule();
      result.fold(
        (l) => emit(const _Error()),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
