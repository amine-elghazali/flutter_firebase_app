import 'package:app_firebase/models/coffee.dart';
import 'package:app_firebase/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DataBaseService {

  final String? uid;

  DataBaseService(this.uid);

  final CollectionReference coffeeCollection = FirebaseFirestore.instance.collection('coffee');

  

  Future updateUserData(String sugars,String name,int strength) async{
    return await coffeeCollection.doc(uid).set({
      'sugars' : sugars,
      'name' : name,
      'strength' : strength
    });
  }


  // Coffee list from snapshot 

  List<Coffee> _coffeeListFromSnapshot(QuerySnapshot snapshot){
    List<Coffee> listCoffees = [];

   snapshot.docs.forEach((oneCoffee) { 
    Coffee cf = Coffee(
      oneCoffee['name'],
      oneCoffee['sugars'],
      oneCoffee['strength'].toInt()
    );
    listCoffees.add(cf);
    //print(cf.name);
  });

  for (var item in listCoffees) {
      print(item.name);
      print(item.sugars);
      print(item.strength);
  }

    return listCoffees ; 
  }
  // Coffee list from snapshot 

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    // print(snapshot);
    // print("AAAAA"+snapshot['strength'].toInt());
    // print("AAAAABBB "+snapshot['sugars']);
    // print(snapshot['name']);
    // print("AAAAAAAA "+snapshot['name']);
    // print("AAAAAAAA "+snapshot['sugars']);
    UserData userData = UserData(
      uid!, 
      snapshot['name'], 
      snapshot['sugars'], 
      snapshot['strength']
    );

    print("userdata name "+userData.name);
    print("userdata sugars "+userData.sugars);
    print("userdata strength "+userData.strength.toString());
    return userData;
  }

  // Get docs stream 
  
  Stream<List<Coffee>?> get coffee{
    return coffeeCollection.snapshots().map(_coffeeListFromSnapshot);
  }

  // Get user doc stream 
  Stream<UserData> get userData{
    return coffeeCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }


}