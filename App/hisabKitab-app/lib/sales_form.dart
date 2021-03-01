import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SalesForm extends StatefulWidget {
  final datetime, companyName, companyAddress;
  SalesForm(this.datetime, this.companyName, this.companyAddress);
  @override
  _SalesFormState createState() => _SalesFormState();
  static const routeName = 'sales-form';
}

class _SalesFormState extends State<SalesForm> {
  var companyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Sale Details'),
          backgroundColor: Colors.orange[600],
        ),
        body: SOF(widget.datetime, widget.companyName, widget.companyAddress));
  }
}

class SOF extends StatefulWidget {
  var datetime, companyName, companyAddress;
  SOF(this.datetime, this.companyName, this.companyAddress);
  @override
  _SOFState createState() => _SOFState();
}

class _SOFState extends State<SOF> {
  var nameTECs = <TextEditingController>[];
  var priceTECs = <TextEditingController>[];
  var quantityTECs = <TextEditingController>[];
  var cards = <Card>[];
  var userData, currentUser;
  int currentValue = 2;
  Card createCard() {
    var nameController = TextEditingController();
    var priceController = TextEditingController();
    var quantityController = TextEditingController();

    nameTECs.add(nameController);
    priceTECs.add(priceController);
    quantityTECs.add(quantityController);
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      // color: Colors.orange[100],
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              child: Text('Item ${cards.length + 1}',
                  style: TextStyle(
                      color: Colors.orange[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 18))),
                    
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
                style: TextStyle(color: Colors.white),
                controller: nameController,
                decoration: InputDecoration(
                    labelText: 'Item Name',
                    labelStyle: TextStyle(color: Colors.white))),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                controller: priceController,
                decoration: InputDecoration(
                    labelText: 'Price',
                    labelStyle: TextStyle(color: Colors.white))),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                controller: quantityController,
                decoration: InputDecoration(
                    labelText: 'Quantity',
                    labelStyle: TextStyle(color: Colors.white))),
          ),
            // child: Row(

            //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Text(
            //       "Quantity",
            //       style: TextStyle(fontSize: 16,color: Colors.white),
            //     ),
            //     Container(
            //       height: 30,
            //       child: NumberPicker.integer(
            //         textStyle: TextStyle(color:Colors.orange[600],fontSize: 16),
            //         selectedTextStyle:TextStyle(color:Colors.white,fontSize: 24), 
            //         scrollDirection: Axis.horizontal,
            //         initialValue: currentValue,
            //         minValue: 1,
            //         maxValue: 10,
            //         onChanged: (value) {
            //           setState(() {
            //             print(currentValue);
            //             currentValue = value;
                        
            //           });
            //         },
            //       ),
            //     ),
            //   ],
            // ),
          
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    cards.add(createCard());
  }

  _onSubmit(List names, List prices, List quantities) async {
    currentUser = FirebaseAuth.instance.currentUser;
    // userData = await FirebaseFirestore.instance
    //                 .collection('users')
    //                 .doc(currentUser.uid)
    //                 .collection('sales')
    //                 .get();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('sales')
        .doc()
        .set({
      'items': names,
      'quantities': quantities,
      'prices': prices,
      'address': widget.companyAddress,
      'date': widget.datetime,
      'company': widget.companyName,
      // 'title': title,
      // 'tags': selectedList,
      // 'members': currentValue,
      // 'description': description,
      // 'startDate': DateFormat('MMM yyyy').format(selectedDate),
      // 'members_enrolled': 0,
      // 'started_by': userData['name'],
    });
  }

  _onDone() {
    List names = [];
    List prices = [];
    List quantities = [];
    List<ItemEntry> entries = [];
    for (int i = 0; i < cards.length; i++) {
      var name = nameTECs[i].text;
      var price = priceTECs[i].text;
      var quantity = quantityTECs[i].text;
      names.add(name);
      prices.add(price);
      quantities.add(quantity);
    }
    _onSubmit(names, prices, quantities);
    Navigator.pop(context, entries);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int index) {
                return cards[index];
              },
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: RaisedButton(
                  elevation: 10,
                  color: Colors.black,
                  child: Text('Add another entry',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () => setState(() => cards.add(createCard())),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done,color: Colors.orange[600],),
          onPressed: _onDone,
          backgroundColor: Colors.black),
    );
  }
}

class ItemEntry {
  final String name;
  final String price;
  final String quantity;

  ItemEntry(this.name, this.price, this.quantity);
  @override
  String toString() {
    return 'name= $name, price= $price, quantity= $quantity';
  }
}
