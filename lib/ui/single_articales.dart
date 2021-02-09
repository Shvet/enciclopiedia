import 'package:enciclopiedia_deportiva/common/constants/colors.dart';
import 'package:enciclopiedia_deportiva/common/constants/general.dart';
import 'package:enciclopiedia_deportiva/models/category_sub_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleArticles extends StatefulWidget {
  final CategorySubEntity categorySubEntity;

  const SingleArticles({Key key, @required this.categorySubEntity}) : super(key: key);

  @override
  _SingleArticlesState createState() => _SingleArticlesState();
}

class _SingleArticlesState extends State<SingleArticles> {
  @override
  Widget build(BuildContext context) {
    if (isIos) {
      return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: darkBG,
          brightness: Brightness.dark,
          leading: CupertinoNavigationBarBackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
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
                      children: [
                        Text(
                          widget.categorySubEntity.title,
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
                                Html(
                                  data: widget.categorySubEntity.introtext,
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
                                      padding: EdgeInsets.all(6),
                                      backgroundColor: Colors.grey,
                                      textAlign: TextAlign.center,
                                      fontSize: FontSize(14.0),
                                    ),
                                    "td": Style(
                                      padding: EdgeInsets.all(6),
                                    ),
                                  },
                                ),
                              ],
                            ),
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
                      children: [
                        Text(
                          widget.categorySubEntity.title,
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
                                Html(
                                  data: widget.categorySubEntity.introtext.replaceAll("<td></td>", ""),
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
                                      padding: EdgeInsets.all(6),
                                      backgroundColor: Colors.grey,
                                      textAlign: TextAlign.center,
                                    ),
                                    "td": Style(
                                      padding: EdgeInsets.all(6),
                                    ),
                                  },
                                ),
                              ],
                            ),
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
