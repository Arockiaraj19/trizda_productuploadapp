import 'package:dashboard/fontsize/bodytext.dart';
import 'package:dashboard/screen/varientproductinputfield.dart/input.dart';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class Catogorypage extends StatefulWidget {
  List catodata;
  List selectdata;
  Catogorypage({this.catodata, this.selectdata});

  @override
  _CatogorypageState createState() => _CatogorypageState();
}

class _CatogorypageState extends State<Catogorypage> {
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
                crossAxisCount: 3,
                childAspectRatio: 1 / 1,
                children: List.generate(
                  widget.catodata.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                          depth: 5,
                          lightSource: LightSource.topLeft,
                          color: Colors.white),
                      child: InkWell(
                        onTap: () {
                          if (widget.catodata[index].catagory["sub"] == null) {
                            print("sub is null");
                          } else {
                            widget.selectdata.add(widget
                                .catodata[index].catagory["cato"]
                                .toString()
                                .toLowerCase());
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Secondcato(
                                        widget.catodata[index].catagory["sub"],
                                        widget.selectdata)));
                            // print(widget.catodata[index].catagory["sub"]);
                          }
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.white,
                                  child: CachedNetworkImage(
                                    imageUrl: widget
                                        .catodata[index].catagory["img"]
                                        .toString(),
                                    fit: BoxFit.fill,
                                  )),
                              Bodytext(
                                  widget.catodata[index].catagory["cato"]
                                      .toString(),
                                  Colors.black),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ))));
  }
}

class Secondcato extends StatefulWidget {
  final Map<String, dynamic> catodata;
  final List getdata;
  Secondcato(this.catodata, this.getdata);

  @override
  _SecondcatoState createState() => _SecondcatoState();
}

class _SecondcatoState extends State<Secondcato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              widget.getdata.removeLast();
              Navigator.pop(context);
            }),
      ),
      body: Container(
          child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 1 / 1,
        children: widget.catodata.entries
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
                        depth: 5,
                        lightSource: LightSource.topLeft,
                        color: Colors.white),
                    child: InkWell(
                      onTap: () {
                        if (e.value["sub"] == null) {
                          print("sub is null");
                        } else {
                          widget.getdata
                              .add(e.key.toString().toLowerCase().trim());
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Thirdcato(
                                      e.value["sub"], widget.getdata)));
                        }
                      },
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                width: 50,
                                height: 50,
                                color: Colors.white,
                                child: CachedNetworkImage(
                                  imageUrl: e.value["img"].toString(),
                                  fit: BoxFit.fill,
                                )),
                            Bodytext(e.key.toString(), Colors.black),
                         
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      )),
    );
  }
}


class Thirdcato extends StatelessWidget {
 final Map data;
  final List getdata;
  Thirdcato(this.data, this.getdata);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              getdata.removeLast();
              Navigator.pop(context);
            }),
      ),
      body: Container(
          child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 1 / 1,
        children: data.entries
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
                        depth: 5,
                        lightSource: LightSource.topLeft,
                        color: Colors.white),
                    child: InkWell(
                      onTap: () async {
                        if (e.value["sub"] == null) {
                          await getdata
                              .add(e.key.toString().toLowerCase().trim());
                          print(getdata);
                          await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Inputdata(getdata, e.value["attr"])));
                        } else {
                          getdata.add(e.key.toString().toLowerCase().trim());
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Thirdcato(e.value["sub"], getdata)));
                        }
                      },
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                width: 50,
                                height: 50,
                                color: Colors.white,
                                child: CachedNetworkImage(
                                  imageUrl: e.value["img"].toString(),
                                  fit: BoxFit.fill,
                                )),
                            Bodytext(e.key.toString(), Colors.black),
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      )),
    );
  }
}
