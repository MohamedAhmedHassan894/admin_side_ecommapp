import 'package:flutter/material.dart';
import 'package:adminsideecommapp/screens/admin.dart';
import 'package:provider/provider.dart';
import 'package:adminsideecommapp/provider/product_provider.dart';
import 'dart:async';
void main() => runApp(ChangeNotifierProvider(create:(_)=>ProductProvider(),child: MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Shop Admin ',
  theme: ThemeData(
    primarySwatch: Colors.blue,
  ),
  home: Admin(),
),));



