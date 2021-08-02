import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseMessaging fcm = FirebaseMessaging.instance;

final FirebaseFirestore db = FirebaseFirestore.instance;

final auth = FirebaseAuth.instance;

String userUid = auth.currentUser!.uid.toString();

FirebaseFirestore fireStoreSnapshotRef = FirebaseFirestore.instance;

FirebaseStorage storage = FirebaseStorage.instance;
UserCredential? userCredential;

