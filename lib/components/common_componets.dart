import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonComponents {
  Widget userNotificationsView(int index) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.1),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/logo.png'),
          ),
          title: Text('Notification ' + index.toString()),
          subtitle: Text('SubTitle ' + index.toString()),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {},
          onLongPress: () {},
        ));
  }
}