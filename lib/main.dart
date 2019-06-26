import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      title: 'Flutter Demo',
      theme: ThemeData
      (
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _genderValue;

  void _genderInputChanged(int value)
  {
    setState(() 
    {
      _genderValue = value;
    });
  }

  
  setGender(int value)
  {
    setState(() 
    {
      _genderValue = value;
    });
  }

  @override
  void initState()
  {
    super.initState();
    _genderValue = 0;
  }

  @override
  Widget build(BuildContext context) 
  {
    return ListView
    (
      padding: const EdgeInsets.all(20.0),
      children: <Widget>
      [
        Divider(),
        Container
        (
          child: Card
          (
            child: Column
            (
              mainAxisSize: MainAxisSize.min,
              children: <Widget>
              [
                const ListTile
                (
                  title: Text('How old are you?'),
                ),
                ButtonTheme.bar
                (
                  child: TextFormField
                  (
                    decoration: const InputDecoration
                    (
                      icon: Icon(Icons.hourglass_empty),
                      hintText: 'Enter your age here'
                    ),
                    keyboardType: TextInputType.number,
                  )
                ),
              ],
            ),
          ),
        ),
        Divider(),
        Container
        (
          child: Card
          (
            child: Column
            (
              mainAxisSize: MainAxisSize.min,
              children: <Widget>
              [
                const ListTile
                (
                title: Text("What's your gender?"),
                ),
                new RadioListTile
                (
                  value: 0,
                  groupValue: _genderValue,
                  title: Text("Male"),
                  onChanged: (value){_genderInputChanged(value);}
                ),
                new RadioListTile
                (
                  value: 1,
                  groupValue: _genderValue,
                  title: Text("Female"),
                  onChanged: (value){_genderInputChanged(value);}
                ),
                new RadioListTile
                (
                  value: 2,
                  groupValue: _genderValue,
                  title: Text("Other"),
                  onChanged: (value){_genderInputChanged(value);}
                )
              ],
            ),
          ),
        ),
        Divider(),
        RaisedButton
        (
          child: Text("How long should I sleep?"),
          onPressed: ()
          {

          },
          color: Colors.teal,
        )
      ],
    );
  }
}
