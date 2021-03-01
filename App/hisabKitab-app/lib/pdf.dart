import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class MakePdf extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MakePdfState createState() => _MakePdfState();
  static const routeName='pdf';
}

class _MakePdfState extends State<MakePdf> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text(
                'Generate PDF',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed:(){
                return _createPDF();
              } 
            )
          ],
        ),
      ),
    );
  }
}
