import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(200, 222, 222, 239),
        elevation: 0.0,
        title: const Text(
          'EasyScanner',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu_outlined,
                color: Colors.black45,
                size: 30,
              )),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(200, 222, 222, 239),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ///go to capture new images
          Navigator.pushNamed(context, '/capture');

        },
        child: const Icon(
          Icons.camera_alt,
          size: 30,
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        heroTag: "mainFloat",
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(200, 222, 222, 239),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {},
                child: const Icon(Icons.file_upload, color: Colors.black)),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {},
                child: const Icon(
                  Icons.support,
                  color: Colors.black,
                )),
          ],
        ),
      ),
    );
  }
}
