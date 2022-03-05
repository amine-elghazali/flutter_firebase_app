
import 'package:app_firebase/models/user.dart';
import 'package:app_firebase/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user object 
  UserModel? _userFromFasebase(User? user){
    return user != null ? UserModel(user.uid) : null ;
  }

  // Auth change user stream 
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFasebase);
    //.map((User user) => _userFromFasebase(user));
  }

  // sign in anonymously

  Future<dynamic> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFasebase(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signAnonymously() {}
  // sign in with email and password 
  
  Future signInWithEmailAndPassword(String email,String password) async{
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      DataBaseService dbService = DataBaseService(user!.uid);

      return _userFromFasebase(user);
    } catch (e) {
      print(e.toString());
    }
  }

  // register with email and password 
  Future registerWithEmailAndPassword(String email,String password) async{
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await DataBaseService(user!.uid).updateUserData('0', 'new user', 100);

      return _userFromFasebase(user);
    } catch (e) {
      print(e.toString());
    }
  }
  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}