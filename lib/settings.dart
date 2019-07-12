import 'package:flutter/material.dart';
import 'package:when_should_i_go_to_bed/appbar.dart';

import 'main.dart';

class Settings extends StatelessWidget
{
  @override
  Widget build(BuildContext context) 
  {  
    return Scaffold
    (
      appBar: TopBar
      (
        title: "Settings",
        child: Icon(Icons.arrow_back_ios),
        onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
        },
      ),
    );
  }
}