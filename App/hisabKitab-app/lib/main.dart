// import 'screens/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './signup.dart';
import './signupuser.dart';
import './loginuser.dart';
import './analytics.dart';
import './purchase.dart';
import './sales.dart';
import './profile.dart';
import './sales_user_form.dart';
import './pdf.dart';
import './purchaseUserform.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'hisabKitab',
      home: SignupScreen(),
      routes: {
        SignUpUser.routeName: (ctx) => SignUpUser(),
        LoginUser.routeName: (ctx) => LoginUser(),
        AnalyticsScreen.routeName: (ctx) => AnalyticsScreen(),
        SalesScreen.routeName: (ctx) => SalesScreen(),
        PurchaseScreen.routeName: (ctx) => PurchaseScreen(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
        SalesUserForm.routeName: (ctx) => SalesUserForm(),
        MakePdf.routeName:(ctx)=>MakePdf(),
        PurchaseUserForm.routeName:(ctx)=>PurchaseUserForm(),
      },
    );
  }
}
