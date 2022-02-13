import 'package:balbu1/app_export.dart';
import 'package:balbu1/db_header.dart';

class ListRecords extends StatelessWidget {
  ListRecords({Key? key}) : super(key: key);
  Database database = Get.find();

  @override
  Widget build(BuildContext context) {
    final Future<List<Recording>> _recs = Recording.get_recordings(database);
    return Scaffold(
      body: FutureBuilder(
          future: _recs,
          builder:
              (BuildContext context, AsyncSnapshot<List<Recording>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, i) {
                  return Text(snapshot.data![i].toString());
                },
              );
            } else {
              return Center(
                child: Text('Zatím nemáte žádnou nahrávku'),
              );
            }
          }),
    );
  }
}
