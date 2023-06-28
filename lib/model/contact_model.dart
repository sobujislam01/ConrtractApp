const String tblContact = 'tbl_contact';
const String tableContactColId ='id';
const String tableContactColName ='name';
const String tableContactColMobileNumber ='mobile_number';
const String tableContactColEmail ='email';
const String tableContactColCompanyName ='company_name';
const String tableContactColStreetAddress ='street_address';
const String tableContactColWebsite ='website';
const String tableContactColDesignation ='designation';
const String tableContactColFavorite ='favorite';



class ContactModel {
  int ?id;
  String name;
  String mobilenumber;
  String ? emailaddress;
  String ? companyname;
  String ? streetaddress;
  String ? website;
  String ? designation;
  bool favorite ;

  ContactModel({
      this.id,
      required this.name,
      required this.mobilenumber,
      this.emailaddress,
      this.companyname,
      this.streetaddress,
      this.website,
      this.designation,
      this.favorite = false});

  factory ContactModel.fromMap(Map<String,dynamic> map) =>ContactModel(
      name: map[tableContactColName],
      mobilenumber: map[tableContactColMobileNumber],
      id: map[tableContactColId],
      designation: map[tableContactColDesignation],
      emailaddress: map[tableContactColEmail],
      website: map[tableContactColWebsite],
     companyname: map[tableContactColCompanyName],
      streetaddress: map[tableContactColStreetAddress],
     favorite: map[tableContactColFavorite] == 1 ? true : false,
  );


  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{
      tableContactColName : name,
      tableContactColMobileNumber : mobilenumber,
      tableContactColCompanyName : companyname,
      tableContactColStreetAddress : streetaddress,
      tableContactColDesignation : designation,
      tableContactColEmail : emailaddress,
      tableContactColWebsite : website,
      tableContactColFavorite : favorite ? 1 : 0,
    };

    if (id!=null){
      map[tableContactColId];
    }
    return map;
  }

  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, mobilenumber: $mobilenumber, emailaddress: $emailaddress, companyname: $companyname, streetaddress: $streetaddress, website: $website, designation: $designation, favoriet: $favorite}';
  }
}