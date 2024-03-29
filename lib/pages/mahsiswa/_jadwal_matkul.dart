import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siakad_app/bloc/schedule/schedule_bloc.dart';
import 'package:flutter_siakad_app/common/components/custom_scaffold.dart';
import 'package:flutter_siakad_app/common/constants/images.dart';
import 'package:flutter_siakad_app/common/extension/date_time_ext.dart';
import 'package:flutter_siakad_app/pages/mahsiswa/models/course_schedule_model.dart';
import 'package:flutter_siakad_app/pages/mahsiswa/widgets/course_schedule_tile.dart';
import 'package:flutter_siakad_app/pages/mahsiswa/widgets/course_with_image.dart';

class JadwalMatkul extends StatefulWidget {
  const JadwalMatkul({super.key});

  @override
  State<JadwalMatkul> createState() => _JadwalMatkulState();
}

class _JadwalMatkulState extends State<JadwalMatkul> {
  @override
  void initState() {
    super.initState();
    context.read<ScheduleBloc>().add(const ScheduleEvent.getSchedule());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          // padding: const EdgeInsets.all(24.0),
          // shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          children: [
            const Text(
              "Jadwal MK",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CourseWithImage(
                    name: 'Basis Data',
                    imagePath: Images.basisData,
                  ),
                  CourseWithImage(
                    name: 'Algoritma',
                    imagePath: Images.algoritma,
                  ),
                  CourseWithImage(
                    name: 'RPL',
                    imagePath: Images.rpl,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              DateTime.now().toFormattedDateWithDay(),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 18.0),
            Expanded(
              child: BlocBuilder<ScheduleBloc, ScheduleState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                    loaded: (data) {
                      return ListView.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CourseScheduleTile(
                            data: CourseScheduleModel(
                              dateStart: DateTime.now(),
                              longTimeTeaching: 90,
                              course: data[index].subject.title,
                              lecture: data[index].subject.lecture.name,
                              description: data[index].ruangan,
                              startTime: data[index].jamMulai,
                              endTime: data[index].jamSelesai,
                            ),
                          );
                        },
                        itemCount: data.length,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
