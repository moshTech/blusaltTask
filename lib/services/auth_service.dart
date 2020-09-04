import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_with_get_state/models/user.dart';
import 'package:firebase_auth_with_get_state/services/firestore_service.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirestoreService _firestoreRepository = FirestoreService();

  UserModel _currentUser;
  UserModel get currentUser => _currentUser;

  Future _populateCurrentUser(User user) async {
    if (user != null) {
      _currentUser = await _firestoreRepository.getUser(user.uid);
    }
  }

  Future loginWithEmail({@required email, @required password}) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await _populateCurrentUser(authResult.user);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future registerWithEmail(
      {@required name, @required email, @required password}) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firestoreRepository.createUser(UserModel(
        id: authResult.user.uid,
        email: email,
        name: name,
        password: password,
      ));
      await _populateCurrentUser(authResult.user);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    _currentUser = UserModel();
    return _firebaseAuth.signOut();
  }
}
