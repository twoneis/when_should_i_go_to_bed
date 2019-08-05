import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:when_should_i_go_to_bed/AwesomeBottomNav/AwesomeBottomNavigationBar.dart';
 
import 'appbar.dart';
import 'settings.dart';
import 'GetUp.dart';
import 'Normal.dart';
import 'ToBed.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
     return new DynamicTheme
     (
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData
      (
        primarySwatch: Colors.pink,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) 
      {
        return new MaterialApp
        (
          title: 'Bed Time',
          theme: theme,
          home: new MyHomePage(title: 'Bed Time'),
        );
      }
    );
  }
}

class MyHomePage extends StatefulWidget 
{
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> 
{
  PageController _pageController;
  int _selectedIndex = 1;

  @override
  void initState() 
  {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() 
  {
    super.dispose();
    _pageController.dispose();
  }
  
  @override
  Widget build(BuildContext context) 
  {
    return new Scaffold
    (
      appBar: TopBar
      (
        title: "Bed Time",
        child: Icon(Icons.settings),
        onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
        },
      ),
      bottomNavigationBar: AwesomeBottomNavigationBar
      (
        icons: 
        [
          Icons.brightness_3,
          Icons.hotel,
          Icons.wb_sunny,
        ],
        tapCallback: (int index) 
        {
          setState
          (() 
          {
            _selectedIndex = index;
          });
          _pageController.animateToPage(_selectedIndex, duration: const Duration(milliseconds: 300), curve: Curves.ease);
        },
        selectedIndex: _selectedIndex,
      ),
      body: PageView
      (
        children: <Widget>[GetUp(), Normal(), ToBed()],
        controller: _pageController,
      )
    );
  }
}