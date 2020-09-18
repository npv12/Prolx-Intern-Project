import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'localData.dart';

class FirestoreService {
  static final FirestoreService _firestoreService =
      FirestoreService._internal();
  Firestore _db = Firestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Stream<QuerySnapshot> getCategories() {
    return _db.collection('categories').orderBy('index').snapshots();
  }

  Future fgetCategories() async {
    var c = <String>[];
    var q = await _db.collection('categories').orderBy('index').getDocuments();
    q.documents.forEach((doc) {
      c.add(doc.documentID);
    });
    return c;
  }

  Future<bool> checkRegistered() async {
    try {
      var uid = await LocalData().getUid();
      var doc = await _db.collection('users').document(uid).get();
      return doc['registered'];
    } catch (e) {
      return false;
    }
  }

  Future<void> updateUser(String name, String mobileNo) async {
    var uid = await LocalData().getUid();
    await _db.collection('users').document(uid).setData({
      'mobileNo': mobileNo,
      'name': name,
      'registered': true,
      'access': 'issuer',
    }, merge: true);
  }

  Future<void> createUser(FirebaseUser user) async {
    await _db.collection('users').document(user.uid).setData({
      'uid': user.uid,
      'email': user.email,
      'since': DateTime.now(),
      'registered': false,
    }, merge: true);
  }

  Stream<QuerySnapshot> getFeaturedProducts() {
    return _db
        .collection('products')
        .where("isFeatured", isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getMyBids(String uid) {
    return _db.collection('bids').where('uid', arrayContains: uid).snapshots();
  }

  Stream<QuerySnapshot> getProductDetails(String productUid) {
    return _db
        .collection('products')
        .where('Product_id', isEqualTo: productUid)
        .snapshots();
  }

  Stream<QuerySnapshot> getMyProducts(String uid) {
    return _db
        .collection('products')
        .where('ownerID', isEqualTo: uid)
        .snapshots();
  }

  Stream<QuerySnapshot> getBidsFromProducts(String uid) {
    return _db
        .collection('bids')
        .where('Product_id', isEqualTo: uid)
        .snapshots();
  }

  Future<String> getUserName(String uid) async {
    String name;
    await _db
        .collection('users')
        .where('uid', isEqualTo: uid)
        .getDocuments()
        .then((value) => (name = value.documents[0].data['name']));
    return name;
  }

  Future<int> newProduct(List<File> images, String prodName, String description,
      String price, String category) async {
    try {
      String uid;
      List<String> catalogue = [];

      DocumentReference docRef =
          await _db.collection('products').add({'name': prodName});

      for (int i = 0; i < images.length; i++) {
        final StorageReference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('product_images/' + docRef.documentID + '_' + i.toString());
        final StorageUploadTask task = firebaseStorageRef.putFile(images[i]);
        await task.onComplete;
        print('files uploaded');
        await firebaseStorageRef.getDownloadURL().then((url) {
          print(url);
          catalogue.add(url);
        });
      }

      if (catalogue.isNotEmpty) {
        uid = await LocalData().getUid();

        await docRef.updateData({
          'addedOn': FieldValue.serverTimestamp(),
          'expiringInDays': 5,
          'name': prodName,
          'images': catalogue,
          'description': description,
          'price': double.parse(price),
          'searchIndex': prodName[0].toUpperCase(),
          'category': category,
          'isFeatured': false,
          'ownerId': uid,
          'productId': docRef.documentID,
        });
        return 1;
      } else
        return 0;
    } catch (e) {
      return 0;
    }
  }
}
