import 'package:balbu1/situations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightGreen[210],
      ),
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 100.0, left: 20, right: 20),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Vítám Tě\nv\naplikaci BALBU',
                style: TextStyle(fontSize: 40),
                textAlign: TextAlign.center,
              ),
              const Padding(
                padding: EdgeInsets.all(50),
                child: Icon(Icons.chat_bubble_rounded, size: 100),
              ),
              const Image(image: AssetImage('assets/icon.svg')),
              Padding(
                padding: EdgeInsets.all(30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Situations()),
                    );
                  },
                  child: const Text('Začít', style: TextStyle(fontSize: 40)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Situations()),
                    );
                  },
                  child:
                      const Text('Můj přehled', style: TextStyle(fontSize: 40)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
