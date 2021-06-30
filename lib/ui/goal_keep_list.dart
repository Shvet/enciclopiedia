import 'dart:convert';

import 'package:enciclopiedia_deportiva/bloc/bloc.dart';
import 'package:enciclopiedia_deportiva/common/constants/colors.dart';
import 'package:enciclopiedia_deportiva/common/constants/general.dart';
import 'package:enciclopiedia_deportiva/ui/more_articales.dart';
import 'package:enciclopiedia_deportiva/ui/searched_article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_share/social_share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GoalKeeperList extends StatefulWidget {
  final String id;
  final String name;

  GoalKeeperList({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _GoalKeeperListState createState() => _GoalKeeperListState();
}

class _GoalKeeperListState extends State<GoalKeeperList> {
  late TextEditingController _searchEdit;

  // List<CategorySubEntity> _list = <CategorySubEntity>[];
  late PageController controller;
  int currentPageValue = 0;
  int previousPageValue = 0;
  double _moveBar = 0.0;
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  bool isSearching = false;
  WebViewController? _controller;
  double webViewHeight = 10.0;
  double webViewWidth = 10.0;

  @override
  void initState() {
    _searchEdit = new TextEditingController();
    super.initState();
    controller = PageController(initialPage: currentPageValue);
    BlocProvider.of<CategorySubBloc>(context)
        .add(FetchCategorySub(id: widget.id));
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
            BlocProvider.of<CategorySubBloc>(context)
                .add(FetchCategorySub(id: widget.id));
          } else if (value.isNotEmpty && value.length >= 3) {
            setState(() {
              isSearching = true;
            });
            BlocProvider.of<SearchBloc>(context)
                .add(SearchData(keyWord: value));
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

/*  Widget _html(String data) {
    return Html(
      data: data
          .replaceAll("<td><span style=\"font-size: 12pt;\">", "<th>")
          .replaceAll("<\/span><\/td>", "<\/th>")
          .replaceAll("<td><span style=\"font-size: 14pt;\">", "<th>")
          .replaceAll("<td><strong><span style=\"font-size: 14pt;\">", "<th><strong>")
          .replaceAll("<\/span><\/strong><\/td>", "<\/strong><\/th>")
          .replaceAll("&nbsp;", "")
          .replaceAll("<td><\/td>", "")
          .replaceAll("<tr><\/tr>", ""),
      shrinkWrap: false,
      style: {
        "table": Style(
          border: Border(
            bottom: BorderSide(color: Colors.grey),
          ),
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
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          backgroundColor: Colors.white,
          textAlign: TextAlign.justify,
          fontSize: FontSize(12.0),
          alignment: Alignment.center,
          verticalAlign: VerticalAlign.BASELINE,
        ),
        "td": Style(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          backgroundColor: Colors.white,
          width: double.maxFinite,
          textAlign: TextAlign.justify,
          fontSize: FontSize(13.5),
          alignment: Alignment.center,
          verticalAlign: VerticalAlign.BASELINE,
          whiteSpace: WhiteSpace.NORMAL,
        ),
      },
      customRender: {
        "table": (context, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: ScrollPhysics(),
            child: (context.tree as TableLayoutElement).toWidget(context),
          );
        },
      },
    );
  }*/

  Widget _widgetFromHtml(String data) {
    if (isIos) {
      String finalData =
          """ <!DOCTYPE html><html><head><meta name='viewport' content='width=device-width, initial-scale=1.0'><style> body {font-size:18px}<\/style><\/head><body style='"margin: 0; padding: 0;'>$data<\/body><\/html>""";
      return WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) async {
          _controller = controller;
        },
        gestureRecognizers: [
          Factory(() => VerticalDragGestureRecognizer()),
          Factory(() => HorizontalDragGestureRecognizer()),
          Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
        ].toSet(),
        onPageFinished: (url) async {
          double newHeight = double.parse(await _controller!
              .evaluateJavascript("document.documentElement.scrollHeight;"));
          double newWidth = double.parse(await _controller!
              .evaluateJavascript("document.documentElement.scrollWidth;"));
          setState(() {
            webViewHeight = newHeight;
            webViewHeight = newWidth;
          });
        },
        gestureNavigationEnabled: true,
        initialUrl: Uri.dataFromString(
                finalData
                    .replaceAll("<td><span style=\"font-size: 12pt;\">", "<th>")
                    .replaceAll("<\/span><\/td>", "<\/th>")
                    .replaceAll("<td><span style=\"font-size: 14pt;\">", "<th>")
                    .replaceAll("<td><strong><span style=\"font-size: 14pt;\">",
                        "<th><strong>")
                    .replaceAll("<\/span><\/strong><\/td>", "<\/strong><\/th>"),
                mimeType: "text/html",
                encoding: Encoding.getByName('utf-8'))
            .toString(),
      );
    } else {
      String finalData =
          "<!DOCTYPE html><html><head><style> body {font-size:12px}<\/style><\/head><body>" +
              data +
              "<\/body><\/html>";
      return WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) async {
          _controller = controller;
        },
        gestureRecognizers: [
          Factory(() => VerticalDragGestureRecognizer()),
          Factory(() => HorizontalDragGestureRecognizer()),
          Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
        ].toSet(),
        onPageFinished: (url) async {
          double newHeight = double.parse(await _controller!
              .evaluateJavascript("document.documentElement.scrollHeight;"));
          double newWidth = double.parse(await _controller!
              .evaluateJavascript("document.documentElement.scrollWidth;"));
          setState(() {
            webViewHeight = newHeight;
            webViewHeight = newWidth;
          });
        },
        gestureNavigationEnabled: true,
        initialUrl: Uri.dataFromString(
                finalData
                    .replaceAll("<td><span style=\"font-size: 12pt;\">", "<th>")
                    .replaceAll("<\/span><\/td>", "<\/th>")
                    .replaceAll("<td><span style=\"font-size: 14pt;\">", "<th>")
                    .replaceAll("<td><strong><span style=\"font-size: 14pt;\">",
                        "<th><strong>")
                    .replaceAll("<\/span><\/strong><\/td>", "<\/strong><\/th>"),
                mimeType: "text/html",
                encoding: Encoding.getByName('utf-8'))
            .toString(),
      );
    }

    /*return HtmlWidget(
      data
     .replaceAll("<td><span style=\"font-size: 12pt;\">", "<th>")
          .replaceAll("<\/span><\/td>", "<\/th>")
          .replaceAll("<td><span style=\"font-size: 14pt;\">", "<th>")
          .replaceAll("<td><strong><span style=\"font-size: 14pt;\">", "<th><strong>")
          .replaceAll("<\/span><\/strong><\/td>", "<\/strong><\/th>")
          .replaceAll("<tr><\/tr>", "")
      ,
      textStyle: TextStyle(
        fontSize: 12.0,
        textBaseline: TextBaseline.alphabetic,
      ),
      enableCaching: true,
      customStylesBuilder: (element) {
        if (element.className.contains('body')) {
          return {
            'white-space': 'normal',
            'text-align': 'justify',
            'word-break': 'break-all',
            'word-wrap': 'break-word',
          };
        } else if (element.className.contains('table')) {
          return {
            'max-width': '100%',
          };
        } else if (element.className.contains('td')) {
          return {
            'text-align': 'justify',
            'word-break': 'break-all',
            'text-overflow': 'clip',
          };
        }
      },
    );*/
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
    screenWidth = MediaQuery.maybeOf(context)!.size.width;
    screenHeight = MediaQuery.maybeOf(context)!.size.height;
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
          middle: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            scale: 0.2,
            height: 30,
            width: 250,
            semanticLabel: "Logo",
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
              /* Padding(
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
              ),*/
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
                      top: 10.0,
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
                                  child: Text(state
                                      .error), //No se encontraron resultados
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
                                if (state.list.data!.isEmpty ||
                                    state.list.data!.length == 0) {
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
                        Visibility(
                          visible: !isSearching,
                          child: BlocBuilder<CategorySubBloc, CategorySubState>(
                            builder: (context, state) {
                              // List<CategorySubEntity> _list = <CategorySubEntity>[];
                              if (state is CategorySubInitial) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state is CategorySubError) {
                                return Center(
                                  child: Text(state
                                      .error), //There is Error in Fetching data
                                );
                              }
                              if (state is CategorySubLoaded) {
                                // _list.addAll(state.list);
                                return Expanded(
                                  child: Stack(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    children: <Widget>[
                                      PageView.builder(
                                        physics: ClampingScrollPhysics(),
                                        itemCount: state.list.length,
                                        controller: controller,
                                        onPageChanged: (int page) {
                                          getChangedPageAndMoveBar(page);
                                        },
                                        itemBuilder: (context, index) =>
                                            ListView(
                                          shrinkWrap: false,
                                          physics: ScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          children: [
                                            Text(
                                              state.list[index].title!,
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
                                            Container(
                                              height: webViewHeight,
                                              width: webViewWidth,
                                              child: _widgetFromHtml(state
                                                  .list[index].introtext!
                                                  .trim()),
                                            ),
                                            SizedBox(
                                              height: 30.0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Future<String?> s =
                                                      SocialShare.shareTwitter(
                                                          "Enciclopedia Deportiva-${widget.name} ",
                                                          trailingText: "",
                                                          hashtags: [
                                                            "EnciclopediaDeportiva"
                                                          ],
                                                          url:
                                                              "https://apps.apple.com/us/app/enciclopedia-deportiva/id1542621011");
                                                  s.then((value) {
                                                    // ignore: unnecessary_null_comparison
                                                    if (value != null) {
                                                      final snackBar = SnackBar(
                                                        content: Text(value),
                                                        elevation: 5.0,
                                                        duration: Duration(
                                                            seconds: 1),
                                                      );
                                                      ScaffoldMessenger.maybeOf(
                                                              context)!
                                                          .showSnackBar(
                                                              snackBar);
                                                    } else {
                                                      final snackBar = SnackBar(
                                                        content: Text(
                                                            "You do not have twitter app installed"),
                                                        elevation: 5.0,
                                                        duration: Duration(
                                                            seconds: 1),
                                                      );
                                                      ScaffoldMessenger.maybeOf(
                                                              context)!
                                                          .showSnackBar(
                                                              snackBar);
                                                    }
                                                  });
                                                },
                                                child: Image.asset(
                                                    "assets/images/tweeter.png"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            SizedBox(
                                              height: 50.0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  final page =
                                                      MoreArticles(state.list);
                                                  Navigator.push(
                                                    context,
                                                    CupertinoPageRoute(
                                                      builder: (context) =>
                                                          page,
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
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
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
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
                                              controller.jumpToPage(
                                                  currentPageValue + 1);
                                              currentPageValue += 1;
                                            },
                                            child: Icon(Icons.arrow_forward),
                                          ),
                                        ),
                                        alignment:
                                            AlignmentDirectional.bottomEnd,
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
          title: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            scale: 0.2,
            height: 30,
            width: 30,
            semanticLabel: "Logo",
          ),
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
                      top: 10.0,
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
                                if (state.list.data!.isEmpty ||
                                    state.list.data!.length == 0) {
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
                                  child:
                                      Text("There is Error in Fetching data"),
                                );
                              }
                              if (state is CategorySubLoaded) {
                                return Expanded(
                                  child: Stack(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    children: <Widget>[
                                      PageView.builder(
                                        physics: ClampingScrollPhysics(),
                                        itemCount: state.list.length,
                                        controller: controller,
                                        onPageChanged: (int page) {
                                          getChangedPageAndMoveBar(page);
                                        },
                                        itemBuilder: (context, index) =>
                                            ListView(
                                          shrinkWrap: false,
                                          physics: ScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          children: [
                                            Text(
                                              state.list[index].title!,
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
                                            Container(
                                              height: webViewHeight,
                                              width: webViewWidth,
                                              child: _widgetFromHtml(state
                                                  .list[index].introtext!
                                                  .trim()),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: SizedBox(
                                                height: 30.0,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    SocialShare.shareTwitter(
                                                        "Enciclopedia Deportiva-${widget.name}",
                                                        trailingText: "",
                                                        hashtags: [
                                                          "EnciclopediaDeportiva"
                                                        ],
                                                        url:
                                                            "https://play.google.com/store/apps/details?id=com.str.enciclopiedia_deportiva");
                                                  },
                                                  child: Image.asset(
                                                      "assets/images/tweeter.png"),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            SizedBox(
                                              height: 50.0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  final page =
                                                      MoreArticles(state.list);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          page,
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
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
                                      Align(
                                        alignment:
                                            AlignmentDirectional.bottomEnd,
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
                                              controller.jumpToPage(
                                                  currentPageValue + 1);
                                              currentPageValue += 1;
                                            },
                                            child: Icon(Icons.arrow_forward),
                                          ),
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
