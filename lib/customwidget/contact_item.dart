export  'dart:js';
import 'package:js/js.dart';
import 'package:contactsapps/db/sqlite_helper.dart';
import 'package:contactsapps/model/contact_model.dart';
import 'package:contactsapps/pages/contact_datile_page.dart';
import 'package:flutter/material.dart';


class ContactItem extends StatefulWidget {
  final ContactModel contactModel;
  ContactItem(this.contactModel);

  @override
  State<ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        bool? confirmationResult = await _showConfirmationDialog(context,direction);
        return confirmationResult ?? false;
      },
      /*onDismissed: (direction){
        DBHelper.deleteContact(widget.contactModel.id!);
      },*/
      background: Container(
        padding: EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete,color: Colors.white,),
        color: Colors.red,
      ),
      child: Card(
        child: ListTile(
          onTap: (){
            print("id: ${widget.contactModel.id} name: ${widget.contactModel.name}");
            Navigator.pushNamed(context, ContactDatilePage.routeName,arguments: [widget.contactModel.id,widget.contactModel.name]);
          },
          title: Text(widget.contactModel.name),
            subtitle: Text(widget.contactModel.mobilenumber),
          trailing: IconButton(
              icon: Icon(widget.contactModel.favorite ? Icons.favorite : Icons.favorite_border),
            onPressed: (){
              final value = widget.contactModel.favorite ? 0 : 1;
              DBHelper.updateContactFavorite(widget.contactModel.id!, value);
              setState(() {
                widget.contactModel.favorite = !widget.contactModel.favorite;
              });
              }),
          )
      ),
    );
  }
  Future<bool?> _showConfirmationDialog(BuildContext context,DismissDirection direction) {
    return showDialog<bool?>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete: ${widget.contactModel.name}?'),
        content: const Text('Are you sure you want to delete this contact?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
