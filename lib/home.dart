import 'dart:convert';

import 'package:enciclopiedia_deportiva/common/constants/colors.dart';
import 'package:enciclopiedia_deportiva/ui/custom_expansion_tile.dart'
    as custom;
import 'package:enciclopiedia_deportiva/ui/goal_keep_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchEdit;
  List<CategoryList> _list = new List();

  Future<List<CategoryList>> getListFromAssets() async {
    String jsonString = await rootBundle.loadString('assets/main_menu.json');
    List<dynamic> jsonArray = jsonDecode(jsonString);
    List<CategoryList> finalList = jsonArray
        .map((categoryList) => CategoryList.fromJSON(categoryList))
        .toList();
    return finalList;
  }

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

  Widget _searchBox() {
    return new Container(
      padding: EdgeInsets.all(5.0),
      alignment: Alignment.topLeft,
      child: new TextField(
        controller: _searchEdit,
        showCursor: true,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            List<CategoryList> _tempList = new List();
            for (int i = 0; i < _list.length; i++) {
              CategoryList data = _list[i];
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
        onChanged: (String value) {
          if (value.isEmpty && value.length == 0) {
            getListFromAssets().then((value) {
              setState(() {
                _list.clear();
                _list.addAll(value);
              });
            });
          } else if (value.isNotEmpty && value.length > 3) {
            List<CategoryList> _tempList = new List();
            for (int i = 0; i < _list.length; i++) {
              CategoryList data = _list[i];
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
        keyboardType: TextInputType.text,
        cursorColor: Colors.black,
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

  List<Widget> showSubList(List<String> subString) {
    List<Widget> subList = new List();

    for (var i = 0; i < subString.length; i++) {
      subList.add(InkWell(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 5.0, top: 5.0),
          child: Text(
            subString[i],
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              inherit: true,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GoalKeeperList(),
            ),
          );
        },
      ));
      if (subString.length > 1 && i < (subString.length - 1)) {
        subList.add(Divider(
          height: 2.0,
          thickness: 2.0,
          color: Colors.black,
        ));
      }
    }
    return subList;
  }

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    bool isExpanded = false;
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
                  height: 100.0,
                  width: 260.0,
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
                    children: [
                      _searchBox(),
                      /* SizedBox(
                        height: 10,
                      ),*/
                      Expanded(
                        child: new ListView.builder(
                          itemCount: _list.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return new custom.ExpansionTile(
                              title: new Text(
                                "${_list[index].title}",
                                style: TextStyle(
                                    color: isExpanded
                                        ? Color(0xffECD69D)
                                        : Colors.white),
                              ),
                              initiallyExpanded: false,
                              leading: Card(
                                color: Color(0xff545557),
                                margin: EdgeInsets.all(5.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    10.0,
                                  ),
                                ),
                                elevation: 1.0,
                                child: SvgPicture.asset(
                                  "${_list[index].image}",
                                  width: 40.0,
                                  height: 40.0,
                                  semanticsLabel: "Leading Icon",
                                  color: Color(0xffE36414),
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.center,
                                ),
                              ),
                              iconColor:
                                  isExpanded ? Color(0xffECD69D) : Colors.white,
                              children: <Widget>[
                                ...showSubList(_list[index].sub)
                              ],
                              onExpansionChanged: (bool expanding) {
                                setState(() {
                                  isExpanded = expanding;
                                });
                              },
                              headerBackgroundColor: darkBG,
                            );
                          },
                        ),

                        /*BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                            if (state == null) {
                              BlocProvider.of<CategoryBloc>(context)
                                  .add(FetchCategory());
                            }
                            if (state is CategoryInitial) {
                              BlocProvider.of<CategoryBloc>(context)
                                  .add(FetchCategory());
                              log("CategoryInitial");
                            }

                            if (state is CategoryError) {
                              return Center(
                                child: Text(
                                    "Error In Fetching Data! Check Your Internet."),
                              );
                            }
                            if (state is CategoryLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                ),
                              );
                            }
                            if (state is CategoryLoaded) {
                              List<CategoryEntity> parentList = new List();
                              for (var state in state.entity) {
                                if (state.level == "1") {
                                  parentList.add(state);
                                }
                              }
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                              ),
                            );
                          },
                        ),*/
                      ),
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

class CategoryList {
  String title;
  List<String> sub;
  String image;

  CategoryList.fromJSON(Map<String, dynamic> map)
      : title = map["title"],
        image = map['image'],
        sub = List.from(map['sub']);
}
