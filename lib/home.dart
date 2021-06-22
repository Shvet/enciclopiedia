import 'dart:convert';

import 'package:enciclopiedia_deportiva/bloc/search_bloc.dart';
import 'package:enciclopiedia_deportiva/common/constants/colors.dart';
import 'package:enciclopiedia_deportiva/models/category_main_entity.dart';
import 'package:enciclopiedia_deportiva/ui/custom_expansion_tile.dart' as custom;
import 'package:enciclopiedia_deportiva/ui/goal_keep_list.dart';
import 'package:enciclopiedia_deportiva/ui/searched_article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'common/constants/general.dart';
import 'generated/json/category_main_entity_helper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController _searchEdit;
  List<CategoryMainEntity> _list = [];
  bool isSearching = false;
  late PageController controller;
  int currentPageValue = 0;
  int previousPageValue = 0;
  double _moveBar = 0.0;
  double screenWidth = 0.0;
  double screenHeight = 0.0;

  Future<List<CategoryMainEntity>> getListFromAssets() async {
    String jsonString = await rootBundle.loadString('assets/main_menu.json');

    List<dynamic> jsonArray = jsonDecode(jsonString);

    List<CategoryMainEntity> finalList = jsonArray
        .map((categoryList) => categoryMainEntityFromJson(new CategoryMainEntity(), categoryList))
        .cast<CategoryMainEntity>()
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
    controller = PageController(initialPage: currentPageValue);
    super.initState();
  }

  void getChangedPageAndMoveBar(int page) {
    if (previousPageValue == 0) {
      previousPageValue = page;
      _moveBar = _moveBar + 0.14;
    } else {
      if (previousPageValue < page) {
        previousPageValue = page;
        _moveBar = _moveBar + 0.14;
      } else {
        previousPageValue = page;
        _moveBar = _moveBar - 0.14;
      }
      currentPageValue = page;
    }

    setState(() {});
  }

  @override
  void dispose() {
    _searchEdit.dispose();
    super.dispose();
  }

  List<Widget> showSubList(List<CategoryMainSub> subString) {
    List<Widget> subList = [];
    for (var i = 0; i < subString.length; i++) {
      subList.add(InkWell(
        child: Container(
          alignment: Alignment.topLeft,
          width: double.maxFinite,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, bottom: 5.0, top: 5.0),
            child: Text(
              subString[i].name!,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                inherit: true,
              ),
            ),
          ),
        ),
        onTap: () {
          final page = GoalKeeperList(
            id: subString[i].id!,
            name: subString[i].name!,
          );
          if (isIos) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => page,
              ),
            );
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          }
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
    screenWidth = MediaQuery.maybeOf(context)!.size.width;
    screenHeight = MediaQuery.maybeOf(context)!.size.height;
    bool isExpanded = false;
    if (isIos) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: darkBG,
          brightness: Brightness.dark,
        ),
        child: Container(
          height: screenHeight,
          width: screenWidth,
          alignment: Alignment.topCenter,
          color: darkBG,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
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
                        Container(
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.topLeft,
                          child: new TextField(
                            controller: _searchEdit,
                            showCursor: true,
                            textInputAction: TextInputAction.done,
                            onChanged: (String value) {
                              if (value.isEmpty && value.length == 0) {
                                getListFromAssets().then((value) {
                                  setState(() {
                                    isSearching = false;
                                    _list.clear();
                                    _list.addAll(value);
                                  });
                                });
                              } else if (value.isNotEmpty && value.length >= 3) {
                                setState(() {
                                  isSearching = true;
                                });
                                BlocProvider.of<SearchBloc>(context).add(SearchData(keyWord: value));
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
                        ),
                        Visibility(
                          visible: !isSearching,
                          child: Expanded(
                            child: new ListView.builder(
                              itemCount: _list.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return custom.ExpansionTile(
                                  title: new Text(
                                    "${_list[index].title}",
                                    style: TextStyle(color: isExpanded ? Color(0xffECD69D) : Colors.white),
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
                                  iconColor: isExpanded ? Color(0xffECD69D) : Colors.white,
                                  children: <Widget>[...showSubList(_list[index].sub!)],
                                  onExpansionChanged: (bool expanding) {
                                    setState(() {
                                      isExpanded = expanding;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isSearching,
                          child: BlocBuilder<SearchBloc, SearchState>(
                            builder: (context, state) {
                              if (state is SearchError) {
                                return Center(
                                  child: Text("No se encontraron resultados"),
                                );
                              }
                              if (state is SearchLoading) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                  ),
                                );
                              }
                              if (state is SearchLoaded) {
                                if (state.list.data!.isEmpty || state.list.data!.length == 0) {
                                  return Center(
                                    child: Text("No se encontraron resultados"),
                                  );
                                }
                                return Expanded(
                                  child: ListView.separated(
                                    physics: ScrollPhysics(),
                                    itemCount: state.list.data!.length,
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        color: Colors.grey[350],
                                        height: 1.0,
                                        thickness: 1.0,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: () {
                                          final page = SearchedArticle(
                                            entity: state.list.data![index],
                                          );
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => page,
                                            ),
                                          );
                                        },
                                        title: Text(
                                          state.list.data![index].title!,
                                          style: TextStyle(
                                            color: Colors.lightBlue[400],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                ),
                              );
                            },
                            buildWhen: (searchState, searchState1) {
                              return isSearching;
                            },
                          ),
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
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: darkBG,
          brightness: Brightness.dark,
        ),
        resizeToAvoidBottomInset: false,
        primary: true,
        body: Container(
          height: screenHeight,
          width: screenWidth,
          alignment: Alignment.topCenter,
          color: darkBG,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
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
                        Container(
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.topLeft,
                          child: new TextField(
                            controller: _searchEdit,
                            showCursor: true,
                            textInputAction: TextInputAction.done,
                            onChanged: (String value) {
                              if (value.isEmpty && value.length == 0) {
                                getListFromAssets().then((value) {
                                  setState(() {
                                    isSearching = false;
                                    _list.clear();
                                    _list.addAll(value);
                                  });
                                });
                              } else if (value.isNotEmpty && value.length >= 3) {
                                setState(() {
                                  isSearching = true;
                                });
                                BlocProvider.of<SearchBloc>(context).add(SearchData(keyWord: value));
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
                        ),
                        Visibility(
                          visible: !isSearching,
                          child: Expanded(
                            child: new ListView.builder(
                              itemCount: _list.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return new custom.ExpansionTile(
                                  title: new Text(
                                    "${_list[index].title}",
                                    style: TextStyle(color: isExpanded ? Color(0xffECD69D) : Colors.white),
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
                                  iconColor: isExpanded ? Color(0xffECD69D) : Colors.white,
                                  children: <Widget>[...showSubList(_list[index].sub!)],
                                  onExpansionChanged: (bool expanding) {
                                    setState(() {
                                      isExpanded = expanding;
                                    });
                                  },
                                  backgroundColor: Colors.white,
                                );
                              },
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isSearching,
                          child: BlocBuilder<SearchBloc, SearchState>(
                            builder: (context, state) {
                              if (state is SearchError) {
                                return Center(
                                  child: Text("No se encontraron resultados"),
                                );
                              }
                              if (state is SearchLoading) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                  ),
                                );
                              }
                              if (state is SearchLoaded) {
                                if (state.list.data!.isEmpty || state.list.data!.length == 0) {
                                  return Center(
                                    child: Text("No se encontraron resultados"),
                                  );
                                }
                                return Expanded(
                                  child: ListView.separated(
                                    physics: ScrollPhysics(),
                                    itemCount: state.list.data!.length,
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        color: Colors.grey[350],
                                        height: 1.0,
                                        thickness: 1.0,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: () {
                                          final page = SearchedArticle(
                                            entity: state.list.data![index],
                                          );
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => page,
                                            ),
                                          );
                                        },
                                        title: Text(
                                          state.list.data![index].title!,
                                          style: TextStyle(
                                            color: Colors.lightBlue[400],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                ),
                              );
                            },
                            buildWhen: (searchState, searchState1) {
                              return isSearching;
                            },
                          ),
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
}
