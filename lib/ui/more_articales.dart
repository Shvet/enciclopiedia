import 'dart:developer';

import 'package:enciclopiedia_deportiva/common/constants/colors.dart';
import 'package:enciclopiedia_deportiva/models/category_sub_entity.dart';
import 'package:enciclopiedia_deportiva/ui/single_articales.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreArticles extends StatefulWidget {
  final List<CategorySubEntity> list;

  MoreArticles(this.list) : assert(list != null);

  @override
  _MoreArticlesState createState() => _MoreArticlesState();
}

class _MoreArticlesState extends State<MoreArticles> {
  TextEditingController _searchEdit;
  List<CategorySubEntity> _list;

  Widget _searchBox() {
    return new Container(
      padding: EdgeInsets.all(5.0),
      alignment: Alignment.topLeft,
      child: new TextField(
        controller: _searchEdit,
        showCursor: true,
        textInputAction: TextInputAction.search,
        cursorColor: Colors.black,
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            List<CategorySubEntity> _tempList = new List();
            for (int i = 0; i < _list.length; i++) {
              CategorySubEntity data = _list[i];
              if (data.title.toLowerCase().contains(value.toLowerCase())) {
                _tempList.add(data);
              }
            }
            setState(() {
              _list.clear();
              _list.addAll(_tempList);
            });
          }
        },
        onChanged: (value) {
          if (value.isEmpty && value.length == 0) {
            log("Main List size ${widget.list.length}");
            setState(() {
              _list.clear();
              _list = widget.list;
            });
          } else if (value.isNotEmpty && value.length > 3) {
            List<CategorySubEntity> _tempList = new List();
            for (int i = 0; i < _list.length; i++) {
              CategorySubEntity data = _list[i];
              if (data.title.toLowerCase().contains(value.toLowerCase())) {
                _tempList.add(data);
              }
            }
            setState(() {
              _list.clear();
              _list.addAll(_tempList);
            });
          }
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          hintText: "buscar...",
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          hintStyle: new TextStyle(color: Colors.grey[300]),
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  @override
  void initState() {
    _searchEdit = new TextEditingController();
    _list = widget.list;
    super.initState();
  }

  @override
  void dispose() {
    _searchEdit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBG,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            semanticLabel: "Back Button",
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      primary: true,
      body: Container(
        alignment: Alignment.topCenter,
        color: darkBG,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: SizedBox(
                height: 100,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  scale: 0.2,
                  height: 30,
                  width: 250,
                  semanticLabel: "Logo",
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Card(
                elevation: 20.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(30.0),
                    topEnd: Radius.circular(30.0),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    top: 20.0,
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _searchBox(),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              "Más artículos",
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                                color: darkBG,
                              ),
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              color: darkBG,
                              thickness: 1.0,
                            ),
                            Expanded(
                              child: ListView.separated(
                                itemCount: _list.length,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                separatorBuilder: (context, int) {
                                  return Divider(
                                    color: Colors.grey[350],
                                    height: 1.0,
                                    thickness: 1.0,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      _list[index].title,
                                      style: TextStyle(
                                        color: Colors.lightBlue[400],
                                      ),
                                    ),
                                    onTap: () {
                                      final page = SingleArticles(
                                          categorySubEntity: _list[index]);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => page,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
