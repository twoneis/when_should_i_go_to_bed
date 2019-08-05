import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(Normal());

class Normal extends StatefulWidget
{
  @override
  _NormalState createState() => _NormalState();
}

class _NormalState extends State<Normal>
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

    showModalBottomSheet
    (
      context: context,
      builder: (BuildContext bc)
      {
        return new Container
        (
          color: Color(0xFF737373),
          child: new Container
          (
            decoration: new BoxDecoration
            (
              color: Colors.white,
              borderRadius: new BorderRadius.only
              (
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0)
              )
            ),
            child: new Column
            (
              mainAxisSize: MainAxisSize.min,
              children: <Widget>
              [
                new ListTile
                (
                  leading: new Icon(Icons.hourglass_full),
                  title: new Text("You should sleep "+ sleepTime.toInt().toString() +" hours"),
                ),
                new Text("This app can not replace a medical advice.")
              ],
            )
          )
        );
      }
    );  
  }


  @override
  Widget build(BuildContext context) 
  {
    return new ListView
    (
      padding: const EdgeInsets.all(20.0),
      children: <Widget>
      [
        Card
        (
          shape: RoundedRectangleBorder
          (
              borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding
          (
            padding: EdgeInsets.all(8.0),
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
                  ),
                ),
              ],
            ),
          ),
          elevation: 5,
        ),
        Card
        (
          shape: RoundedRectangleBorder
          (
              borderRadius: BorderRadius.circular(10.0),
          ),
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
        RaisedButton
        (
          shape: RoundedRectangleBorder
          (
              borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text("How long should I sleep?"),
          onPressed: ()
          {
            _calculateSleepTime(context, _genderValue, ageInputController, timeInputController);
          },
          color: Theme.of(context).primaryColor,
          elevation: 5,
        ),
      ],
    );
  }
  
}