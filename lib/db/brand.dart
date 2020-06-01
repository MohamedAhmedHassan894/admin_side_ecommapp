import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
class BrandServices{
  Firestore _firestore =Firestore.instance;
  String ref = 'brands';
  void createBrand(String name){
    var id = Uuid();
    String brandyId = id.v1();
    _firestore.collection(ref).document(brandyId).setData({'brandname':name});
  }
  Future<List<DocumentSnapshot>> getBrands(){
    return _firestore.collection(ref).getDocuments().then((snaps){
      return snaps.documents;
    });
  }
  Future<List<DocumentSnapshot>> getSuggestions(String suggestion){
    _firestore.collection(ref).where('brandname',isEqualTo: suggestion).getDocuments().then((snap){
      return snap.documents;
    });
  }
}