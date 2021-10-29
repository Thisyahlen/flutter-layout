import 'dart:convert';

import 'package:exercise4/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: ReadJsonData(),
      builder: (context, data) {
        if (data.hasError) {
          return Text("${data.error}");
        } else if (data.hasData) {
          var items = data.data as List<UserData>;
          return ListView.builder(itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.cyan,
                      ),
                      child: 
                      Image(
                        image: NetworkImage(items[index].avatar.toString()),
                        fit: BoxFit.fill,
                        
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              items[index].last_seen_time.toString(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8, right: 8),
                            child: Text(
                              '${items[index].first_name.toString()} ${items[index].last_name.toString()}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 2),
                            child: Text(
                              items[index].username.toString(), style: TextStyle(
                                fontSize:16,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 2),
                            child: Text(
                              items[index].status.toString(),style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                         Container(
                           child: Align(
                             alignment: (Alignment.bottomRight),
                             child: Text(
                                items[index].messages.toString(),
                             ),
                           ),
                         )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            );
          });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  Future<List<UserData>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('jsonfile/users.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => UserData.fromJson(e)).toList();
  }
}
