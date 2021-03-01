import 'package:flutter/material.dart';
import './bottom_tabs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import './purchaseUserform.dart';
class PurchaseScreen extends StatefulWidget {
  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
  static const routeName = 'purchase-screen';
}

class _PurchaseScreenState extends State<PurchaseScreen> {
    Future<void> _createPDF() async {
    //Create a PDF document.
    var document = PdfDocument();
    //Add page and draw text to the page.
    document.pages.add().graphics.drawString(
        'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 18),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: Rect.fromLTWH(0, 0, 500, 30));
    //Save the document
    var bytes = document.save();
    // Dispose the document
    document.dispose();
    //Get external storage directory
    Directory directory = await getExternalStorageDirectory();
//Get directory path
    String path = directory.path;
//Create an empty file to write PDF data
    File file = File('$path/Output.pdf');
//Write PDF data
    await file.writeAsBytes(bytes, flush: true);
//Open the PDF document in mobile
    OpenFile.open('$path/Output.pdf');
  }
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Colors.black,
    //   floatingActionButtonLocation:
    //       FloatingActionButtonLocation.miniCenterFloat,
    //   floatingActionButton: Container(
    //     decoration: BoxDecoration(
    //         border: Border.all(),
    //         color: Colors.white,
    //         borderRadius: BorderRadius.circular(30)),
    //     margin: EdgeInsets.symmetric(vertical: 10),
    //     width: MediaQuery.of(context).size.width * 0.5,
    //     child: FlatButton(
    //         padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
    //         child: Text(
    //           "ADD NEW RECORD",
    //           style: TextStyle(color: Colors.orange),
    //         ),
    //         onPressed: () {
    //           //Navigator.of(context).pushNamed(LoginUser.routeName);
    //         }),
    //   ),
    //   body: Container(
    //       child: Center(
    //           child: FlatButton(
    //     onPressed: () {
    //       return Navigator.of(context)
    //           .push(MaterialPageRoute(builder: (builder) => MakePdf()));
    //     },
    //     child: null,
    //   ))),
    //   bottomNavigationBar: BottomTabs(2),
    // );
        final User currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.orange[600], title: Text('Purchases')),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
            border: Border.all(),
            color: Colors.white,
            borderRadius: BorderRadius.circular(30)),
        margin: EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width * 0.4,
        child: FlatButton(
            //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text(
              "ADD NEW RECORD",
              style: TextStyle(color: Colors.orange),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(PurchaseUserForm.routeName);
            }),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .collection('purchases')
            .orderBy('date')
            .snapshots()
            ,
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            );
          }
          final userData = streamSnapshot.data;
          // print(userData);
          // print(userData.docs.length);
          // print("yo boy");
          return ListView.builder(
              itemCount: userData.docs.length,
              itemBuilder: (ctx, index) {
                var totalPrice = 0;
                final doc = userData.docs[index];
                for (int i = 0; i < doc["prices"].length; i++) {
                  totalPrice += int.parse(doc["prices"][i]);
                }
               return ListTile(
                  tileColor: Colors.black45,
                  onTap: _createPDF,
                  title: Text('Bill against : '+
                    doc["company"],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  subtitle:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doc["date"], style: TextStyle(color: Colors.white)),
                          Text('Tap to view details',style: TextStyle(color: Colors.white)),
                          SizedBox(height: 5,),
                          Divider(color: Colors.orange,height: 5,),
                          SizedBox(height: 10,),
                        ],
                      ),
                  trailing: 
                   
                      Text("Rs. ${totalPrice.toString()}",
                          style:
                              TextStyle(color: Colors.orange[600], fontSize: 20)),
                              
                        
                    
                  
                );
              });
        },
      ),
      bottomNavigationBar: BottomTabs(2),
    );
  }
}
