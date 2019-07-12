import 'package:flutter/material.dart';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:when_should_i_go_to_bed/appbar.dart';

import 'main.dart';

class Settings extends StatelessWidget
{
  bool _theme = false;

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
      body: ListView
      (
        children: <Widget>
        [
          SwitchListTile
          (
            title: Text("Enable dark theme"),
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (bool value) 
            {
              DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark? Brightness.light: Brightness.dark);
            },
          ),
        ],
      )
    );
  }
}