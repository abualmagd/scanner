import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:scanner/views/capture.dart';
import 'package:scanner/views/crop.dart';
import 'package:scanner/views/home.dart';
 List<CameraDescription>? cameras;
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor:Color.fromARGB(200, 222, 222, 239),
    ),
    );
    return MaterialApp(
      title: 'Easy Scanner',
      initialRoute: '/',
      routes: {
        '/':(context)=>const HomePage(),
        '/capture':(context)=>const CapturePage(),
        '/crop':(context)=>const CropPage(),
      },
    );
  }
}

