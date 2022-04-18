
import 'package:flutter/material.dart';
import 'package:scanner/widgets/crop_diagram.dart';


class CropPage extends StatefulWidget {
  const CropPage({Key? key}) : super(key: key);

  @override
  _CropPageState createState() => _CropPageState();
}

class _CropPageState extends State<CropPage> {
  final CropDiagramController _cropController = CropDiagramController();
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: ()async{
                ///crop
                await _cropController.croppedInfo().then((value) {
                  Navigator.pushNamed(context,'/filters',arguments: {
                    'imageInfo':value,
                  });
                });



              },
              icon: const Icon(Icons.crop)),
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: CropDiagram(cropDiagramController:_cropController, imagePath: arg['imagePath'],),///captured image path
        ),
      ),
    );
  }
}
