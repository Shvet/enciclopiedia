import 'package:enciclopiedia_deportiva/bloc/bloc.dart';
import 'package:enciclopiedia_deportiva/common/constants/colors.dart';
import 'package:enciclopiedia_deportiva/common/constants/general.dart';
import 'package:enciclopiedia_deportiva/models/category_sub_entity.dart';
import 'package:enciclopiedia_deportiva/ui/more_articales.dart';
import 'package:enciclopiedia_deportiva/ui/searched_article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_share/social_share.dart';

class GoalKeeperList extends StatefulWidget {
  final String id;
  final String name;

  GoalKeeperList({Key key, @required this.id, @required this.name}) : super(key: key);

  @override
  _GoalKeeperListState createState() => _GoalKeeperListState();
}

class _GoalKeeperListState extends State<GoalKeeperList> {
  TextEditingController _searchEdit;
  List<CategorySubEntity> _list = <CategorySubEntity>[];
  PageController controller;
  int currentPageValue = 0;
  int previousPageValue = 0;
  double _moveBar = 0.0;
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  bool isSearching = false;

  @override
  void initState() {
    _searchEdit = new TextEditingController();
    super.initState();
    controller = PageController(initialPage: currentPageValue);
    BlocProvider.of<CategorySubBloc>(context).add(FetchCategorySub(id: widget.id));
  }

