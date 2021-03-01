import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import './analytics.dart';
class SignUpUser extends StatefulWidget {
  static const routeName = 'signupUser';
  @override
  _SignUpUserState createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  //final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  var _userEmail = '';
  var _userPassword = '';
  var _userName = '';
  var mobileNumber = '';
  var gstNum = '';
  var companyName = '';
  bool isLoading = false;
  void _buildUser(
      String email,
      String password,
      String name,
      String mobileNumber,
      String gst,
      String companyName,
      BuildContext ctx) async {
    UserCredential authResult;
    try {
      authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user.uid)
          .set({
        'name': name,
        'email': email,
        'password': password,
        'phone': mobileNumber,
        'gst':gst,
        'company':companyName,
      });
      // await FirebaseFirestore.instance.collection('users').doc(authResult.user.uid).collection('profile').doc(authResult.user.uid).set({
      //   'name':'Not set',
      //   'bio':'Not set',
      //   'gender':'Not set',
      //   'dateofbirth':'Not set',
      //   'institution':'Not set',
      //   'degree':'Not set',
      //   'skills':'Not set'
      // });
      Navigator.of(context).pushReplacementNamed(AnalyticsScreen.routeName);
    } on PlatformException catch (err) {
      var message = "An error occured";
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(message)));
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Image.asset('assets/images/logo.png'),
            Center(
              child: Text(' Simple GST Billing and Stock management software.',
                  style: TextStyle(
                      color: Colors.white, fontStyle: FontStyle.italic)),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
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
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person, color: Colors.black)),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _userName = value;
                      print(_userName);
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
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    initialValue: null,
                    decoration: InputDecoration(
                      labelText: 'Company Name',
                      prefixIcon: Icon(
                        Icons.work,
                        color: Colors.black,
                      ),
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      companyName = value;
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
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    initialValue: null,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        prefixIcon: Icon(Icons.phone, color: Colors.black)),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      mobileNumber = value;
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
                        prefixIcon: Icon(Icons.email, color: Colors.black)),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _userEmail = value;
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
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    initialValue: null,
                    decoration: InputDecoration(
                      labelText: 'GST Number',
                      prefixIcon: Icon(
                        Icons.code,
                        color: Colors.black,
                      ),
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      gstNum = value;
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
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            child: Text(
                              "SIGNUP",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              _buildUser(_userEmail, _userPassword, _userName,
                                  mobileNumber, gstNum, companyName, context);
                            }),
                      ),
              ],
            ),

            // FlatButton(
            //           padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            //           child: Text(
            //             "LOGIN",
            //             style: TextStyle(color: Colors.orange),
            //           ),
            //           onPressed:(){
            //             _buildUser("siddharthsshah1207@gmail.com","siddharth","Sid",context);
            //           }
            //         ),
          ]),
        )
        // body: Column(children: [
        //   Container(), //for some image
        //   Form(
        //     key: _formKey,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: <Widget>[
        //         SizedBox(
        //           height: MediaQuery.of(context).size.height * 0.16,
        //         ),
        //         Center(
        //             child: Text('Login to your account',
        //                 style: TextStyle(
        //                     fontWeight: FontWeight.bold, fontSize: 18))),
        //         SizedBox(
        //           height: MediaQuery.of(context).size.height * 0.09,
        //         ),
        //         TextFormField(
        //           initialValue: null,
        //           keyboardType: TextInputType.emailAddress,
        //           decoration: InputDecoration(
        //               labelText: 'Email',
        //               prefixIcon: Icon(Icons.email, color: Colors.black)),
        //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        //           textInputAction: TextInputAction.next,
        //           validator: (value) {
        //             if (value.isEmpty || !value.contains('@')) {
        //               return 'Please provide a value.';
        //             }
        //             return null;
        //           },
        //           onFieldSubmitted: (value) {
        //             FocusScope.of(context).unfocus();
        //             _userEmail = value;
        //             FocusScope.of(context).unfocus();
        //           },
        //           onSaved: (value) {
        //             _userEmail = value.trim();
        //           },
        //         ),
        //         TextFormField(
        //           initialValue: null,
        //           //controller: pwd,
        //           decoration: InputDecoration(
        //             labelText: 'Password',
        //             prefixIcon: Icon(
        //               Icons.lock,
        //               color: Colors.black,
        //             ),
        //             // suffixIcon: IconButton(
        //             //   icon: _showPwd
        //             //       ? Icon(
        //             //           Icons.visibility_off,
        //             //           color: Colors.black,
        //             //         )
        //             //       : Icon(Icons.visibility, color: Colors.black),
        //             //   onPressed: () => password(),
        //             // )
        //           ),
        //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        //           //obscureText: _showPwd,
        //           textInputAction: TextInputAction.next,
        //           validator: (value) {
        //             if (value.isEmpty) {
        //               return 'Please provide a value.';
        //             }
        //             return null;
        //           },
        //           onFieldSubmitted: (value) {
        //             FocusScope.of(context).unfocus();

        //             _userPassword = value.trim();
        //           },
        //           onSaved: (value) {
        //             _userPassword = value;
        //           },
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         isLoading
        //             ? CircularProgressIndicator()
        //             : Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                 children: <Widget>[
        //                   Container(
        //                     width: MediaQuery.of(context).size.width * 0.35,
        //                     decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(10),
        //                         color: Colors.black),
        //                     child: FlatButton(
        //                       // onPressed: () {
        //                       //   FocusScope.of(context).unfocus();
        //                       //   _buildUser(
        //                       //       _userEmail, _userPassword, "sid", context);
        //                       // },
        //                       child: Column(
        //                         //crossAxisAlignment: CrossAxisAlignment.center,
        //                         //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                         children: <Widget>[
        //                           Text('SignUp',
        //                               textAlign: TextAlign.center,
        //                               style: TextStyle(
        //                                   fontSize: 20,
        //                                   fontWeight: FontWeight.w800,
        //                                   color: Colors.white)),
        //                           SizedBox(height: 3),
        //                           /* Container(

        //                             child:
        //                                Text(
        //                                   'Continue Helping..',
        //                                   textAlign: TextAlign.center,
        //                                   style: TextStyle(
        //                                     fontSize: 12,
        //                                     color: Colors.white,
        //                                   ),
        //                                 ),
        //                           )*/
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Container(
        //           // width:MediaQuery.of(context).size.width*0.35,

        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(10),
        //               color: Colors.black),

        //           child: FlatButton(
        //             onPressed: () {
        //               FocusScope.of(context).unfocus();
        //               // Navigator.of(context)
        //               //     .push(MaterialPageRoute(builder: (ctx) => SignUp()));
        //             },
        //             child: Column(
        //               children: <Widget>[
        //                 Text('New user?',
        //                     textAlign: TextAlign.center,
        //                     style: TextStyle(
        //                         fontSize: 20,
        //                         fontWeight: FontWeight.w500,
        //                         color: Colors.white)),
        //                 SizedBox(width: 5),
        //                 Container(
        //                   child: Text(
        //                     'Create a new account.',
        //                     textAlign: TextAlign.center,
        //                     style: TextStyle(
        //                       fontSize: 12,
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //         // SignInButtons(),
        //       ],
        //     ),
        //   ),
        // ]),
        );
  }
}
