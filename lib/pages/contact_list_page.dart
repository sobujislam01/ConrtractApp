import 'package:contactsapps/customwidget/contact_item.dart';
import 'package:contactsapps/db/sqlite_helper.dart';
import 'package:contactsapps/pages/new_contact_page.dart';
import 'package:flutter/material.dart';

import '../model/contact_model.dart';

class ContactListPage extends StatefulWidget {
  static const String routeName = '/contact_list';

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
   List<ContactModel> _ContactList=[];
  @override
  void initState() {
    _getData();
    super.initState();
  }
  void _getData(){
    DBHelper.getAllContacts().then((cList) {
      setState(() {
        _ContactList = cList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
        actions: [
          //IconButton(onPressed: (){}, icon: Icon(Icons.add)),
          Text(textAlign: TextAlign.center,'Save'),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
          itemCount:_ContactList.length ,
          itemBuilder: (context,index){
            final contact = _ContactList[index];
            return ContactItem(contact);
          }
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add a new contact',
          onPressed: ()async{
         final ContactModel? contact =  await Navigator.pushNamed(context, NewContactPage.routeName)as ContactModel;
         if (contact != null){
           _getData();
         }
          },
          ),
    );
  }
}
