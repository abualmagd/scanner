import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

    class RichMyImage extends StatefulWidget {

      const RichMyImage({Key? key}) : super(key: key);

      @override
      _RichMyImageState createState() => _RichMyImageState();
    }

    class _RichMyImageState extends State<RichMyImage> {
  final    ScreenshotController _screenshotController=ScreenshotController();




      @override
      Widget build(BuildContext context) {
        final arg = ModalRoute.of(context)!.settings.arguments as Map;
        return Center(
          child: Container(
            height: 400,
            width: 300,
            color: Colors.yellow,
            child: Screenshot(
              controller:_screenshotController,
              child: CustomPaint(
                painter: Reshaped(arg['imageInfo']),
              ),
            ),

          ),
        );
      }
    }
class Reshaped extends CustomPainter{
  final  ImageInfo imageInfo;

  const  Reshaped(this.imageInfo);
  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    var rect=const  Rect.fromLTWH(0,0, 300,400);
    var src=
    canvas.drawImage(imageInfo.image,const Offset(5.0,5.0), Paint());
    canvas.drawImageRect( imageInfo.image, src, rect, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}