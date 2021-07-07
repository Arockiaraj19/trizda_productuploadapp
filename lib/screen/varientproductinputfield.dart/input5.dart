import "dart:core";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/fontsize/heading1.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as Path;
import 'input.dart';

class Inputfive extends StatefulWidget {
  final Map basicdetail;
  final List attrbutemapdata;
  final List keysword;

  Inputfive(
    this.basicdetail,
    this.attrbutemapdata,
    this.keysword,
  );

  @override
  _InputfiveState createState() => _InputfiveState();
}

class _InputfiveState extends State<Inputfive> {
  String workervalue = "Two wheeler";
  List<String> worker = ["Two wheeler", "Three wheeler", "Four wheeler"];

  bool uploading = false;
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
                child: uploading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView(children: [
                        SizedBox(
                          height: 20,
                        ),
                        title("Which vehicle suitable for this product"),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Neumorphic(
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(12)),
                                depth: 35,
                                color: Colors.white),
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              child: DropdownButton(
                                hint: Text(
                                  workervalue.toString(),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                underline: Container(
                                  color: Colors.transparent,
                                ),
                                items: worker
                                    .map<DropdownMenuItem<String>>((String e) {
                                  return DropdownMenuItem(
                                      value: e, child: Text(e));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    workervalue = value;
                                  });
                                },
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
                                  depth: 20,
                                  color: Colors.white),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: InkWell(
                                          onTap: () async {
                                            setState(() {
                                              uploading = true;
                                            });

                                            var id = Uuid().v1();
                                            await seperatedata(id);
                                            setState(() {
                                              uploading = false;
                                            });

                                            return Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Inputdata([], {})));
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          35)),
                                              child: Heading1("Save & Continue",
                                                  Colors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ]))));
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

  seperatedata(id) async {
    await uploadFile(widget.basicdetail["thumnailimage"], id);
    print("hello bro");
    for (var i = 0; i < widget.basicdetail["images"].length; i++) {
      await multiuploadFile(widget.basicdetail["images"][i], id, i);
    }

    Map<String, dynamic> basicdetail = {};
    basicdetail.addAll({
      "title": widget.basicdetail["title"],
      "des": widget.basicdetail["description"],
      "cato": widget.basicdetail["cato"],
      "image": url,
      "images": multiurl,
      "dimension": widget.basicdetail["dimension"],
      "attr": widget.attrbutemapdata,
      "keys": widget.keysword,
      "isactive": true,
      "varienttype": [],
      "verified": false,
      "vehicle": workervalue,
    });
    print("your simple data");
    print(basicdetail);

    final Firestore firestore = Firestore.instance;
    await firestore
        .collection('commonproduct')
        .document(id.toString())
        .setData(basicdetail)
        .then((value) async {
      print("upload bro");
    }).catchError((onError) => print(onError.toString()));
  }

  Future uploadvarientdata(value, id) async {
    await value.addAll({
      "attr": widget.attrbutemapdata,
      "keys": widget.keysword,
      "isactive": true,
      "verified": false,
    });
    final Firestore firestore = Firestore.instance;
    // ignore: deprecated_member_use
    await firestore
        .collection('commonproduct')
        .document(id.toString())
        .setData(value)
        .then((data) async {
      print("hello bro..super");
    }).catchError((onError) => print(onError.toString()));
  }

  Future uploadFile(value, id) async {
    print("single image uploading");
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('commonproduct/$id/thum.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(value);
    url = await (await uploadTask.onComplete).ref.getDownloadURL();
    print(url.toString());
    print('single File Uploaded');
  }

  Future multiuploadFile(value, id, i) async {
    print("multi image uploading");
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('commonproduct/$id/$i.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(value);
    multiurl.add(await (await uploadTask.onComplete).ref.getDownloadURL());

    print('multi File Uploaded');
  }

  var url;
  var multiurl = [];
}
