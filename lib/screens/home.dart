import 'package:chai_project/models/home_model.dart';
import 'package:chai_project/screens/detail.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final Map<String, dynamic> map;
  Home({Key key, this.map}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Explicit
  Map<String, dynamic> myMap;
  List<HomeModel> homeModels = [];

  // Method
  @override
  void initState() {
    super.initState();
    myMap = widget.map;
    // print('myMap ==>>>> $myMap');
    readUnderList();
  }

  Future<void> readUnderList() async {
    Map mapd = myMap['d'];
    Map mapData = mapd['data'];
    var response = mapData['underList'];
    // print('response = $response');

    for (var result in response) {
      // print('useCode = ${result['userCode']}');
      String userCode = result['userCode'];

      Map mtdMap = result['MTD'];
      double mtdSumScore = mtdMap['sumScore'];

      HomeModel homeModel = HomeModel(userCode, mtdSumScore);
      setState(() {
        homeModels.add(homeModel);
      });
    }
  }

  Widget showListView() {
    return ListView.builder(
      itemCount: homeModels.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: showContent(index),
          onTap: () {
            MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => Detail(homeModel: homeModels[index],));
            Navigator.of(context).push(materialPageRoute);
          },
        );
      },
    );
  }

  Widget showUserCode(int index) {
    return Row(
      children: <Widget>[
        Text(homeModels[index].userCode),
      ],
    );
  }

  Widget showMtdSumScore(int index) {
    return Text(
      'MTD ==>> ${homeModels[index].mtdSumScore}',
      style: TextStyle(color: Colors.red),
    );
  }

  Widget showContent(int index) {
    return Column(
      children: <Widget>[
        showUserCode(index),
        showMtdSumScore(index),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: showListView(),
    );
  }
}
