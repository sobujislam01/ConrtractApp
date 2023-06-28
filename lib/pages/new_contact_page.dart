import 'package:contactsapps/db/sqlite_helper.dart';
import 'package:contactsapps/model/contact_model.dart';
import 'package:flutter/material.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName = '/contact_new';

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final _nameContriller = TextEditingController();
  final _companynameContriller = TextEditingController();
  final _streetaddressContriller = TextEditingController();
  final _emailaddressContriller = TextEditingController();
  final _designationContriller = TextEditingController();
  final _mobilenumberContriller = TextEditingController();
  final _websiteContriller = TextEditingController();
  final _fromKey = GlobalKey<FormState>();


  @override
  void dispose() {
    _nameContriller.dispose();
    _companynameContriller.dispose();
    _designationContriller.dispose();
    _emailaddressContriller.dispose();
    _mobilenumberContriller.dispose();
    _streetaddressContriller.dispose();
    _websiteContriller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
        actions: [
          IconButton(onPressed: _saveContact,
              icon: Icon(Icons.done))
        ],
      ),
      body: Form(
        key: _fromKey,
        child: ListView(
          padding: EdgeInsets.all(18.0),
          children: [
              TextFormField(
                controller: _nameContriller,
                decoration: InputDecoration(
                  labelText: 'Enter Name*',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Pless provide a vilide name';
                  }
                  if(value.length > 20){
                    return 'Name should be equal or less the 20 charecter';
                  }
                  return null;
                },
              ),
            SizedBox(height: 10,),

            TextFormField(
              controller: _mobilenumberContriller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Mobile Number*',
                prefixIcon: Icon(Icons.call),
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Pless provide a vilide Number';
                }
                if(value.length > 20){
                  return 'Invilide Number';
                }
                return null;
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _designationContriller,
              decoration: InputDecoration(
                labelText: 'Enter Designation',
                prefixIcon: Icon(Icons.work),
              ),
              validator: (value){
                return null;
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _streetaddressContriller,
              decoration: InputDecoration(
                labelText: 'Street Address',
                prefixIcon: Icon(Icons.apartment),
              ),
              validator: (value){
                return null;
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailaddressContriller,
              decoration: InputDecoration(
                labelText: 'EmailAddress',
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value){
                return null;
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.url,
              controller: _websiteContriller,
              decoration: InputDecoration(
                labelText: 'Webaddress',
                prefixIcon: Icon(Icons.web),
              ),
              validator: (value){
                return null;
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _companynameContriller,
              decoration: InputDecoration(
                labelText: 'Company Name',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value){
                return null;
              },
            ),
            SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }

  void _saveContact() {
    if(_fromKey.currentState!.validate()){
      final contact = ContactModel(
          name: _nameContriller.text,
          mobilenumber: _mobilenumberContriller.text,
          designation: _designationContriller.text,
        streetaddress: _streetaddressContriller.text,
        emailaddress: _emailaddressContriller.text,
        website: _websiteContriller.text,
        companyname: _companynameContriller.text,
      );
      DBHelper.insartContact(contact)
          .then((rowId) => Navigator.pop(context,contact)).
      onError((error, stackTrace) => throw'Could not save');
    }
  }
}
