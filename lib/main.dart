import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:when_should_i_go_to_bed/AwesomeBottomNav/AwesomeBottomNavigationBar.dart';
 
import 'appbar.dart';
import 'settings.dart';

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
          home: new MyHomePage(title: 'Flutter Demo Home Page'),
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
  //declaring some later needed values
  int _genderValue;
  final TextEditingController ageInputController = new TextEditingController();
  final TextEditingController timeInputController = new TextEditingController();

  //functions

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


  //static UI
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
        icons: [
          Icons.brightness_3,
          Icons.hotel,
          Icons.wb_sunny,
        ],
            tapCallback: (int index) {
          
        },
          ),
      body: ListView
      (
        padding: const EdgeInsets.all(20.0),
        children: <Widget>
        [
          Card
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
                    controller: ageInputController,
                    keyboardType: TextInputType.number,
                  )
                ),
              ],
            ),
            elevation: 5,
          ),
        Card
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
            elevation: 5,
          ),
          Card
          (
            child: Column
            (
              mainAxisSize: MainAxisSize.min,
              children: <Widget>
              [
                ListTile
                (
                  title: Text("When do you want to get up?"),
                ),
                new DateTimePickerFormField
                (
                  inputType: InputType.time,
                  format: DateFormat("HH:mm"),
                  initialTime: TimeOfDay.now(),
                  decoration: InputDecoration
                  (
                    labelText: "Enter time here",
                    hasFloatingPlaceholder: false,
                  ),
                  controller: timeInputController,
                )
              ],
            ),
            elevation: 5,
          ),
          RaisedButton
          (
            child: Text("How long should I sleep?"),
            onPressed: ()
            {
              _calculateSleepTime(context, _genderValue, ageInputController, timeInputController);
            },
            color: Theme.of(context).primaryColor,
            elevation: 5,
          ),
        ],
      )
    );
  }

  void _calculateSleepTime(context, int genderValue, ageController, timeController)
  {
    int sleepTime;
    int age = int.parse(ageController.text);
    if (age <= 1)
    {
      sleepTime = 15;
    }
    else if (age <= 2)
    {
      sleepTime = 14;
    }
    else if (age <= 5)
    {
      sleepTime = 12;
    }
    else if (age <= 13)
    {
      sleepTime = 10;
    }
    else if (age <= 17)
    {
      sleepTime = 9;
    }
    else if (age <= 64)
    {
      sleepTime = 8;
    }
    else
    {
      sleepTime = 7;
    }

    if (genderValue == 1)
    {
      sleepTime += 1;
    }
    
    List<String> wakeTime = timeController.text.split(":");
    int wakeHours = int.parse(wakeTime[0]);
    int minutes = int.parse(wakeTime[1]);
    int dayhours = 24;
    int hours = wakeHours - sleepTime;

    if (hours < 0)
    {
      hours = dayhours += hours;
    }

    showModalBottomSheet
    (
      context: context,
      builder: (BuildContext bc)
      {
        return new Column
        (
          mainAxisSize: MainAxisSize.min,
          children: <Widget>
          [
            new ListTile
            (
              leading: new Icon(Icons.hourglass_full),
              title: new Text("You should sleep "+ sleepTime.toInt().toString() +" hours"),
            ),
            new ListTile
            (
              leading: new Icon(Icons.alarm),
              title: new Text("You should go to bed at " + hours.toString() + ":" + minutes.toString()),
              trailing: FlatButton
              (
                child: Icon(Icons.add_alarm),
                onPressed: ()
                {
                  
                },
              ),
            ),
            new Text("This app can not replace a medical advice.")
          ],
        );
      }
    );
  }
}