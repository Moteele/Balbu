import 'app_export.dart';

class Situations extends StatefulWidget {
  final Database db = Get.find();

  Situations({Key? key}) : super(key: key);
  @override
  _SituationsState createState() => _SituationsState();
}

class _SituationsState extends State<Situations> {
  Future<void> _addSituation(String name) async {
    if (name == "") return;
    setState(() {});
    await widget.db.transaction((txn) async {
      await txn.rawInsert("INSERT INTO situations(name) VALUES('$name')");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vyber situaci'),
      ),
      body: _buildSituations(),
    );
  }

  Widget _buildSituations() {
    int _count = 1;
    final Future<List<Situation>> _sits = sits(widget.db);
    return DefaultTextStyle(
        style: Theme.of(context).textTheme.headline2!,
        textAlign: TextAlign.center,
        child: FutureBuilder<List<Situation>>(
          future: _sits,
          builder:
              (BuildContext context, AsyncSnapshot<List<Situation>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              _count = (snapshot.data?.length ?? 0) + 1;
              return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _count,
                  itemBuilder: (context, i) {
                    if (i == snapshot.data?.length) {
                      return NewSituation(update: _addSituation);
                    }
                    return situationButton(snapshot.data![i], context);
                  });
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Na????t??m...'),
                )
              ];
            }
            return Center(
                child: Column(
              children: children,
            ));
          },
        ));
  }
}

class NewSituation extends StatefulWidget {
  final update;
  const NewSituation({Key? key, required this.update}) : super(key: key);
  @override
  _NewSituationState createState() => _NewSituationState();
}

class _NewSituationState extends State<NewSituation> {
  final _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.primary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    const InputDecoration.collapsed(hintText: 'Nov?? situace'),
              ),
            ),
            Container(
              //margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () => widget.update(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }
}
