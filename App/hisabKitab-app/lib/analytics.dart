import 'package:flutter/material.dart';
import './bottom_tabs.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
  static const routeName = 'analytics-screen';
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
   Map<String,double> sales = {

   };
   Map<int,double> purch = {

   };
  double ts = 0;
  double tp = 0;
  var currentUser;
  var userData;
  List<_SalesData> data = [
    _SalesData('Jan', 350),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40),
    _SalesData('June', 40),
  ];

  Map<String, double> dataMap = {
    "Sales": 0,
    "Purchase": 0,
  };

  double sum(var a )
  {
    double ans=0;
  for(int i=0;i<a.length;i++){
          ans=ans+int.parse(a[i]);
          
        }
        return ans;
  }

  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .collection('sales')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        var x = result.data();
        print(x);
        print(x['date'][3]);
        print(sum(x['prices']));
        setState(() {
          print("hello");
             ts=ts+sum(x['prices']);
             print(ts);
             dataMap['Sales']=ts;
             
        });
      });
    });
        FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .collection('purchases')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        var x = result.data();
        print(x);
        setState(() {
             tp=tp+sum(x['prices']);
             dataMap['Purchase']=tp;
             
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Analysis'),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        //Initialize the chart widget
        SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(
                text: 'Monthly Purchase analysis',
                textStyle: TextStyle(fontWeight: FontWeight.bold)),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<_SalesData, String>>[
              LineSeries<_SalesData, String>(
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  name: 'Purchase',
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ]),
        Divider(
          color: Colors.black,
          height: 10,
        ),
        SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(
                text: 'Monthly sales analysis',
                textStyle: TextStyle(fontWeight: FontWeight.bold)),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<_SalesData, String>>[
              LineSeries<_SalesData, String>(
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  name: 'Sales',
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ]),
        Divider(
          color: Colors.black,
          height: 10,
        ),
        SizedBox(height: 20),
        Center(
          child: Text('Sales vs Purchase ',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 20),
        PieChart(
          dataMap: dataMap,
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width / 3.2,
          initialAngleInDegree: 0,
          chartType: ChartType.ring,
          ringStrokeWidth: 32,
          chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: true,
            showChartValuesInPercentage: false,
            showChartValuesOutside: false,
          ),
        ),
        SizedBox(height: 20),
      ])),
      bottomNavigationBar: BottomTabs(0),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
