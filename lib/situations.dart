import 'package:balbu1/record.dart';
import 'package:flutter/material.dart';

class Situations extends StatefulWidget {
  @override
  _SituationsState createState() => _SituationsState();
}

class _SituationsState extends State<Situations> {
  final _situations = <String>[
    'Čtení',
    'Restaurace',
    'Obchod',
    'Telefonování',
    'Prezentace'
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightGreen[210],
      ),
      home: Scaffold(
        body: _buildSituations()
      ),
    );
  }

  Widget _buildSituations() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _situations.length,
        itemBuilder: /*1*/ (context, i) {
          return ElevatedButton(
            child: Text(_situations[i]),
            onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp(situation: _situations[i])),
                    );}
          );
        });
  }
}
