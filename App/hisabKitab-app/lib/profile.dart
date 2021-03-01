import 'package:flutter/material.dart';
import './bottom_tabs.dart';
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
   static const routeName='profile-screen';
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Text("PROFILE")
          )
          ),
          bottomNavigationBar: BottomTabs(3),
          );
  }
}
