
import 'package:dashboard/fontsize/bodytext.dart';
import 'package:ffcache/ffcache.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'catagorydata.dart';

class Catogorymaininput extends StatefulWidget {
  @override
  _CatogorymaininputState createState() => _CatogorymaininputState();
}

class _CatogorymaininputState extends State<Catogorymaininput> {
  List data = [
    {"img": "assets/images/Applience.png", "name": "Fish & Aquatic"},
    {"img": "assets/images/Applience.png", "name": "Flowers & Gardening"},
    {"img": "assets/images/Applience.png", "name": "Accessories"},
    {"img": "assets/images/Applience.png", "name": "Appliances"},
    {"img": "assets/images/Beauty.png", "name": "Beauty and Grooming"},
    {"img": "assets/images/Daily_Essential.png", "name": "Daily Essential"},
    {"img": "assets/images/Applience.png", "name": "Electronics"},
    {"img": "assets/images/Fashion.png", "name": "Fashion"},
    {"img": "assets/images/Fitness.png", "name": "Fitness _ Equipments"},
    {"img": "assets/images/Furniture.png", "name": "Furniture"},
    {"img": "assets/images/homethings.png", "name": "Home Improvement_Build"},
    {"img": "assets/images/kitchen11.png", "name": "Kitchen improvement"},
    {"img": "assets/images/Medicines.png", "name": "Medicines"},
    {
      "img": "assets/images/Mobile _ Accessories.png",
      "name": "Mobile _ Accessories"
    },
    {"img": "assets/images/Pet_Care.png", "name": "Pet_Care"},
    {"img": "assets/images/Flower_and_Plant.png", "name": "Plants _ Flowers"},
    {"img": "assets/images/Sports _ Games.png", "name": "Sports _ Games"},
    {"img": "assets/images/Toys  _ Gifts.png", "name": "Toys _ Gifts"}
  ];


  List selectdata = [];
  

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            children: List.generate(
              data.length,
              (index) => Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () {
                    selectdata
                        .add(data[index]["name"].toString().toLowerCase());
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DatagetInput(
                                data[index]["name"].toString(), selectdata)));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.16,
                            color: Colors.white,
                            child: Image.asset(
                              data[index]["img"].toString(),
                              fit: BoxFit.contain,
                            )),
                        Bodytext(data[index]["name"].toString(), Colors.black),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

class DatagetInput extends StatefulWidget {
  final String data;
 final  List selectdata;
  DatagetInput(this.data, this.selectdata);
  @override
  _DatagetInputState createState() => _DatagetInputState();
}

class _DatagetInputState extends State<DatagetInput> {
  var data;
  Future<dynamic> fetchdata() async {
    final cache = await FFCache();
    await cache.init();

    if (await cache.has('${widget.data.toString()}')) {
      // if (false) {
      final rJsonData = await cache.getJSON('${widget.data.toString()}');
      print("from cookies 🍪");
      return rJsonData
          .map<MapModel>((json) => MapModel.fromJson(json))
          .toList();
    } else {
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('cato/${widget.data.toString()}.json');
      data = await storageReference.getDownloadURL();
      final response = await http.get(data.toString().trim());
      print(response.body);
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        await cache.setJSON('${widget.data.toString()}', parsed);
        return parsed.map<MapModel>((json) => MapModel.fromJson(json)).toList();
      } else {
        print("It have some Error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: fetchdata(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Catogorypage(
              catodata: snapshot.data, selectdata: widget.selectdata);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class MapModel {
  Map catagory;

  MapModel({
    this.catagory,
  });

  factory MapModel.fromJson(Map<String, dynamic> json) {
    return MapModel(
      catagory: json["data"] as Map,
    );
  }
}
