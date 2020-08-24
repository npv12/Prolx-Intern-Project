import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    return _db.collection('bids').where('uid', isEqualTo: uid).snapshots();
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
}
