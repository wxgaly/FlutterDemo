import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

var httpClientApp = HttpClientApp();

class HttpClientPage extends StatefulWidget {
  HttpClientPage({Key key}) : super(key: key);

  @override
  _HttpClientPageState createState() => new _HttpClientPageState();
}

class _HttpClientPageState extends State<HttpClientPage> {
  User _user;

  @override
  void initState() {
    super.initState();
    print("initState");
    _readUser();
  }

  _readUser() async {
    var url = 'http://192.168.0.4:8080/api/user';
    var httpClient = new HttpClient();

    User result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var value =
            await response.transform(utf8.decoder.fuse(json.decoder)).first;

        result = User.fromJson(value);
      } else {
        print('Error getting user info :\nHttp status ${response.statusCode}');
      }
    } catch (exception) {
      print('Failed getting user info : $exception');
    }

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;

    setState(() {
      _user = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    var spacer = SizedBox(height: 32.0);

    return new Scaffold(
      appBar: AppBar(title: new Text('HttpClient Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('the user info is:'),
            Text('${_user.toString()}'),
            spacer,
            RaisedButton(
              onPressed: _readUser,
              child: new Text('Get user info'),
            ),
          ],
        ),
      ),
    );
  }
}

class HttpClientApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'HttpClientApp',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HttpClientPage(),
    );
  }
}

class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };

  @override
  String toString() {
    return "{name: $name,\nemail$email}";
  }
}
