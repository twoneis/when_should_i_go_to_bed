import 'package:flutter/material.dart';

import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

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
          Divider(),
          FlatButton
          (
            child: Text("View Sources"),
            onPressed: () 
            {
              showDialog
              (
                context: context,
                child: ListView
                (
                  padding: const EdgeInsets.all(20.0),
                  children: <Widget>
                  [
                    Card
                    (
                      child: Column
                      (
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>
                        [
                          ButtonTheme.bar
                          (
                            child: ButtonBar
                            (
                              children: <Widget>
                              [
                                CloseButton()
                              ],
                            ),
                          ),
                          ListTile
                          (
                            title: Linkify
                            (
                              text: "How much sleep do you need at which age? https://www.sleepfoundation.org/excessive-sleepiness/support/how-much-sleep-do-we-really-need",
                              onOpen: (url) async
                              {
                                if (await canLaunch(url))
                                {
                                  await launch(url);
                                }
                              },
                            ),
                          ),
                          ListTile
                          (
                            title:Linkify
                            (
                              text: "Do Women need more sleep than men? https://www.sleepfoundation.org/articles/do-women-need-more-sleep-men",
                              onOpen: (url) async
                              {
                                if (await canLaunch(url))
                                {
                                  await launch(url);
                                }
                              },
                            )
                          ),
                          ListTile
                          (
                            title: Text("All datas are only based on my resarch and are average value. I'm just a normal guy trying to help others to sleep enough. If you need exact datas on how long you need to sleep, you may consider asking a doctor. Again, this data will not apply to anyone and are just average values."),
                          )
                        ],
                      ),
                    )
                  ],
                )
              );
            },
          )
        ],
      )
    );
  }
}