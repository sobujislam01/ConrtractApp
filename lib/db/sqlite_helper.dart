import 'package:contactsapps/model/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'as Path;

class DBHelper {
  static const _createtablecontact = '''create table $tblContact(
  $tableContactColId integer primary key autoincrement,
  $tableContactColName text,
  $tableContactColMobileNumber text,
  $tableContactColCompanyName text,
  $tableContactColStreetAddress text,
  $tableContactColEmail text,
  $tableContactColWebsite text,
  $tableContactColDesignation text,
  $tableContactColFavorite integer)''';
  static Future <Database> open() async {
    final root = await getDatabasesPath();
    print('root: $root');
    final dbPath = Path.join(root,'contact.db');
    return openDatabase(dbPath,version: 1,onCreate: (db,version){
      db.execute(_createtablecontact);
    });
  }
  static Future<int> insartContact(ContactModel contactModel) async {
    final db = await open();
    return db.insert(tblContact ,contactModel.toMap());
  }
  static Future<List<ContactModel>> getAllContacts() async{
    final db = await open();
    final mapList =await db.query(tblContact);
    return List.generate(mapList.length, (index) => ContactModel.fromMap(mapList[index]));
  }
  static Future<ContactModel> getContactsById(int id) async{
    final db = await open();
    final mapList =await db.query(tblContact, where: '$tableContactColId = ?', whereArgs: [id]);
    print('mapList: $mapList');
    return  ContactModel.fromMap(mapList.first);
  }
  static Future<int> updateContactFavorite(int id,int value) async{
    final db = await open();
    return db.update(tblContact, {tableContactColFavorite:value},where: '$tableContactColId ?',whereArgs: [id]);
  }
  static Future<int> deleteContact(int id) async{
    final db = await open();
    return db.delete(tblContact,where: '$tableContactColId ?',whereArgs: [id]);
  }
}