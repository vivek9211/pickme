import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class FirebaseService {
  Future<void> updateUserProfile(String username, String aadharNumber, String location, String phoneNumber) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('No user signed in');
      }

      String userId = user.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'username': username,
        'aadharNumber': aadharNumber,
        'location': location,
        'phoneNumber': phoneNumber,
      });

      print('User profile updated successfully');
    } catch (error) {
      print('Failed to update user profile: $error');
      throw error;
    }
  }
}

