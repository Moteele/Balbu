import 'package:balbu1/situations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';

import 'app_export.dart';
import 'db_header.dart';
import 'mood.dart';

class Welcome extends StatelessWidget {
  final Database db = Get.find();
  Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 100.0, left: 20, right: 20),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Vítám Tě\nv\naplikaci BALBU',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child:
                  const Image(image: AssetImage('assets/icon.png'), width: 200),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    height: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(), padding: EdgeInsets.all(10)),
                      onPressed: () {
                        Get.toNamed('/situations');
                      },
                      child:
                          const Text('Začít', style: TextStyle(fontSize: 30)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    height: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        Get.toNamed('/situations');
                      },
                      child: const Text('Můj přehled',
                          style: TextStyle(fontSize: 30)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
