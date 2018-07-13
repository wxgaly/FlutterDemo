import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SlideApp extends StatelessWidget {
  final List<String> items = new List<String>.generate(
      20,
      (i) => "Item ${i +
          1}");

  SlideApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Dismissing Items';

    return new MaterialApp(
      title: title,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return new Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify Widgets.
              key: new Key(item),
              // We also need to provide a function that will tell our app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                items.removeAt(index);

                Scaffold.of(context).showSnackBar(
                    new SnackBar(content: new Text("$item dismissed")));
              },
              // Show a red background as the item is swiped away
              background: new Container(
                color: Colors.white,
                child: Card(
                    color: Colors.green,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              "确定要删除吗?",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              "确定要删除吗?",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              child: new ListTile(title: new Text('$item')),
            );
          },
        ),
      ),
    );
  }
}

var slideApp = SlideApp();
