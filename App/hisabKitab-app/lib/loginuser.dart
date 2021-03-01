import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import './analytics.dart';
class LoginUser extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
  static const routeName='login-screen';
}

class _LoginUserState extends State<LoginUser> {
  var _userEmail = '';
  var _userPassword = '';
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;
  bool loading = false ;
  void _userLogin(String email, String password, BuildContext ctx) async {
    UserCredential authResult;
    try{
       print("hi");
       authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
       
        //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext ctx) => HomeScreen(),));
        Navigator.of(context).pushReplacementNamed(AnalyticsScreen.routeName);
    }on PlatformException catch(err)
    {
      var message="An error occured";
      if(err.message!=null)
      {
        message=err.message;
        setState(() {
          loading = false;
        });
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(content:Text(message)));
    }catch(err)
    {
      print(err);
      Scaffold.of(ctx).showSnackBar(SnackBar(content:Text("Invalid Credentials !"), backgroundColor: Colors.black,));
      setState(() {
          loading = false;
        });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(height:80),
          Center(child: Text('Login to your account !',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
          SizedBox(height:20),
          Image.asset('assets/images/logo.png'),
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    initialValue: null,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        focusColor: Colors.black,
                        prefixIcon: Icon(Icons.email, color: Colors.black)),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    // onFieldSubmitted: (value) {
                    //   FocusScope.of(context).unfocus();
                    //   _userEmail = value;
                    //   FocusScope.of(context).unfocus();
                    // },
                    // onSaved: (value) {
                    //   _userEmail = value.trim();
                    // },
                     onChanged: (value) {
                      _userEmail = value;
                      if (value.isEmpty) {
                        return 'Please enter valid Name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height:20),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    initialValue: null,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      // suffixIcon: IconButton(
                      //     icon: Icon(Icons.visibility, color: Colors.black),
                      //     onPressed: null)
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    //obscureText: _showPwd,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _userPassword = value;
                      if (value.isEmpty) {
                        return 'Please enter valid Name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                isLoading
                    ? CircularProgressIndicator()
                    : Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(30)),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            child: Text(
                              "LOGIN",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                             _userLogin(_userEmail, _userPassword, context);
                            }),
                      ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
