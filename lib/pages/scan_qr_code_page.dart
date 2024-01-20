import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/item_master_model.dart';
import 'package:flutter_application_1/pages/buy_item_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrCodePage extends StatefulWidget {
  const ScanQrCodePage({super.key});

  @override
  State<ScanQrCodePage> createState() => _ScanQrCodePageState();
}

class _ScanQrCodePageState extends State<ScanQrCodePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;
  bool isCodeDetected = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!isCodeDetected && scanData.code!.isNotEmpty) {
        log("masuk");
        isCodeDetected = true;
        ItemMaterModel itemMaterModel = ItemMaterModel.fromJson(
          jsonDecode(scanData.code!),
        );
        controller.stopCamera();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuyItemPage(itemMaterModel: itemMaterModel),
          ),
        ).then((value) => isCodeDetected = false);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Colors.red,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: (MediaQuery.of(context).size.width < 300 ||
                    MediaQuery.of(context).size.height < 300)
                ? 150.0
                : 300.0),
      ),
    );
  }
}
