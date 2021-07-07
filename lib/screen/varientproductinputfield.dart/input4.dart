import 'package:dashboard/fontsize/heading1.dart';
import 'package:dashboard/fontsize/heading2.dart';
import 'package:dashboard/screen/varientproductinputfield.dart/input5.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:core';

class Inputfour extends StatefulWidget {
  final Map basicdetail;

  Inputfour(
    this.basicdetail,
  );

  @override
  _InputfourState createState() => _InputfourState();
}

class _InputfourState extends State<Inputfour> {
  String keywords;

  bool suggest = false;

  List data = [];
  List attrdata = [];

  String keyword;
  var atributedata = {};
  bool uploading = false;
  int length = 1;
  List key = new List(50);
  List keyvalue = new List(50);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: uploading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
//heading
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Neumorphic(
                        style: NeumorphicStyle(
                            shadowLightColor: Colors.white,
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(12)),
                            depth: 20,
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 60,
                            child: title("Customer Filtering Type"),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: List.generate(
                                length,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Neumorphic(
                                            style: NeumorphicStyle(
                                                shape: NeumorphicShape.flat,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            12)),
                                                depth: -35,
                                                color: Colors.white),
                                            child: Container(
                                              height: 50,
                                              width: 130,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 0, 0, 0),
                                                child: TextField(
                                                  onChanged: (String value) {
                                                    return key[index] = value;
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: "Attribute key",
                                                    labelStyle: TextStyle(),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Neumorphic(
                                            style: NeumorphicStyle(
                                                shape: NeumorphicShape.flat,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            12)),
                                                depth: -35,
                                                color: Colors.white),
                                            child: Container(
                                              height: 50,
                                              width: 130,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 0, 0, 0),
                                                child: TextField(
                                                  onChanged: (String value) {
                                                    return keyvalue[index] =
                                                        value;
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: "Attribute value",
                                                    hintStyle: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              icon: Icon(Icons.remove_circle),
                                              onPressed: () {
                                                setState(() {
                                                  key.removeAt(index);
                                                  keyvalue.removeAt(index);
                                                  length--;
                                                });
                                              })
                                        ],
                                      ),
                                    )),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                length++;
                                print(key);
                                print(keyvalue);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                              ),
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Neumorphic(
                        style: NeumorphicStyle(
                            shadowLightColor: Colors.white,
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(12)),
                            depth: 8,
                            color: Colors.white),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Neumorphic(
                                  style: NeumorphicStyle(
                                      shadowLightColor: Colors.white,
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(30)),
                                      depth: 25,
                                      color: Colors.white),
                                  child: InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 110,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Heading2("Prev", Colors.white),
                                    ),
                                  ),
                                ),
                                Heading1("STEP 3 OF 4", Colors.black),
                                Neumorphic(
                                  style: NeumorphicStyle(
                                      shadowLightColor: Colors.white,
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(30)),
                                      depth: 25,
                                      color: Colors.white),
                                  child: InkWell(
                                    onTap: () async {
                                      setState(() {
                                        uploading = true;
                                      });
                                      keywords = data.join(" ").toLowerCase() +
                                          widget.basicdetail["cato"]
                                              .join(" ")
                                              .toString()
                                              .toLowerCase()
                                              .trim();

                                      String redata = widget
                                          .basicdetail["title"]
                                          .replaceAll(
                                              new RegExp(r'[^\w\s]+'), '')
                                          .toString()
                                          .toLowerCase();
                                      keywordsfinal = keywords + "  " + redata;

                                      seperatekeywords =
                                          keywordsfinal.split(" ");

                                      print(seperatekeywords);
                                      for (var i = 0; i < length; i++) {
                                        await attrbutemapdata.add({
                                          "key": key[i].toString(),
                                          "value": keyvalue[i].toString(),
                                        });
                                      }
                                      print("enna da aachu");

                                      print(attrbutemapdata);
                                      setState(() {
                                        uploading = false;
                                      });
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Inputfive(
                                                  widget.basicdetail,
                                                  attrbutemapdata,
                                                  seperatekeywords,
                                                )),
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 110,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Heading2("Next", Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  List attrbutemapdata = [];
  String keywordsfinal;
  List seperatekeywords = [];
  ListTile title(test) => ListTile(
        leading: Heading1(test, Colors.black),
        title: Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.star,
              color: Colors.orange,
              size: 10,
            )),
      );
}
