import 'dart:io';

import 'package:dashboard/fontsize/heading1.dart';
import 'package:dashboard/fontsize/heading2.dart';

import 'package:dashboard/screen/varientproductinputfield.dart/input4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:flutter/services.dart';

// ignore: must_be_immutable
class Inputtwo extends StatefulWidget {
  String title;
  String description;

  File thumnailimage;
  List image;
  List catagorydata;
  var getattr;
  Inputtwo(this.title, this.description, this.thumnailimage, this.image,
      this.catagorydata, this.getattr);

  @override
  _InputtwoState createState() => _InputtwoState();
}

class _InputtwoState extends State<Inputtwo> {
  TextEditingController stocklimit = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController width = TextEditingController();
  TextEditingController length = TextEditingController();
  TextEditingController height = TextEditingController();

  TextEditingController sku = TextEditingController();
  TextEditingController hsncode = TextEditingController();
  bool switchbtn = false;
  String errormessage;
  bool stock = false;
  bool hsnbtn = false;
  String weights = "Kilogram (Kg)";
  List<String> weightitems = [
    "Kilogram (Kg)",
    "Gram (g)",
    "Litter (Lt)",
    "Millilitter (MLt)"
  ];
  String lengths = "Centimetre (Cm)";
  String heights = "Centimetre (Cm)";
  String widths = "Centimetre (Cm)";
  List<String> heightitems = ["Centimetre (Cm)", "Inch (In)"];
  var basicdetail = {};
  bool uploading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        onTap: () {
          setState(() {
            errormessage = null;
          });
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: uploading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Heading1("Inventory Management", Colors.black)),
                    SizedBox(
                      height: 15,
                    ),
                    Neumorphic(
                      style: NeumorphicStyle(
                          shadowLightColor: Colors.white,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                          depth: 8,
                          color: Colors.white),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            title("Product Dimensions"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Neumorphic(
                                  style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(12)),
                                      depth: -35,
                                      color: Colors.white),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: errormessage == null ? 45 : 60,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: TextField(
                                        controller: weight,
                                        inputFormatters: <TextInputFormatter>[
                                          // ignore: deprecated_member_use
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Weight",
                                          border: InputBorder.none,
                                          errorText: errormessage,
                                          errorStyle: TextStyle(
                                            fontSize: 8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: 160,
                                  height: 20,
                                  child: DropdownButton(
                                    hint: Text(
                                      weights.toString(),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    items: weightitems
                                        .map<DropdownMenuItem<String>>(
                                            (String e) {
                                      return DropdownMenuItem(
                                          value: e, child: Text(e));
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        weights = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Neumorphic(
                                  style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(12)),
                                      depth: -35,
                                      color: Colors.white),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: errormessage == null ? 45 : 60,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: TextField(
                                        controller: length,
                                        inputFormatters: <TextInputFormatter>[
                                          // ignore: deprecated_member_use
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Length",
                                          border: InputBorder.none,
                                          errorText: errormessage,
                                          errorStyle: TextStyle(
                                            fontSize: 8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: 160,
                                  height: 20,
                                  child: DropdownButton(
                                    hint: Text(
                                      lengths.toString(),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    items: heightitems
                                        .map<DropdownMenuItem<String>>(
                                            (String e) {
                                      return DropdownMenuItem(
                                          value: e, child: Text(e));
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        heights = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Neumorphic(
                                  style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(12)),
                                      depth: -35,
                                      color: Colors.white),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: errormessage == null ? 45 : 60,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: TextField(
                                        controller: width,
                                        inputFormatters: <TextInputFormatter>[
                                          // ignore: deprecated_member_use
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "width",
                                          border: InputBorder.none,
                                          errorText: errormessage,
                                          errorStyle: TextStyle(
                                            fontSize: 8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: 160,
                                  height: 20,
                                  child: DropdownButton(
                                    hint: Text(
                                      widths.toString(),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    items: heightitems
                                        .map<DropdownMenuItem<String>>(
                                            (String e) {
                                      return DropdownMenuItem(
                                          value: e, child: Text(e));
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        widths = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Neumorphic(
                                  style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(12)),
                                      depth: -35,
                                      color: Colors.white),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: errormessage == null ? 45 : 60,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: TextField(
                                        controller: height,
                                        inputFormatters: <TextInputFormatter>[
                                          // ignore: deprecated_member_use
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Height",
                                          border: InputBorder.none,
                                          errorText: errormessage,
                                          errorStyle: TextStyle(
                                            fontSize: 8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: 160,
                                  height: 20,
                                  child: DropdownButton(
                                    hint: Text(
                                      heights.toString(),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    items: heightitems
                                        .map<DropdownMenuItem<String>>(
                                            (String e) {
                                      return DropdownMenuItem(
                                          value: e, child: Text(e));
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        heights = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
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
                                      child: Heading1("Prev", Colors.white),
                                    ),
                                  ),
                                ),
                                Heading2("STEP 2 OF 4", Colors.black),
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
                                      if (weight.text.length == 0) {
                                        setState(() {
                                          errormessage =
                                              "Please fill the input field";
                                        });
                                      } else if (length.text.length == 0) {
                                        setState(() {
                                          errormessage =
                                              "Please fill the input field";
                                        });
                                      } else if (height.text.length == 0) {
                                        setState(() {
                                          errormessage =
                                              "Please fill the input field";
                                        });
                                      } else {
                                        setState(() {
                                          uploading = true;
                                        });
                                        await basicdetail.addAll({
                                          "title": widget.title,
                                          "description": widget.description,
                                          "thumnailimage": widget.thumnailimage,
                                          "images": widget.image,
                                          "dimension": [
                                            {
                                              "key": "weight",
                                              "point": weights,
                                              "value": weight.text,
                                            },
                                            {
                                              "key": "length",
                                              "point": lengths,
                                              "value": length.text,
                                            },
                                            {
                                              "key": "height",
                                              "point": heights,
                                              "value": height.text,
                                            },
                                            {
                                              "key": "width",
                                              "point": widths,
                                              "value": width.text,
                                            }
                                          ],
                                          "cato": widget.catagorydata,
                                          "attr": widget.getattr
                                        });
                                        setState(() {
                                          uploading = false;
                                        });
                                        print(basicdetail);

                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Inputfour(basicdetail),
                                            ));
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 110,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Heading1("Next", Colors.white),
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
