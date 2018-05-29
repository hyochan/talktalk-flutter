import 'package:flutter/material.dart';
import '../utils/localization.dart';
import '../shared/btn.dart';
import '../utils/theme.dart' as Theme;

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }


  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(children: <Widget>[
          Expanded(child:
            Container(child:
              Row(children: <Widget>[
                Expanded(child:
                  Btn(
                    image: Image(
                      image: Theme.Icons.icThumbMan,
                      width: 40.0,
                      height: 40.0,
                    ),
                    txt: 'Hello',
                    center: false,
                    color: Colors.white,
                    onPress: () {
                      print('profile click');
                    },
                    height: 60.0,
                    fontSize: 16.0,
                    txtMargin: const EdgeInsets.only(left: 60.0),
                    margin: const EdgeInsets.only(left: 0.0, right: 6.0),
                    border: false,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/search_user',
                    );
                  },
                ),
              ]),
            ),
          ),
        ]),
        elevation: 0.0,
        titleSpacing: 0.0,
        brightness: Brightness.light,
      ),
      body: Column(children: <Widget>[
        TabBar(
          controller: tabController,
          tabs: [
            Tab(
              child: Row(
                children: <Widget>[
                  Text(localization.trans('FRIEND')),
                  Text('  4'),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            Tab(
              child: Row(
                children: <Widget>[
                  Text(localization.trans('MESSAGE')),
                  Text('  11'),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ],
          labelColor: Color.fromRGBO(102, 134, 205, 1.0),
          indicatorColor: Color.fromRGBO(200, 109, 215, 1.0),
        ),
        Expanded(child:
          TabBarView(
            controller: tabController,
            children: [
              Icon(Icons.android),
              Icon(Icons.accessibility),
            ],
          ),
        ),
      ]),
    );
  }
}