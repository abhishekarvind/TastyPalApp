import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String name;

  const User({required this.email, required this.uid, required this.name});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      email: snapshot["username"],
      uid: snapshot["uid"],
      name: snapshot["name"],
    );
  }

  Map<String, dynamic> toJson() => {"email": email, "uid": uid, "name": name};
}
