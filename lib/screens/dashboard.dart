// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bytebank/screens/contacts.dart';
import 'package:flutter/material.dart';

import 'transfers.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Dashboard'),
      ),
      body: ListView(
        // addRepaintBoundaries: true,
        // reverse: true,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'APP DE BANCO',
                  style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'Baloo',
                      fontWeight: FontWeight.w700),
                ),
                Image.network(
                    'https://http2.mlstatic.com/D_NQ_NP_717215-MLB32692765306_102019-O.jpg'),
              ],
            ),
          ),
          DashboardMenu()
        ],
      ),
    );
  }
}

class DashboardMenu extends StatelessWidget {
  const DashboardMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: GridView.count(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        children: [
          MenuCard(icon: Icons.people, name: 'Contacts', route: Contacts()),
          MenuCard(
            icon: Icons.history_edu,
            name: 'Transfers',
            route: Transfers(),
          ),
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Widget route;
  const MenuCard(
      {Key? key, required this.name, required this.icon, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          radius: 25.0,
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => route));
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(icon, color: Colors.white, size: 32.0),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
