
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';



class CropDiagram extends StatefulWidget {
  final CropDiagramController cropDiagramController;
  final String imagePath;

  //startPoint
  //width
  //height
  const CropDiagram({Key? key,required this.cropDiagramController,required this.imagePath}) : super(key: key);

  @override
  _CropDiagramState createState() => _CropDiagramState();
}

class _CropDiagramState extends State<CropDiagram> {
Uint8List? croppedImage;

@override
  void initState() {

  widget.cropDiagramController.croppedInfo=cropping;
  widget.cropDiagramController.dispose=dispose;
  _imageFile=File(widget.imagePath);
    super.initState();
  }
  
  @override
  void didUpdateWidget(covariant CropDiagram oldWidget) {
    widget.cropDiagramController.croppedInfo=cropping;
    widget.cropDiagramController.dispose=dispose;
    super.didUpdateWidget(oldWidget);
  }


Future<ImageInfo> cropping() async {
    if (kDebugMode) {
      print('calling methoda ---------------');
    }
    setState(() {
     crop=true;
   });
  var croppedImage= await  _screenshotController.capture(
       pixelRatio:MediaQuery.of(context).devicePixelRatio,
    );
  setState(() {
    cropped=true;
  });
   return  loadImageInfo(croppedImage!);


  }
  var dx1=5.0;//startPoint.dx
  var dy1=5.0;//startPoint.dy
  var dx2=250.0;//width
  var dy2=10.0;//startPoint.dy
  var dx3=250.0;//width
  var dy3=400.0;//height
  var dx4=10.0;//startPoint.dx
  var dy4=400.0;//height
  bool crop=false;

 late File _imageFile;
 bool cropped=false;

 ///load ui image from file
Future<ImageInfo> loadImageInfo(Uint8List ul )async{
  final tempDir=await getTemporaryDirectory();
  File file =await File('${tempDir.path}/image.png').create();
  file.writeAsBytesSync(ul);

  var completer=Completer<ImageInfo>();
  var img= FileImage(file);
  img.resolve(const ImageConfiguration()).addListener(ImageStreamListener((info,_){
    completer.complete(info);
  }));
  ImageInfo imageInfo=await completer.future;
  return imageInfo;
}

///load ui image from uin8list
Future<ui.Image> loadInfo(Uint8List ul)async{
  final Completer<ui.Image> completer=Completer();
  ui.decodeImageFromList(ul, (ui.Image image) {
    return completer.complete(image);
  });
  return completer.future;

}

 final ScreenshotController _screenshotController=ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
     crop?Screenshot(
       controller:_screenshotController,
       child: ClipPath(
         clipper: CropClip(dx1, dx2, dx3, dx4, dy1, dy2, dy3, dy4),
         child:Image.file(_imageFile),
       ),
     ):CustomPaint(
          child: Image.file(_imageFile),
          foregroundPainter: Sky(dx1,dx2,dx3,dx4,dy1,dy2,dy3,dy4),
        ),
        /// gesture of left top

        Positioned(
          left:dx1-8,
          top:dy1-8,
          child:Container(
            width:20,
            height:20,
            color:Colors.transparent,
            child:   GestureDetector(
              onPanUpdate: (details) {
                if(dx1+details.delta.dx>0&&dy1+details.delta.dy>0){
                  if (kDebugMode) {
                    print(details.delta.dx);
                  }
                  setState((){
                    dx1=dx1+details.delta.dx;
                    dy1=dy1+details.delta.dy;
                  });
                }
              }, ),
          ),
        ),




        /// gesture of right top

        Positioned(
          left:dx2-13,
          top:dy2-8,
          child:Container(
            width:20,
            height:20,
            color:Colors.transparent,
            child:   GestureDetector(
              onPanUpdate: (details) {
                if (kDebugMode) {
                  print(details.delta.dx);
                }
                setState((){
                  dx2=dx2+details.delta.dx;
                  dy2=dy2+details.delta.dy;
                });
              }, ),
          ),
        ),

        /// gesture of left bottom
        Positioned(
          left:dx4-8,
          top:dy4-14,
          child:Container(
            width:20,
            height:20,
            color:Colors.transparent,///transparent ///
            child:   GestureDetector(
              onPanUpdate: (details) {
                if (kDebugMode) {
                  print(details.delta.dx);
                }
                setState((){
                  dx4=dx4+details.delta.dx;
                  dy4=dy4+details.delta.dy;
                });

              }, ),
          ),
        ),

        /// gesture of right bottom

        Positioned(
          left:dx3-13,
          top:dy3-13,
          child:Container(
            width:20,
            height:20,
            color:Colors.transparent,
            child:   GestureDetector(
              onPanUpdate: (details) {
                if (kDebugMode) {
                  print(details.delta.dx);
                }
                setState((){
                  dx3=dx3+details.delta.dx;
                  dy3=dy3+details.delta.dy;
                });

              }, ),
          ),
        ),
        ///gesture i the middle

