import 'package:flutter/material.dart';
import 'package:todoApp/main.dart';
import 'package:todoApp/widgets/login-page.dart';

import '../models/global.dart';
import '../widgets/intray-page.dart';

class MyHomePage extends StatefulWidget {
  final String jwt;
  MyHomePage(this.jwt);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      color: Colors.grey,
      home: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: new Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: new TabBar(
                tabs: [
                  Tab(
                    icon: new Icon(Icons.calendar_today),
                  ),
                  Tab(
                    icon: new Icon(Icons.add),
                  ),
                  Tab(
                    icon: new Icon(Icons.list),
                  ),
                ],
                labelColor: darkGreyColor,
                unselectedLabelColor: Colors.black26,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.transparent,
              ),
              backgroundColor: Colors.white,
            ),
            body: Stack(
              children: <Widget>[
                TabBarView(
                  children: [
                    IntrayPage.fromBase64(widget.jwt),
                    new Container(
                      color: Colors.orange,
                    ),
                    new Container(
                      color: Colors.lightGreen,
                    ),
                  ],
                ),
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Intray',
                          style: intryTitleStyle,
                        ),
                        Container()
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 132,
                    left: (MediaQuery.of(context).size.width * 0.5 - 30),
                  ),
                  child: FloatingActionButton(
                    child: Icon(
                      Icons.exit_to_app,
                      size: 20, // 40, add
                    ),
                    backgroundColor: redColor,
                    onPressed: () {
                      setState(()  {
                        storage.delete(key: 'jwt');
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(storage),
                          ),
                        );
                    },
                  ),
                )
              ],
            ),
            backgroundColor: darkGreyColor,
          ),
        ),
      ),
    );
  }
}
