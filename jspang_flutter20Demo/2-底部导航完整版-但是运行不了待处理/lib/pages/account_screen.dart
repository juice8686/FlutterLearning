import 'package:flutter/material.dart';


class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account'),),
      body: Center(
        child: Text('Account', style:TextStyle(color: Colors.blue)),
      ),
    );
  }
}