        ///top
        Positioned(
          left:((dx1+dx2)/2)-8,
          top:((dy1+dy2)/2)-8,
          child:Container(
            width:20,
            height:20,
            color:Colors.transparent,
            child:   GestureDetector(
              onVerticalDragUpdate:(details){
                setState((){
                  dy1=dy1+details.delta.dy;
                  dy2=dy2+details.delta.dy;
                });

              },
            ),
          ),
        ),

        ///right

        Positioned(
          left:((dx2+dx3)/2)-8,
          top:((dy2+dy3)/2)-8,
          child:Container(
            width:20,
            height:20,
            color:Colors.transparent,
            child:   GestureDetector(
              onHorizontalDragUpdate:(details){
                setState((){
                  dx2=dx2+details.delta.dx;
                  dx3=dx3+details.delta.dx;
                });

              },
            ),
          ),
        ),

        ///BOTTOM

        Positioned(
          left:((dx3+dx4)/2)-8,
          top:((dy3+dy4)/2)-8,
          child:Container(
            width:20,
            height:20,
            color:Colors.transparent,
            child:   GestureDetector(
              onVerticalDragUpdate:(details){
                setState((){
                  dy3=dy3+details.delta.dy;
                  dy4=dy4+details.delta.dy;
                });

              },
            ),
          ),
        ),

        ///left
        Positioned(
          left:((dx1+dx4)/2)-8,
          top:((dy1+dy4)/2)-8,
          child:Container(
            width:20,
            height:20,
            color:Colors.transparent,
            child:   GestureDetector(
              onHorizontalDragUpdate:(details){
                setState((){
                  dx1=dx1+details.delta.dx;
                  dx4=dx4+details.delta.dx;
                });

              },
            ),
          ),
        ),
      ],
    );
  }
  @override
  void dispose() {
    widget.cropDiagramController.dispose();
    super.dispose();
  }

}


class Sky extends CustomPainter {

  final double dx1;
  final double dx2;
  final double dx3;
  final double dx4;
  final double dy1;
  final double dy2;
  final double dy3;
  final double dy4;
  const  Sky(this.dx1,this.dx2,this.dx3,this.dx4,this.dy1,this.dy2,
      this.dy3,this.dy4);
  @override
  void paint(Canvas canvas, Size size) {

    final pt=Paint()
      ..strokeWidth=2
      ..color=Colors.green;
    final paint=  Paint()
      ..color=Colors.black.withAlpha(100);
    final path=Path()
      ..addRect(Rect.fromLTWH(0,0,size.width,size.height))
      ..moveTo(dx1,dy1)
      ..lineTo(dx2,dy2)
      ..lineTo(dx3,dy3)
      ..lineTo(dx4,dy4)
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(path,paint);
    canvas.drawLine( Offset(dx1,dy1), Offset(dx2,dy2),pt);
    canvas.drawLine( Offset(dx2,dy2), Offset(dx3,dy3),pt);
    canvas.drawLine( Offset(dx3,dy3), Offset(dx4,dy4),pt);
    canvas.drawLine( Offset(dx4,dy4), Offset(dx1,dy1),pt);
    canvas.drawCircle(Offset(dx1,dy1),8.5,pt);
    canvas.drawCircle(Offset((dx1+dx2)/2,(dy1+dy2)/2),8.5,pt);
    canvas.drawCircle(Offset(dx2,dy2),8.5,pt);
    canvas.drawCircle(Offset((dx2+dx3)/2,(dy2+dy3)/2),8.5,pt);
    canvas.drawCircle(Offset(dx3,dy3),8.5,pt);
    canvas.drawCircle(Offset((dx3+dx4)/2,(dy3+dy4)/2),8.5,pt);
    canvas.drawCircle(Offset(dx4,dy4),8.5,pt);
    canvas.drawCircle(Offset((dx1+dx4)/2,(dy1+dy4)/2),8.5,pt);
  }

  @override
  bool shouldRepaint(Sky oldDelegate) {
    return true;
  }
}

class CropClip extends CustomClipper<Path>{

  final double dx1;
  final double dx2;
  final double dx3;
  final double dx4;
  final double dy1;
  final double dy2;
  final double dy3;
  final double dy4;
  const CropClip(this.dx1, this.dx2, this.dx3, this.dx4, this.dy1, this.dy2, this.dy3, this.dy4);
  @override
  getClip(ui.Size size) {
 final   path=Path()
   ..moveTo(dx1,dy1)
   ..lineTo(dx2,dy2)
   ..lineTo(dx3,dy3)
   ..lineTo(dx4,dy4);
    path.close();
    return path;


  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }


}



class CropDiagramController {
  late Future<ImageInfo> Function() croppedInfo;
  late void Function() methodA;
  @protected
  @mustCallSuper
  late void Function() dispose;
}

