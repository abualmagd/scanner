import 'package:flutter/material.dart';
import 'dart:io';

class CropPage extends StatefulWidget {
  const CropPage({Key? key}) : super(key: key);

  @override
  _CropPageState createState() => _CropPageState();
}

class _CropPageState extends State<CropPage> {
 

  @override
  Widget build(BuildContext context) {
 final  arg = ModalRoute.of(context)!.settings.arguments as Map;
    return SizedBox(
      height: MediaQuery.of(context).size.height * .7,
      child: Image.file(File(arg['imagePath'])),
    );
  }
}
