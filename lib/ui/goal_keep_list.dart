import 'dart:convert';

import 'package:enciclopiedia_deportiva/common/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class GoalKeeperList extends StatefulWidget {
  @override
  _GoalKeeperListState createState() => _GoalKeeperListState();
}

class _GoalKeeperListState extends State<GoalKeeperList> {
  TextEditingController _searchEdit;
  List<GoalKeeper> _list = new List();

  @override
  void initState() {
    _searchEdit = new TextEditingController();
    getListFromAssets().then((value) {
      setState(() {
        _list.addAll(value);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchEdit.dispose();
    super.dispose();
  }

  Future<List<GoalKeeper>> getListFromAssets() async {
    String jsonString = await rootBundle.loadString('assets/goal_keeper.json');
    List<dynamic> jsonArray = jsonDecode(jsonString);
    List<GoalKeeper> finalList = jsonArray
        .map((categoryList) => GoalKeeper.fromJSON(categoryList))
        .toList();
    return finalList;
  }

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
            List<GoalKeeper> _tempList = new List();
            for (int i = 0; i < _list.length; i++) {
              GoalKeeper data = _list[i];
              if (data.goalKeeper.toLowerCase().contains(value.toLowerCase())) {
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
            getListFromAssets().then((value) {
              _list.clear();
              _list.addAll(value);
            });
          } else if (value.isNotEmpty && value.length > 3) {
            List<GoalKeeper> _tempList = new List();
            for (int i = 0; i < _list.length; i++) {
              GoalKeeper data = _list[i];
              if (data.goalKeeper.toLowerCase().contains(value.toLowerCase())) {
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
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      primary: true,
      body: Container(
        alignment: Alignment.topCenter,
        color: darkBG,
        margin: EdgeInsets.only(top: statusBarHeight),
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
                      Text(
                        "ARQUEROS QUE HAN MARCADO GOLES EN FUTBOL ECUATORIANO",
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                          color: darkBG,
                        ),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Divider(
                        color: darkBG,
                        height: 2.0,
                        thickness: 2.0,
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: _list.length,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => Divider(
                            height: 1.0,
                            color: Colors.grey,
                            thickness: 1.0,
                          ),
                          itemBuilder: (context, index) => Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  height: 50.0,
                                  child: Center(
                                    child: Text(
                                      _list[index]._goalKeeper,
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          inherit: true,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 50.0,
                                  child: Center(
                                    child: Text(
                                      _list[index]._goal,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  width: 50.0,
                                  child: Text(
                                    _list[index]._penalty,
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text("Más artículos..."),
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

class GoalKeeper {
  String _goalKeeper;
  String _goal;
  String _penalty;

  GoalKeeper.fromJSON(Map<String, dynamic> map)
      : _goalKeeper = map['name'],
        _goal = map['goals'],
        _penalty = map['penalty'];

  String get goalKeeper => _goalKeeper;

  String get penalty => _penalty;

  String get goal => _goal;
}
