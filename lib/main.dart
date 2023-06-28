import 'package:flutter/material.dart';
import 'pages/contact_datile_page.dart';
import 'pages/contact_list_page.dart';
import 'pages/new_contact_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactListPage(),
      routes: {
        ContactListPage.routeName : (context) => ContactListPage(),
        NewContactPage.routeName : (context) => NewContactPage(),
        ContactDatilePage.routeName : (context) => ContactDatilePage(),
      },
    );
  }
}

