
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cropperx/cropperx.dart';

class CropPage extends StatefulWidget {
  const CropPage({Key? key}) : super(key: key);

  @override
  _CropPageState createState() => _CropPageState();
}

class _CropPageState extends State<CropPage> {
  final _cropperKey = GlobalKey(debugLabel: 'cropperKey');
    /*Future byteImage( File file)async{
      await file.readAsBytes();
    }*/

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: ()async {
                ///crop
                final croppedImage=await Cropper.crop(cropperKey:_cropperKey);
                if(croppedImage!=null){
                  Navigator.pushNamed(context, '/filter',arguments: {
                    'image':croppedImage
                  });
                }

              },
              icon: const Icon(Icons.crop)),
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Cropper(
            aspectRatio: 1/2,
            cropperKey: _cropperKey,
            image:Image.file(File(arg['imagePath'])),
            overlayType: OverlayType.rectangle,
          ),
        ),
      ),
    );
  }
}
