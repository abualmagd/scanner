import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    final arg=ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor:  const Color.fromARGB(200, 222, 222, 239),
      appBar: AppBar(
        backgroundColor:  Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          color:  const Color.fromARGB(200, 222, 222, 239),
          height: MediaQuery.of(context).size.height*.6,
          width:  MediaQuery.of(context).size.width*.7,
          child:Image.memory(arg['image'],fit: BoxFit.cover,),
        ),
      ),
    );
  }
}