  void getChangedPageAndMoveBar(int page) {
    print('page is $page');
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

  Widget _searchBox() {
    return new Container(
      padding: EdgeInsets.all(5.0),
      alignment: Alignment.topLeft,
      child: new TextField(
        controller: _searchEdit,
        showCursor: true,
        textInputAction: TextInputAction.search,
        cursorColor: Colors.black,
        onChanged: (value) {
          if (value.isEmpty && value.length == 0) {
            setState(() {
              isSearching = false;
            });
            BlocProvider.of<CategorySubBloc>(context).add(FetchCategorySub(id: widget.id));
          } else if (value.isNotEmpty && value.length >= 3) {
            setState(() {
              isSearching = true;
            });
            BlocProvider.of<SearchBloc>(context).add(SearchData(keyWord: value));
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

  Widget _html(String data) {
    return Html(
      data: data
          .replaceAll("<td><span style=\"font-size: 12pt;\">", "<th>")
          .replaceAll("<\/span><\/td>", "<\/th>")
          .replaceAll("<td><span style=\"font-size: 14pt;\">", "<th>")
          .replaceAll("<td><strong><span style=\"font-size: 14pt;\">", "<th><strong>")
          .replaceAll("<\/span><\/strong><\/td>", "<\/strong><\/th>"),
      shrinkWrap: true,
      style: {
        "table": Style(
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
        "tr": Style(
          border: Border(
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
        "th": Style(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              style: BorderStyle.solid,
            ),
          ),
          padding: EdgeInsets.all(5.0),
          backgroundColor: Colors.white,
          textAlign: TextAlign.center,
          fontSize: FontSize(9.0),
          alignment: Alignment.topCenter,
          verticalAlign: VerticalAlign.SUB,
        ),
        "td": Style(
          padding: EdgeInsets.all(6),
        ),
      },
    );
  }

  Container movingBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 5,
      width: screenWidth * 0.1,
      decoration: BoxDecoration(color: Colors.deepOrangeAccent),
    );
  }

  Widget slidingBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 5,
      width: screenWidth * 0.1,
      decoration: BoxDecoration(color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.maybeOf(context).size.width;
    screenHeight = MediaQuery.maybeOf(context).size.height;
    if (isIos) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: darkBG,
          brightness: Brightness.dark,
          leading: CupertinoNavigationBarBackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        resizeToAvoidBottomInset: false,
        child: Container(
          alignment: Alignment.topCenter,
          color: darkBG,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
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
                        Visibility(
                          visible: isSearching,
                          child: BlocBuilder<SearchBloc, SearchState>(
                            builder: (context, state) {
                              if (state is SearchError) {
                                return Center(
                                  child: Text(state.error), //No se encontraron resultados
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
                                if (state.list.data.isEmpty || state.list.data.length == 0) {
                                  return Center(
                                    child: Text("No se encontraron resultados"),
                                  );
                                }
                                return Expanded(
                                  child: ListView.separated(
                                    physics: ScrollPhysics(),
                                    itemCount: state.list.data.length,
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
                                            entity: state.list.data[index],
                                          );
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => page,
                                            ),
                                          );
                                        },
                                        title: Text(
                                          state.list.data[index].title,
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
                        Visibility(
                          visible: !isSearching,
                          child: BlocBuilder<CategorySubBloc, CategorySubState>(
                            builder: (context, state) {
                              if (state is CategorySubInitial) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state is CategorySubError) {
                                return Center(
                                  child: Text(state.error), //There is Error in Fetching data
                                );
                              }
                              if (state is CategorySubLoaded) {
                                _list.addAll(state.list);
                                return Expanded(
                                  child: Stack(
                                    alignment: AlignmentDirectional.bottomCenter,
                                    children: <Widget>[
                                      PageView.builder(
                                        physics: ClampingScrollPhysics(),
                                        itemCount: _list.length,
                                        controller: controller,
                                        onPageChanged: (int page) {
                                          getChangedPageAndMoveBar(page);
                                        },
                                        itemBuilder: (context, index) => Column(
                                          children: [
                                            Text(
                                              _list[index].title,
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
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    _html(_list[index].introtext),
                                                    SizedBox(
                                                      height: 30.0,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Future<String> s = SocialShare.shareTwitter(
                                                              "Enciclopedia Deportiva-${widget.name}",
                                                              trailingText: widget.name,
                                                              hashtags: ["EnciclopediaDeportiva"],
                                                              url:
                                                                  "https://apps.apple.com/us/app/enciclopedia-deportiva/id1542621011");
                                                          s.then((value) {
                                                            final snackBar = SnackBar(
                                                              content: Text(value),
                                                              elevation: 5.0,
                                                              duration: Duration(seconds: 1),
                                                            );
                                                            ScaffoldMessenger.maybeOf(context).showSnackBar(snackBar);
                                                          });
                                                        },
                                                        child: Image.asset("assets/images/tweeter.png"),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    SizedBox(
                                                      height: 50.0,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          final page = MoreArticles(_list);
                                                          Navigator.push(
                                                            context,
                                                            CupertinoPageRoute(
                                                              builder: (context) => page,
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            color: Color(0xffF8EDD7),
                                                            border: Border.all(
                                                              color: Color(0xFFffd25d),
                                                              width: 2.0,
                                                            ),
                                                            shape: BoxShape.rectangle,
                                                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                          ),
                                                          child: Text(
                                                            "Más artículos...",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              inherit: true,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: true,
                                        child: Align(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              bottom: 10.0,
                                              right: 10.0,
                                            ),
                                            child: FloatingActionButton(
                                              backgroundColor: Color(0xFFE36414),
                                              shape: BeveledRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(25),
                                                ),
                                              ),
                                              onPressed: () {
                                                controller.jumpToPage(currentPageValue + 1);
                                                currentPageValue += 1;
                                              },
                                              child: Icon(Icons.arrow_forward),
                                            ),
                                          ),
                                          alignment: AlignmentDirectional.bottomEnd,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
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
            children: <Widget>[
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
                                if (state.list.data.isEmpty || state.list.data.length == 0) {
                                  return Center(
                                    child: Text("No se encontraron resultados"),
                                  );
                                }
                                return Expanded(
                                  child: ListView.separated(
                                    physics: ScrollPhysics(),
                                    itemCount: state.list.data.length,
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
                                            entity: state.list.data[index],
                                          );
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => page,
                                            ),
                                          );
                                        },
                                        title: Text(
                                          state.list.data[index].title,
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
                        Visibility(
                          visible: !isSearching,
                          child: BlocBuilder<CategorySubBloc, CategorySubState>(
                            builder: (context, state) {
                              if (state is CategorySubInitial) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state is CategoryError) {
                                return Center(
                                  child: Text("There is Error in Fetching data"),
                                );
                              }
                              if (state is CategorySubLoaded) {
                                _list.addAll(state.list);
                                return Expanded(
                                  child: Stack(
                                    alignment: AlignmentDirectional.bottomCenter,
                                    children: <Widget>[
                                      PageView.builder(
                                        physics: ClampingScrollPhysics(),
                                        itemCount: _list.length,
                                        controller: controller,
                                        onPageChanged: (int page) {
                                          getChangedPageAndMoveBar(page);
                                        },
                                        itemBuilder: (context, index) => Column(
                                          children: [
                                            Text(
                                              _list[index].title,
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
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    _html(_list[index].introtext),
                                                    SizedBox(
                                                      height: 30.0,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          SocialShare.shareTwitter(
                                                              "Enciclopedia Deportiva-${widget.name}",
                                                              trailingText: "",
                                                              hashtags: ["EnciclopediaDeportiva"],
                                                              url:
                                                                  "https://play.google.com/store/apps/details?id=com.str.enciclopiedia_deportiva");
                                                        },
                                                        child: Image.asset("assets/images/tweeter.png"),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    SizedBox(
                                                      height: 50.0,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          final page = MoreArticles(_list);
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => page,
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            color: Color(0xffF8EDD7),
                                                            border: Border.all(
                                                              color: Color(0xFFffd25d),
                                                              width: 2.0,
                                                            ),
                                                            shape: BoxShape.rectangle,
                                                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                          ),
                                                          child: Text(
                                                            "Más artículos...",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              inherit: true,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: true,
                                        child: Align(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              bottom: 10.0,
                                              right: 10.0,
                                            ),
                                            child: FloatingActionButton(
                                              backgroundColor: Color(0xFFE36414),
                                              shape: BeveledRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(25),
                                                ),
                                              ),
                                              onPressed: () {
                                                controller.jumpToPage(currentPageValue + 1);
                                                currentPageValue += 1;
                                              },
                                              child: Icon(Icons.arrow_forward),
                                            ),
                                          ),
                                          alignment: AlignmentDirectional.bottomEnd,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
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

/*ListView.separated(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                              ),*/
/*Column(
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
mainAxisAlignment:
MainAxisAlignment.spaceEvenly,
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
SizedBox(
height: 50.0,
child: Container(
alignment: Alignment.center,
decoration: BoxDecoration(
color: Colors.redAccent[100],
border: Border.all(
color: Colors.deepOrange,
width: 2.0,
),
shape: BoxShape.rectangle,
borderRadius:
BorderRadius.all(Radius.circular(5.0)),
),
child: Text(
"Más artículos...",
textAlign: TextAlign.center,
),
),
),
],
);*/
