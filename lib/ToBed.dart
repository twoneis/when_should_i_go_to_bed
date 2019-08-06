import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

void main() => runApp(ToBed());

class ToBed extends StatefulWidget {
  @override
  _GetUpState createState() => _GetUpState();
}

class _GetUpState extends State<ToBed> {
  //declaring some later needed values
  int _genderValue;
  final TextEditingController ageInputController = new TextEditingController();
  final TextEditingController timeInputController = new TextEditingController();

  //functions

  void _genderInputChanged(int value) {
    setState(() {
      _genderValue = value;
    });
  }

  setGender(int value) {
    setState(() {
      _genderValue = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _genderValue = 0;
  }

  void _calculateSleepTime(
      context, int genderValue, ageController, timeController) {
    int sleepTime;
    int age = int.parse(ageController.text);
    if (age <= 1) {
      sleepTime = 15;
    } else if (age <= 2) {
      sleepTime = 14;
    } else if (age <= 5) {
      sleepTime = 12;
    } else if (age <= 13) {
      sleepTime = 10;
    } else if (age <= 17) {
      sleepTime = 9;
    } else if (age <= 64) {
      sleepTime = 8;
    } else {
      sleepTime = 7;
    }

    if (genderValue == 1) {
      sleepTime += 1;
    }

    List<String> bedTime = timeController.text.split(":");
    int bedHours = int.parse(bedTime[0]);
    int minutes = int.parse(bedTime[1]);
    int dayhours = 24;
    int hours = bedHours + sleepTime;

    if (hours > 24) {
      hours = hours -= dayhours;
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return new Container(
          color: Color(0xFF737373),
          child: new Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0))),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.hourglass_full),
                  title: new Text("You should sleep " +
                      sleepTime.toInt().toString() +
                      " hours"),
                ),
                new ListTile(
                  leading: new Icon(Icons.alarm),
                  title: new Text("You should get up at " +
                      hours.toString() +
                      ":" +
                      minutes.toString()),
                  trailing: FlatButton(
                    child: Icon(Icons.add_alarm),
                    onPressed: () {},
                  ),
                ),
                new ListTile (
                  subtitle: new Text("This app can not replace a medical advice."),
                )
              ],
            )
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  title: Text('How old are you?'),
                ),
                ButtonTheme.bar(
                  child: TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.hourglass_empty),
                        hintText: 'Enter your age here'),
                    controller: ageInputController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          elevation: 5,
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                title: Text("What's your gender?"),
              ),
              new RadioListTile(
                  value: 0,
                  groupValue: _genderValue,
                  title: Text("Male"),
                  onChanged: (value) {
                    _genderInputChanged(value);
                  }),
              new RadioListTile(
                  value: 1,
                  groupValue: _genderValue,
                  title: Text("Female"),
                  onChanged: (value) {
                    _genderInputChanged(value);
                  }),
              new RadioListTile(
                  value: 2,
                  groupValue: _genderValue,
                  title: Text("Other"),
                  onChanged: (value) {
                    _genderInputChanged(value);
                  })
            ],
          ),
          elevation: 5,
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text("When do you want to go to bed?"),
              ),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new DateTimePickerFormField(
                    inputType: InputType.time,
                    format: DateFormat("HH:mm"),
                    initialTime: TimeOfDay.now(),
                    decoration: InputDecoration(
                      labelText: "Enter time here",
                      hasFloatingPlaceholder: false,
                    ),
                    controller: timeInputController,
                  )),
            ],
          ),
          elevation: 5,
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text("How long should I sleep?"),
          onPressed: () {
            if (ageInputController.text.isEmpty == true) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                          "Looks like you forgot to enter your age. Please enter it and try again."),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            } else if (timeInputController.text.isEmpty == true) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(
                        "Looks like you forgot to enter the time. Please enter it and try again."),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }
              );
            } else {
              _calculateSleepTime(context, _genderValue, ageInputController, timeInputController);
            }
          },
          color: Theme.of(context).primaryColor,
          elevation: 5,
        ),
      ],
    );
  }
}
