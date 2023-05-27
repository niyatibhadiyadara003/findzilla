import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:jobseek/common/widgets/backButton.dart';
import 'package:jobseek/utils/color_res.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_text/pdf_text.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  File? landscapePathPdf;
  String remotePDFpath = '';
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  @override
  void initState() {
    fromAsset('assets/pdf/termsCondition.pdf', 'termsCondition.pdf').then((f) {
      setState(() {
        // landscapePathPdf = f.path;
        init();
      });
    });

    super.initState();
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);

      landscapePathPdf = file;
      print("landscape ====== $landscapePathPdf");
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  init() async {
    if (landscapePathPdf != null) {
      PDFDoc doc = await PDFDoc.fromPath(landscapePathPdf!.path);
      remotePDFpath = await doc.text;

      print("text ====== $remotePDFpath");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: backButton(),
                    ),
                  ),
                  const Text(
                    "Terms & Conditions",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        height: 1,
                        color: ColorRes.black),
                  ),
                  Visibility(
                    visible: false,
                    maintainAnimation: true,
                    maintainSize: true,
                    maintainState: true,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: backButton(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(remotePDFpath),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
