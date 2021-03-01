import 'package:flutter/material.dart';
// import './background.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import './signupuser.dart';
import './loginuser.dart';
class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.1,
            ),
            
            Image.asset('assets/images/logo.png'),
            Center(child: Text(' Simple GST Billing and Stock management software.',style:TextStyle(color:Colors.white,fontStyle: FontStyle.italic)),),
            SizedBox(
              height: size.height * 0.05,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(border: Border.all(),color: Colors.white,borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child:  FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.orange),
                    ),
                    onPressed: (){
                      Navigator.of(context).pushNamed(LoginUser.routeName);
                    }
                  ),
                
              ),
            ),
           Center(
              child: Container(
                decoration: BoxDecoration(border: Border.all(),color: Colors.white,borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child:  FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    child: Text(
                      "SIGNUP",
                      style: TextStyle(color: Colors.orange),
                    ),
                    onPressed: (){
                      Navigator.of(context).pushNamed(SignUpUser.routeName);
                    },
                  ),
                
              ),
            ),

            // RoundedButton(
            //   text: "LOGIN",
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return LoginScreen();
            //         },
            //       ),
            //     );
            //   },
            // ),
            // RoundedButton(
            //   text: "SIGNUP",
            //   press: () {
            //     Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) {
            //         return SignUpScreen();
            //       },
            //     ),
            //   );
            //   },
            //   //color: kPrimaryLightColor,
            //   textcolor: Colors.black,
            // ),
          ],
        ),
      ),
    );
  }
}
