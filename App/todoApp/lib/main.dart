import 'package:flutter/material.dart';

import './models/global.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
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
                    new Container(
                      color: darkGreyColor,
                    ),
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
                      Icons.add,
                      size: 40,
                    ),
                    backgroundColor: redColor,
                    onPressed: () {},
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
