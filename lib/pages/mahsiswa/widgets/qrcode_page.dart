import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siakad_app/bloc/qrcode/qrcode_bloc.dart';
import 'package:flutter_siakad_app/pages/mahsiswa/_mahasiswa.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  @override
  MobileScannerController cameraController = MobileScannerController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: BlocConsumer<QrcodeBloc, QrcodeState>(
        listener: (context, state) {
          state.maybeMap(
            orElse: () {},
            loaded: (state) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.data),
                  duration: const Duration(seconds: 2),
                ),
              );
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const MahasiswaPage();
              }));
            },
          );
        },
        builder: (context, state) {
          return MobileScanner(
            // fit: BoxFit.contain,
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              final Uint8List? image = capture.image;
              for (final barcode in barcodes) {
                debugPrint('Barcode found! ${barcode.rawValue}');
                context
                    .read<QrcodeBloc>()
                    .add(QrcodeEvent.scanned(barcode.rawValue ?? 'no data'));
              }
            },
          );
        },
      ),
    );
  }
}
