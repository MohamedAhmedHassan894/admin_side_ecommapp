import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../db/product.dart';
import '../db/category.dart';
import '../db/brand.dart';
import 'package:provider/provider.dart';
import 'package:adminsideecommapp/provider/product_provider.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryServices _categoryServices = CategoryServices();
  BrandServices _brandServices = BrandServices();
  ProductService _productService =ProductService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<DocumentSnapshot> brands = List<DocumentSnapshot>();
  List<DocumentSnapshot> categories = List<DocumentSnapshot>();
  List<DropdownMenuItem<String>> categoriesDropDown = List<DropdownMenuItem<String>>();
  List<DropdownMenuItem<String>> brandsDropDown = List<DropdownMenuItem<String>>();
  String _currentCategory ;
  String _currentBrand;
  List<String> selectedSizes = <String>[];
  File _image1;
  bool isLoading = false;
  List<String> colors  = <String>[];
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey ;
  Color red = Colors.red ;
  bool onSale = false;
  bool featured = false;


  @override
  void initState() {
    _getCategories();
    _getBrands();
    super.initState();
  }

  List<DropdownMenuItem<String>>getCategoriesDropDown(){
    List<DropdownMenuItem<String>> items = List();
    for(int i=0;i<categories.length;i++){
      setState(() {
        //the categories list will contain maps and dat is a map and 'category ' is the key for particular map
        items.insert(0, DropdownMenuItem(child: Text(categories[i].data['category']),value: categories[i].data['category'],));
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>>getBrandsDropDown(){
    List<DropdownMenuItem<String>> items = List();
    for(int i=0;i<brands.length;i++){
      setState(() {
        items.insert(0, DropdownMenuItem(child: Text(brands[i].data['brandname']),value: brands[i].data['brandname'],));
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context){
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: IconButton(icon: Icon(Icons.close,color: black,), onPressed: (){Navigator.pop(context);}),
        title: Text("add product",style: TextStyle(color: black),),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading?CircularProgressIndicator():Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 120,
                        child: OutlineButton(
                          onPressed: (){
                            _selectImage(ImagePicker.pickImage(source: ImageSource.gallery ));
                          },
                          borderSide: BorderSide(color: grey.withOpacity(0.5),width: 2.5),
                          child: displayChild1(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Text('Available Colors'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        if(productProvider.selectedColors.contains('red')){
                          productProvider.removeColors('red');
                        }else{
                          productProvider.addColors('red');
                        }
                        setState(() {
                          colors=productProvider.selectedColors;
                        });
                      },
                      child: Container(
                        width: 24,height: 24,decoration: BoxDecoration(
                        color: productProvider.selectedColors.contains('red')?Colors.blue:grey,
                        borderRadius: BorderRadius.circular(15)
                      ),
                        child: Padding(padding: const EdgeInsets.all(2),
                          child:CircleAvatar(backgroundColor: Colors.red,
                          ),
                        ),),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        if(productProvider.selectedColors.contains('yellow')){
                          productProvider.removeColors('yellow');
                        }else{
                          productProvider.addColors('yellow');
                        }
                        setState(() {
                          colors=productProvider.selectedColors;
                        });
                      },
                      child: Container(
                        width: 24,height: 24,decoration: BoxDecoration(
                          color: productProvider.selectedColors.contains('yellow')?red:grey,
                          borderRadius: BorderRadius.circular(15)
                      ),
                        child: Padding(padding: const EdgeInsets.all(2),
                          child:CircleAvatar(backgroundColor: Colors.yellow,
                          ),
                        ),),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        if(productProvider.selectedColors.contains('blue')){
                          productProvider.removeColors('blue');
                        }else{
                          productProvider.addColors('blue');
                        }
                        setState(() {
                          colors=productProvider.selectedColors;
                        });
                      },
                      child: Container(
                        width: 24,height: 24,decoration: BoxDecoration(
                          color: productProvider.selectedColors.contains('blue')?red:grey,
                          borderRadius: BorderRadius.circular(15)
                      ),
                        child: Padding(padding: const EdgeInsets.all(2),
                          child:CircleAvatar(backgroundColor: Colors.blue,
                          ),
                        ),),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        if(productProvider.selectedColors.contains('green')){
                          productProvider.removeColors('green');
                        }else{
                          productProvider.addColors('green');
                        }
                        setState(() {
                          colors=productProvider.selectedColors;
                        });
                      },
                      child: Container(
                        width: 24,height: 24,decoration: BoxDecoration(
                          color: productProvider.selectedColors.contains('green')?red:grey,
                          borderRadius: BorderRadius.circular(15)
                      ),
                        child: Padding(padding: const EdgeInsets.all(2),
                          child:CircleAvatar(backgroundColor: Colors.green,
                          ),
                        ),),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        if(productProvider.selectedColors.contains('white')){
                          productProvider.removeColors('white');
                        }else{
                          productProvider.addColors('white');
                        }
                        setState(() {
                          colors=productProvider.selectedColors;
                        });
                      },
                      child: Container(
                        width: 24,height: 24,decoration: BoxDecoration(
                          color: productProvider.selectedColors.contains('white')?red:grey,
                          borderRadius: BorderRadius.circular(15)
                      ),
                        child: Padding(padding: const EdgeInsets.all(2),
                          child:CircleAvatar(backgroundColor: Colors.white,
                          ),
                        ),),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        if(productProvider.selectedColors.contains('black')){
                          productProvider.removeColors('black');
                        }else{
                          productProvider.addColors('black');
                        }
                        setState(() {
                          colors=productProvider.selectedColors;
                        });
                      },
                      child: Container(
                        width: 24,height: 24,decoration: BoxDecoration(
                          color: productProvider.selectedColors.contains('black')?red:grey,
                          borderRadius: BorderRadius.circular(15)
                      ),
                        child: Padding(padding: const EdgeInsets.all(2),
                          child:CircleAvatar(backgroundColor: Colors.black,
                          ),
                        ),),
                    ),
                  ),
                ],
              ),
              Text("Available Size"),
              Row(
                children: <Widget>[
                  Checkbox(value: selectedSizes.contains('S'), onChanged: (value){changeSelectedSizes('S');}),
                  Text('S'),

                  Checkbox(value: selectedSizes.contains('M'), onChanged: (value){changeSelectedSizes('M');}),
                  Text('M'),

                  Checkbox(value: selectedSizes.contains('L'), onChanged: (value){changeSelectedSizes('L');}),
                  Text('L'),

                  Checkbox(value: selectedSizes.contains('XL'), onChanged: (value){changeSelectedSizes('XL');}),
                  Text('XL'),

                  Checkbox(value: selectedSizes.contains('XXL'), onChanged: (value){changeSelectedSizes('XXL');}),
                  Text('XXL'),

                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('sale'),
                      SizedBox(width: 10,),
                      Switch(value: onSale, onChanged:(value){
                        setState(() {
                          onSale=value;
                        });
                      }),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Featured'),
                      SizedBox(width: 10,),
                      Switch(value: featured, onChanged:(value){
                        setState(() {
                          featured=value;
                        });
                      }),
                    ],
                  ),
                ],
              ),
              Padding(
                  padding:const EdgeInsets.all(8.0) ,
                  child: Text('enter a product name with 10 characters at maximum',textAlign:TextAlign.center,style: TextStyle(color:black,fontSize:12 ,),)),
              Padding(
                padding:const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(
                    hintText: "product name"
                  ),
                  // ignore: missing_return
                  validator:(value){
                    if(value.isEmpty){
                      return'You must enter the product name';
                    }else if (value.length>10){
                      return'product name can not have more than 10 letters';
                    }
                  },
                ),
              ),
              //  select category and brand
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('category',style: TextStyle(color: red),),
                  ),
                  DropdownButton(
                    items: categoriesDropDown,
                    onChanged: changeSelectedCategory,
                    value: _currentCategory,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('brand',style: TextStyle(color: red),),
                  ),
                  DropdownButton(
                    items: brandsDropDown,
                    onChanged: changeSelectedBrand,
                    value: _currentBrand,
                  ),
                ],
              ),

              Padding(
                padding:const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Quantity",
                  ),
                  // ignore: missing_return
                  validator:(value) {
                    if (value.isEmpty) {
                      return 'You must enter the quantity';
                    }
                  }
                ),
              ),
              Padding(
                padding:const EdgeInsets.all(12.0),
                child: TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "price",
                    ),
                    // ignore: missing_return
                    validator:(value) {
                      if (value.isEmpty) {
                        return 'You must enter the price';
                      }
                    }
                ),
              ),


              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: FlatButton(onPressed: (){
                    validateAndUpload();
                  }, child: Text('add product'),textColor: white,color: red,)),
            ],
          ),
        ),
      ),
    );
  }

   _getCategories() async {
    List<DocumentSnapshot> data = await _categoryServices.getCategories();
    setState(() {
      categories=data;
      categoriesDropDown = getCategoriesDropDown();
      _currentCategory=categories[0].data['category'];
    });
   }
  _getBrands() async {
    List<DocumentSnapshot> data = await _brandServices.getBrands();
    setState(() {
      brands=data;
      brandsDropDown = getBrandsDropDown();
      _currentBrand=brands[0].data['brandname'];
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() {
      _currentCategory=selectedCategory;
    });
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() {
      _currentBrand=selectedBrand;
    });
  }

  void changeSelectedSizes(String size) {
    if(selectedSizes.contains(size)){
      setState(() {
        selectedSizes.remove(size);
      });
    }else{
      setState(() {
        selectedSizes.insert(0,size);
      });
    }
  }

  void _selectImage(Future<File> pickImage) async{
    File tempImage = await pickImage;
      setState(() {
        _image1=tempImage;
      });
  }

  Widget displayChild1() {
    if(_image1==null){
      return Padding(
          padding: const EdgeInsets.fromLTRB(14.0,50.0,14.0,50.0),
          child: Icon(Icons.add,color: grey,));
    }
    else{
      return Image.file(_image1,fit: BoxFit.fill,width: double.infinity,);
    }
  }
  void validateAndUpload() async {
    if(_formKey.currentState.validate()){
      setState(() {
        isLoading=true;
      });
      if(_image1!=null){
        if(selectedSizes.isNotEmpty){
          String imageUrl1;
          final FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://ecommerceadmin-54e5c.appspot.com');
          final String picture1= "1${DateTime.now().millisecondsSinceEpoch.toString()}.jbg";
          StorageUploadTask task1=storage.ref().child(picture1).putFile(_image1);
          StorageTaskSnapshot snapshot1 = await task1.onComplete.then((snapshot){return snapshot;});
          task1.onComplete.then((snapshot3) async{
            // after we upload the images to storage , we want to get the url for those images and save them to imageutl variable
            imageUrl1 = await snapshot1.ref.getDownloadURL();
            _productService.uploadProduct({
              "name": productNameController.text,
              "price": double.parse(priceController.text),
              "sizes": selectedSizes,
              "colors":colors,
              "picture": imageUrl1,
              "quantity": int.parse(quantityController.text),
              "brand":_currentBrand,
              "category":_currentCategory,
              "sale":onSale,
              "featured":featured
            });
            _formKey.currentState.reset();
            setState(() {isLoading=false;});
            Fluttertoast.showToast(msg: 'Product added');
            Navigator.pop(context);
          });
        }else{
          setState(() {isLoading=false;});
        }
      }else{
        setState(() {isLoading=false;});
        Fluttertoast.showToast(msg: ' the image must be peovided');
      }
    }
  }
}
