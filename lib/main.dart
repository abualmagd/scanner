import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:scanner/views/capture.dart';
import 'package:scanner/views/crop.dart';
import 'package:scanner/views/file.dart';
import 'package:scanner/views/filter.dart';
import 'package:scanner/views/home.dart';
import 'package:scanner/views/rich_my_image.dart';

List<CameraDescription>? cameras;

void main() async {
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
        systemNavigationBarColor: Color.fromARGB(200, 222, 222, 239),
      ),
    );
    return MaterialApp(
      title: 'Easy Scanner',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/capture': (context) => const CapturePage(),
        '/crop': (context) => const CropPage(),
        '/filter': (context) => const FilterPage(),
        '/file': (context) => const FilePage(),
        '/filters':(context)=>const RichMyImage(),
      },
     /* theme: ThemeData(
        colorScheme: const ColorScheme(
            primary: Color(0xffd7dede),
            primaryVariant: Colors.grey,
            secondary: Colors.blueAccent,
            secondaryVariant: Colors.blueAccent,
            surface: Colors.blueAccent,
            background: Color.fromARGB(200, 222, 222, 239),
            error: Colors.red,
            onPrimary: Color.fromARGB(200, 222, 222, 239),
            onSecondary: Color.fromARGB(200, 220, 220, 230),
            onSurface: Colors.amber,
            onBackground: Color.fromARGB(200, 222, 222, 239),
            onError: Colors.red,
            brightness: Brightness.light),
      ),*/
    );
  }
}
