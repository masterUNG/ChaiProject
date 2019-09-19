import 'package:chai_project/models/home_model.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {

  final HomeModel homeModel;
  Detail({Key key, this.homeModel}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  HomeModel myHomeModel;

  @override
  void initState() { 
    super.initState();
    myHomeModel = widget.homeModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Text(myHomeModel.userCode),
    );
  }
}
