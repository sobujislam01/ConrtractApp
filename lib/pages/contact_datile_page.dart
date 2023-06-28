import 'package:contactsapps/db/sqlite_helper.dart';
import 'package:contactsapps/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDatilePage extends StatefulWidget {
  static const String routeName = '/contact_datile';

  @override
  State<ContactDatilePage> createState() => _ContactDatilePageState();
}

class _ContactDatilePageState extends State<ContactDatilePage> {
  ContactModel ? _contactModel;
  int ?_id;
  late String _name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    _id =argList[0];
    _name =argList[1];
    print("id: $_id name: $_name");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_name),
      ),
      body: Center(
        child: FutureBuilder<ContactModel>(
          future: DBHelper.getContactsById(_id!),
          builder: (context, snapshot){
            if (snapshot.hasData){
              _contactModel = snapshot.data;
              print(_contactModel);
              return    ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                children: [
                  ListTile(
                    title: Text(_contactModel!.name),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_contactModel!.designation!),
                        Text(_contactModel!.streetaddress!),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(_contactModel!.mobilenumber),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.sms),
                                  onPressed: _makeSMS,
                                ),
                                IconButton(
                                    icon: Icon(Icons.call),
                                    onPressed: _makePhoneCall
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                              title: Text(_contactModel!.emailaddress!),
                              trailing: IconButton(
                                icon: Icon(Icons.mail),
                                onPressed: _makeEmail,
                              )
                          ),
                          ListTile(
                              title: Text(_contactModel!.streetaddress!),
                              trailing: IconButton(
                                icon: Icon(Icons.map),
                                onPressed: _makeMap,
                              )
                          ),
                          ListTile(
                              title: Text(_contactModel!.website!),
                              trailing: IconButton(
                                icon: Icon(Icons.web),
                                onPressed: _showWebsite,
                              )
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            if (snapshot.hasError){
              return const Text('Fail to face data');
            }
            return const CircularProgressIndicator();
          },
        ),
      )  );
  }

  void _makePhoneCall() async {
    final url = 'tel:${_contactModel!.mobilenumber}';
    if (await canLaunch(url)){
      await launch(url);
    }else {
      throw 'Could Not lunch Application';
    }
  }

  void _makeSMS() async {
    final url = 'sms:${_contactModel!.mobilenumber}';
    if (await canLaunch(url)){
    await launch(url);
    }else {
    throw 'Could Not lunch Application';
    }
  }

  void _makeEmail() async {
    final url = 'mailto:${_contactModel!.emailaddress}';
    if (await canLaunch(url)){
    await launch(url);
    }else {
    throw 'Could Not lunch Application';
    }
  }

  void _makeMap() async {
    final url = 'geo:0,0?q=${_contactModel!.streetaddress}';
    if (await canLaunch(url)){
    await launch(url);
    }else {
    throw 'Could Not lunch Application';
    }
  }

  void _showWebsite() async {
    final url = 'https:${_contactModel!.website}';
    if (await canLaunch(url)){
    await launch(url);
    }else {
    throw 'Could Not lunch Application';
    }
  }
}
