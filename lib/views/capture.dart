
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:scanner/main.dart';

class CapturePage extends StatefulWidget {
  const CapturePage({Key? key}) : super(key: key);

  @override
  _CapturePageState createState() => _CapturePageState();
}

enum PagesNumber { single, multi }

class _CapturePageState extends State<CapturePage> {
  CameraController? _controller;
  Color flashOnColor = Colors.grey;
  Color flashOffColor = Colors.grey;
  PagesNumber? number = PagesNumber.single;
  List? images;

  @override
  void initState() {
    _controller = CameraController(cameras![0], ResolutionPreset.ultraHigh);
    images = [];
    _controller!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    _controller!.addListener(() {
      if (kDebugMode) {
        print('**************');
        print(_controller!.value);
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(200, 222, 222, 239),
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              _controller!.dispose();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              size: 30,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () {
                ///flash on
                _controller!.setFlashMode(FlashMode.always);
                setState(() {
                  flashOnColor = Colors.blue;
                  flashOffColor = Colors.grey;
                });
              },
              icon: Icon(
                Icons.flash_on_outlined,
                size: 30,
                color: flashOnColor,
              )),
          IconButton(
              onPressed: () {
                ///flash off
                _controller!.setFlashMode(FlashMode.off);
                setState(() {
                  flashOnColor = Colors.grey;
                  flashOffColor = Colors.blue;
                });
              },
              icon: Icon(
                Icons.flash_off_outlined,
                size: 30,
                color: flashOffColor,
              )),
          const SizedBox(
            width: 15.0,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          _controller!.value.isInitialized
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * .73,
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: CameraPreview(_controller!),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * .73,
                ),
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              number = PagesNumber.single;
                            });
                          },
                          child: Text(
                            'Single',
                            style: TextStyle(
                              color: number == PagesNumber.single
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          )),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              number = PagesNumber.multi;
                            });
                          },
                          child: Text(
                            'Multi',
                            style: TextStyle(
                              color: number == PagesNumber.single
                                  ? Colors.grey
                                  : Colors.blue,
                            ),
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: (images != null && images!.isNotEmpty)
                          ? Stack(
                              children: [
                                CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: Colors.blueAccent,
                                  /* backgroundImage: FileImage(
                                      File(images![images!.length - 1])),*/
                                  child: CircleAvatar(
                                    radius: 22,
                                    backgroundImage: FileImage(
                                        File(images![images!.length - 1])),
                                  ),
                                ),
                                Positioned(
                                  child: CircleAvatar(
                                    radius: 10.0,
                                    backgroundColor: Colors.red,
                                    child: Text(images!.length.toString()),
                                  ),
                                  right: 0,
                                  top: 0,
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        ///here tack the pictures button

        onPressed: () async {
          if (number == PagesNumber.single) {
            var image = await _controller!.takePicture();
            Navigator.pushNamed(context, '/crop', arguments: {
              'imagePath': image.path,
            });
          } else {
            var image = await _controller!.takePicture();
            images!.add(image.path);
            setState(() {});
            if (kDebugMode) {
              print('******************[][][][]*******');
              print(images!.length);
            }
          }

          //taking image here
        },
        child: const CircleAvatar(
          backgroundColor: Colors.redAccent,
        ),
        backgroundColor: Colors.blueGrey,
        heroTag: "mainFloat",
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}
