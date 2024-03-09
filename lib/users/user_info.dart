import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserUtils {
  static String getUserInformation() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('User email: ${user.email}');
      print('User ID: ${user.uid}');
      return user.email ?? '';
      // Access other properties of the user as needed
    } else {
      print('No user signed in');
    }
    return '';
  }

  static Future<String> getUserUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Access user email directly from FirebaseAuth
      print('User email: ${user.email}');
      print('User ID: ${user.uid}');

      // Fetch username from Firestore based on user's UID
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      // Check if the user document exists and contains the username field
      if (userDoc.exists) {
        String username = userDoc['username'];
        print('Username: $username');
        return username;
      } else {
        print('User document does not exist');
      }
    } else {
      print('No user signed in');
    }
    return ''; // Return an empty string as default value
  }
}
