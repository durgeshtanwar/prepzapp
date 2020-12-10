import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.pink,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String stringResponce;
  List listResponse;
  Future fetchData() async {
    String username = 'admin';
    String password = '1234';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);

    http.Response res;
    res = await http.get(
        'http://prepzapp.com/api_v1/api/categories?X-API-KEY=Arshu@%23123',
        headers: <String, String>{'authorization': basicAuth});
    if (res.statusCode == 200) {
      setState(() {
        listResponse = json.decode(res.body);
      });
    }
    print(res.body);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(
              Icons.sort,
              color: Colors.pink[50],
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          ),
          InkWell(child: Icon(Icons.more_vert, color: Colors.black))
        ],
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: Text(
          'PrepzApp',
          style: TextStyle(
            fontFamily: 'Archivo Black',
            fontWeight: FontWeight.bold,
            color: Colors.pink[50],
          ),
        ),
      ),
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200.0,
              width: double.infinity,
              child: Carousel(
                images: [
                  NetworkImage(
                      'https://images.unsplash.com/photo-1488998427799-e3362cec87c3?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'),
                  NetworkImage(
                      'https://images.unsplash.com/photo-1513258496099-48168024aec0?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1350&q=80'),
                  NetworkImage(
                      "https://images.unsplash.com/photo-1531545514256-b1400bc00f31?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1267&q=80")
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                'Enrolled Tests',
                textAlign: TextAlign.left,
                style: TextStyle(fontFamily: 'Archivo Black'),
              ),
            ),
            Upper_cards(),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                'Categories',
                textAlign: TextAlign.left,
                style: TextStyle(fontFamily: 'Archivo Black'),
              ),
            ),
            Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Card(
                          elevation: 5,
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            leading: Image.network(
                                'https://www.sentinelassam.com/wp-content/uploads/2019/05/goii.jpg'),
                            title: Text(listResponse[index]['category_name']),
                            subtitle:
                                Text(listResponse[index]['category_name_hi']),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.edit),
                                color: Colors.black),
                          ),
                        )
                      ],
                    );
                  },
                  itemCount: listResponse == null ? 0 : listResponse.length,
                )
              ],
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.pink),
              accountName: Text('Durgesh Tanwar'),
              accountEmail: Text('durgeshtanwar@yahoo.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=634&q=80'),
              ),
            ),
            ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title: Text('Home'),
                subtitle: Text('Explore tests'),
                trailing: Icon(Icons.edit, color: Colors.black),
                onLongPress: () {},
                onTap: () {}),
            ListTile(
                leading: Icon(Icons.email),
                title: Text('tanwardurgesh@gmail.com'),
                subtitle: Text('My Email Id'),
                trailing: Icon(Icons.edit),
                onTap: () {})
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 5,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.amber,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.speaker_notes),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Notes',
          ),
        ],
      ),
    );
  }
}

class Upper_cards extends StatelessWidget {
  const Upper_cards({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
              elevation: 3,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.red, Colors.yellow, Colors.teal],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.sanitizer,
                    size: 36,
                    color: Colors.white,
                  ),
                  title: Text('SSC Exam'),
                  subtitle: Text("4 September"),
                ),
              )),
        ),
        Expanded(
          child: Card(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.red, Colors.yellow, Colors.amber])),
              child: ListTile(
                leading: Icon(Icons.sanitizer),
                title: Text('SSC Exam'),
                subtitle: Text("Indian People"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
