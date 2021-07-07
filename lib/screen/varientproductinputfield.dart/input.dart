import 'dart:io';

import 'package:dashboard/screen/varientproductinputfield.dart/dataget.dart';

import 'dart:async';

import 'package:dashboard/screen/varientproductinputfield.dart/input2.dart';
import 'package:flutter/services.dart';

import 'package:dashboard/fontsize/heading1.dart';
import 'package:dashboard/fontsize/heading2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// ignore: must_be_immutable
class Inputdata extends StatefulWidget {
  List getdata;
  Map attr;
  Inputdata(this.getdata, this.attr);
  @override
  _InputdataState createState() => _InputdataState();
}

class _InputdataState extends State<Inputdata> {
  String please;
  String errormessage;
  String dropdownvalue = "₹";
  List<String> items = ["₹", "₹"];
  TextEditingController price = TextEditingController();
  TextEditingController salesprice = TextEditingController();
  TextEditingController producttitle = TextEditingController();
  TextEditingController shortdiscription = TextEditingController();
  String prices;
  String salesprices;

  List<File> _image = [];
  File thumnailimage;
  final picker = ImagePicker();
  int maxline = 1;
  bool stock = false;
  bool weight = false;

  removeimage(position) {
    setState(() {
      return _image.removeAt(position);
    });
  }

  Future<Null> _cropImage(value) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: value,
        maxHeight: 1000,
        maxWidth: 1000,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.ratio4x3,
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.orange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      setState(() {
        _image.add(croppedFile);
      });
    }
  }

  Future getImage(value) async {
    final pickedFile = await picker.getImage(
      source: value,
    );

    if (pickedFile != null) {
      // _image = File(pickedFile.path);
      await _cropImage(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  Future<Null> thumbnailimagecrop(value) async {
    File croppedFile = await ImageCropper.cropImage(
        maxHeight:700,
        maxWidth: 700,
        sourcePath: value,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.ratio4x3,
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.orange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      setState(() {
        thumnailimage = croppedFile;
      });
    }
  }

  Future thumbnailimage(value) async {
    final pickedFile = await picker.getImage(source: value);

    if (pickedFile != null) {
      // _image = File(pickedFile.path);
      await thumbnailimagecrop(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.camera),
                  title: new Text('Camera'),
                  onTap: () => getImage(ImageSource.camera),
                ),
                new ListTile(
                  leading: new Icon(Icons.photo),
                  title: new Text('Gallery'),
                  onTap: () => getImage(ImageSource.gallery),
                ),
              ],
            ),
          );
        });
  }

  void _settingModalBottomSheet1(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.camera),
                  title: new Text('Camera'),
                  onTap: () => thumbnailimage(ImageSource.camera),
                ),
                new ListTile(
                  leading: new Icon(Icons.photo),
                  title: new Text('Gallery'),
                  onTap: () => thumbnailimage(ImageSource.gallery),
                ),
              ],
            ),
          );
        });
  }

  var url;
  var multiurl = [];
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: Scaffold(
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
            width: double.infinity,
            color: Colors.white,
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
                          child: Heading1("Product Details", Colors.black)),
                      SizedBox(
                        height: 20,
                      ),
                      title("Category"),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 8, 8, 8),
                        child: Neumorphic(
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(12)),
                              depth: 30,
                              color: Colors.white),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Catogorymaininput()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Heading1(
                                      "Select Catagory", Colors.black)),
                            ),
                          ),
                        ),
                      ),
                      if (widget.getdata.isNotEmpty)
                        Column(
                          children: List.generate(
                              1,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Neumorphic(
                                      style: NeumorphicStyle(
                                          shape: NeumorphicShape.flat,
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                                  BorderRadius.circular(12)),
                                          depth: 10,
                                          color: Colors.white),
                                      child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        height: 60,
                                        child: Heading2(
                                            widget.getdata[
                                                widget.getdata.length - 1],
                                            Colors.black),
                                      ),
                                    ),
                                  )),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      title("Product title"),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 8, 8),
                        child: Neumorphic(
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(12)),
                              depth: -35,
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
                            child: TextField(
                              controller: producttitle,
                              decoration: InputDecoration(
                                hintText: "  Product Title",
                                border: InputBorder.none,
                                errorText: errormessage,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      title("Short Description"),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0, 8, 8),
                        child: Neumorphic(
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(12)),
                              depth: -35,
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
                            child: TextField(
                              controller: shortdiscription,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              maxLengthEnforced: true,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                hintText: "  Short Description",
                                labelStyle: TextStyle(),
                                border: InputBorder.none,
                                errorText: errormessage,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
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
                          child: Column(
                            children: [
                              title("Product thumnail image"),
                              Neumorphic(
                                style: NeumorphicStyle(
                                    shadowLightColor: Colors.white,
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(12)),
                                    depth: 20,
                                    color: Colors.white),
                                child: InkWell(
                                  onTap: () =>
                                      _settingModalBottomSheet1(context),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(),
                                    height: 160,
                                    width: 160,
                                    child: thumnailimage == null
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.camera_alt,
                                                color: Colors.orange,
                                              ),
                                              Text("No Image Selected"),
                                            ],
                                          )
                                        : Image.file(
                                            thumnailimage,
                                            fit: BoxFit.fitWidth,
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Neumorphic(
                          style: NeumorphicStyle(
                              shadowLightColor: Colors.white,
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(12)),
                              depth: 8,
                              color: Colors.white),
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                                  child: title("Images"),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Row(
                                          children: List.generate(_image.length,
                                              (index) {
                                        return Stack(
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
                                                decoration: BoxDecoration(),
                                                height: 160,
                                                width: 130,
                                                child: _image == null
                                                    ? Text("No image selected")
                                                    : Image.file(
                                                        _image[index],
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                              ),
                                            ),
                                            Positioned(
                                              top: -13,
                                              right: 0,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.cancel,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () =>
                                                    removeimage(index),
                                              ),
                                            ),
                                          ],
                                        );
                                      })),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Neumorphic(
                                        style: NeumorphicStyle(
                                            shadowLightColor: Colors.white,
                                            shape: NeumorphicShape.flat,
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                                    BorderRadius.circular(12)),
                                            depth: 20,
                                            color: Colors.white),
                                        child: InkWell(
                                          onTap: () =>
                                              _settingModalBottomSheet(context),
                                          child: Container(
                                              alignment: Alignment.center,
                                              width: 130,
                                              height: 130,
                                              color: Colors.white,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.orange,
                                                  ),
                                                  Text("Similar Images"),
                                                ],
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Heading1("STEP 1 OF 4", Colors.black),
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
                                        if (producttitle.text.length == 0) {
                                          setState(() {
                                            errormessage =
                                                "Please fill the input field";
                                          });
                                        } else if (shortdiscription
                                                .text.length ==
                                            0) {
                                          setState(() {
                                            errormessage =
                                                "Please fill the input field";
                                          });
                                        } else if (please != null) {
                                          _showDialog(context);
                                        } else if (thumnailimage == null) {
                                          _showDialog1(context);
                                        } else if (_image.length == 0) {
                                          _showDialog2(context);
                                        } else if (widget.getdata.length == 0) {
                                          _showDialog3(context);
                                        } else {
                                          return Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Inputtwo(
                                                    producttitle.text,
                                                    shortdiscription.text,
                                                    thumnailimage,
                                                    _image,
                                                    widget.getdata,
                                                    widget.attr),
                                              ));
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 110,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(30),
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

  void _showDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text("Please add less than prices"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog1(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text("Please add a store images"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog2(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text("Please add a store images"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog3(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text("Please add a catogory for your product"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
