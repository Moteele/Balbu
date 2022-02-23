import 'app_export.dart';

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
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          minimumSize: Size.fromWidth(200)),
                      onPressed: () {
                        Get.toNamed('/situations');
                      },
                      child:
                          const Text('Začít', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: Size.fromWidth(200),
                      ),
                      onPressed: () {
                        Get.toNamed('/listRecords');
                      },
                      child: const Text('Můj přehled',
                          style: TextStyle(fontSize: 20)),
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
