import 'package:balbu1/app_export.dart';

class ListRecords extends StatelessWidget {
  ListRecords({Key? key}) : super(key: key);
  Database database = Get.find();

  @override
  Widget build(BuildContext context) {
    final Future<List<Recording>> _recs = Recording.getRecordings(database);
    return Scaffold(
      appBar: AppBar(title: Text('Mé nahrávky')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FutureBuilder(
              future: _recs,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Recording>> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, i) {
                      return recordButton(snapshot.data![i]);
                    },
                  );
                } else {
                  return Center(
                    child: Text('Zatím nemáte žádnou nahrávku'),
                  );
                }
              }),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: Size.fromWidth(200)),
                    onPressed: () {
                      Get.toNamed('/situations');
                    },
                    child: const Text('Začít', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
