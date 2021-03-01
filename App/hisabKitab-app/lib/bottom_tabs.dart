// import 'package:flutter/material.dart';
// import './analytics.dart';
// import './profile.dart';
// import './sales.dart';
// import './purchase.dart';
// class BottomTabs extends StatefulWidget {
//      int currentIndex=2 ;
//   BottomTabs(this.currentIndex);
//   @override
//   _BottomTabsState createState() => _BottomTabsState();

// }

// class _BottomTabsState extends State<BottomTabs> {
 
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: widget.currentIndex,
//       items: [
//         BottomNavigationBarItem(
//           label: "Analytics",
//           icon: Icon(Icons.analytics),
//           //backgroundColor: kPrimaryColor,
//           backgroundColor:Colors.black
//         ),
//         BottomNavigationBarItem(
//           label:"Sales",
//           icon: Icon(Icons.circle),
//           //backgroundColor: kPrimaryColor,
//           backgroundColor:Colors.black
//         ),
//         BottomNavigationBarItem(
//           label: "Purchase",
//           icon: Icon(Icons.circle),
//           backgroundColor:Colors.black
//         ),
//         BottomNavigationBarItem(
//           label: "Profile",
//           icon: Icon(Icons.person),
//           //backgroundColor: kPrimaryColor,
//           backgroundColor:Colors.black
//         ),
//       ],
//       onTap: (index) {
//         setState(() {
//           widget.currentIndex = index;
//         });
//         switch (widget.currentIndex) {
//           case 0:
//             setState(() {
//               Navigator.of(context).pushNamed(AnalyticsScreen.routeName);
//             });
//             break;
//           case 1:
//            setState(() {
//               Navigator.of(context).pushNamed(SalesScreen.routeName);
//             });
//           break;
//           case 2:
//           print("here");
//           setState(() {
//               Navigator.of(context).pushNamed(PurchaseScreen.routeName);
//             });
//             break;
//           case 3:
//           setState(() {
//               Navigator.of(context).pushNamed(ProfileScreen.routeName);
//             });
//             break;
//         }
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import './analytics.dart';
import './profile.dart';
import './sales.dart';
import './purchase.dart';

class BottomTabs extends StatefulWidget {
  int currentIndex = 2;
  BottomTabs(this.currentIndex);
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      items: [
        BottomNavigationBarItem(
            label: "Analytics",
            icon: Icon(Icons.analytics),
            //backgroundColor: kPrimaryColor,
            backgroundColor: Colors.black),
        BottomNavigationBarItem(
            label: "Sales",
            icon: Icon(Icons.monetization_on_outlined),
            //backgroundColor: kPrimaryColor,
            backgroundColor: Colors.black),
        BottomNavigationBarItem(
            label: "Purchase",
            icon: Icon(Icons.wallet_travel_rounded),
            backgroundColor: Colors.black),
        BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
            //backgroundColor: kPrimaryColor,
            backgroundColor: Colors.black),
      ],
      onTap: (index) {
        setState(() {
          widget.currentIndex = index;
        });
        switch (widget.currentIndex) {
          case 0:
            setState(() {
              Navigator.of(context).pushNamed(AnalyticsScreen.routeName);
            });
            break;
          case 1:
            setState(() {
              Navigator.of(context).pushNamed(SalesScreen.routeName);
            });
            break;
          case 2:
            print("here");
            setState(() {
              Navigator.of(context).pushNamed(PurchaseScreen.routeName);
            });
            break;
          case 3:
            setState(() {
              Navigator.of(context).pushNamed(ProfileScreen.routeName);
            });
            break;
        }
      },
    );
  }
}
