import 'package:flutter/material.dart';
import './purchaseForm.dart';
class PurchaseUserForm extends StatefulWidget {
  @override
  _PurchaseUserFormState createState() => _PurchaseUserFormState();
  static const routeName = 'purchase-user-form';
}

class _PurchaseUserFormState extends State<PurchaseUserForm> {
  var _datetime, companyName, companyAddress;
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.orange[600],
      title: Text("Company Details"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
                onChanged: (value) {
                  companyName = value;
                },
                controller: nameController,
                decoration: InputDecoration(labelText: 'Company Name')),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
                onChanged: (value) {
                  companyAddress = value;
                },
                controller: addressController,
                decoration: InputDecoration(labelText: 'Company Address')),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Text(
                  "Date:",
                  style: TextStyle(
                      color: Colors.deepPurple[400],
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                _datetime == null ? "Not chosen" : _datetime,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              RaisedButton(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  "Pick a date",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now())
                      .then((value) {
                    var date = DateTime.parse(value.toString());
                    var formattedDate =
                        "${date.day}-${date.month}-${date.year}";
                    setState(() {
                      _datetime = formattedDate;
                    });
                  });
                },
              ),
            ],
          ),
          RaisedButton(
              elevation: 10,
              color: Colors.black,
              child: Text('Add Entry', style: TextStyle(color: Colors.white)),
              onPressed: () {
                return Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (builder) =>
                        PurchaseForm(_datetime, companyName, companyAddress)));
              }),
        ],
      ),
    );
  }
}
