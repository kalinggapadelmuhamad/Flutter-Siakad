import 'package:flutter/material.dart';
import 'package:flutter_siakad_app/pages/mahsiswa/_absensi_page.dart';
import 'package:flutter_siakad_app/pages/mahsiswa/_jadwal_matkul.dart';
import 'package:flutter_siakad_app/pages/mahsiswa/_nilai_mk.dart';
import 'package:flutter_siakad_app/pages/mahsiswa/widgets/sample_map.dart';

import '../../common/components/menu_card.dart';
import '../../common/components/search_input.dart';
import '../../common/constants/colors.dart';
import '../../common/constants/images.dart';
import '_ksh.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Perkuliahan",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: ColorName.primary,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SampleMap();
                      }));
                    },
                    icon: const Icon(
                      Icons.map,
                      color: ColorName.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AbsensiPage();
                      }));
                    },
                    icon: const Icon(
                      Icons.qr_code_scanner,
                      color: ColorName.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications,
                      color: ColorName.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          SearchInput(
            controller: searchController,
          ),
          const SizedBox(height: 40.0),
          MenuCard(
            label: 'Kartu Hasil\nStudi',
            backgroundColor: const Color(0xff686BFF),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const KhsPage();
              }));
            },
            imagePath: Images.khs,
          ),
          const SizedBox(height: 40.0),
          MenuCard(
            label: 'Nilai\nMata Kuliah',
            backgroundColor: const Color(0xffFFB023),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const NilaiMkPage();
              }));
            },
            imagePath: Images.nMatkul,
          ),
          const SizedBox(height: 40.0),
          MenuCard(
            label: 'Jadwal\nMata Kuliah',
            backgroundColor: const Color(0xffFF68F0),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const JadwalMatkul();
              }));
            },
            imagePath: Images.jadwal,
          ),
        ],
      ),
    );
  }
}
