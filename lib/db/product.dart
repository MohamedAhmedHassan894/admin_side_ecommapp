import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
class ProductService{
  Firestore _firestore =Firestore.instance;
  //the name of our collection
  String ref = 'products';
  void uploadProduct(Map<String,dynamic>data){
    // we are generating our own id
    var id = Uuid();
    String productId = id.v1();
    //data["id"]=productId;
    _firestore.collection(ref).document(productId).setData(data);
  }

}