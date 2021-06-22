import 'dart:convert';
import 'dart:developer';

import 'package:enciclopiedia_deportiva/common/constants/colors.dart';
import 'package:enciclopiedia_deportiva/common/constants/general.dart';
import 'package:enciclopiedia_deportiva/models/category_sub_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SingleArticles extends StatefulWidget {
  final CategorySubEntity categorySubEntity;

  const SingleArticles({Key? key, required this.categorySubEntity}) : super(key: key);

  @override
  _SingleArticlesState createState() => _SingleArticlesState();
}

class _SingleArticlesState extends State<SingleArticles> {
  WebViewController? _controller;
  double webViewHeight = 10.0;
  double webViewWidth = 10.0;

  void updateHeight() async {
    double height = double.parse(await _controller!.evaluateJavascript("document.documentElement.scrollHeight;"));

    if (webViewHeight != height) {
      setState(() {
        webViewHeight = height;
      });
    }
  }

  /*Widget _html(String data) {
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
          width: double.maxFinite,
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
          textAlign: TextAlign.justify,
          fontSize: FontSize(14.0),
          alignment: Alignment.center,
          verticalAlign: VerticalAlign.BASELINE,
        ),
      },
      customRender: {
        "table": (context, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: (context.tree as TableLayoutElement).toWidget(context),
          );
        },
      },
    );
  }*/
  Widget _widgetFromHtml(String data) {
    String finalData =
        "<!DOCTYPE html><html><head><style> body {font-size:12px}<\/style><\/head><body>" + data + "<\/body><\/html>";
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
      javascriptChannels: [
        JavascriptChannel(
            name: "Resize",
            onMessageReceived: (JavascriptMessage message) {
              updateHeight();
            }),
      ].toSet(),
      onPageFinished: (url) async {
        double newHeight = double.parse(await _controller!.evaluateJavascript("document.documentElement.scrollHeight;"));
        double newWidth = double.parse(await _controller!.evaluateJavascript("document.documentElement.scrollWidth;"));
        setState(() {
          log("WebView Height: $newHeight && Width: $newWidth");
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
                  .replaceAll("<td><strong><span style=\"font-size: 14pt;\">", "<th><strong>")
                  .replaceAll("<\/span><\/strong><\/td>", "<\/strong><\/th>"),
              mimeType: "text/html",
              encoding: Encoding.getByName('utf-8'))
          .toString(),
    );

    /* return HtmlWidget(
      data
          .replaceAll("<td><span style=\"font-size: 12pt;\">", "<th>")
          .replaceAll("<\/span><\/td>", "<\/th>")
          .replaceAll("<td><span style=\"font-size: 14pt;\">", "<th>")
          .replaceAll("<td><strong><span style=\"font-size: 14pt;\">", "<th><strong>")
          .replaceAll("<\/span><\/strong><\/td>", "<\/strong><\/th>")
          .replaceAll("&nbsp;", "")
          .replaceAll("<td><\/td>", "")
          .replaceAll("<tr><\/tr>", ""),
      textStyle: TextStyle(
        fontSize: 12.0,
        textBaseline: TextBaseline.alphabetic,
      ),
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
        }
      },
    );*/
  }

  @override
  Widget build(BuildContext context) {
    if (isIos) {
      return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
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
        child: Container(
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
                      top: 20.0,
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.categorySubEntity.title!,
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
                          height:
                              MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight) - 75.0,
                          width: MediaQuery.of(context).size.width,
                          child: _widgetFromHtml(widget.categorySubEntity.introtext!),
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
          title: Image.asset(
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
                      children: [
                        Text(
                          widget.categorySubEntity.title!,
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
                          height:
                              MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight) - 90.0,
                          width: MediaQuery.of(context).size.width,
                          child: _widgetFromHtml(widget.categorySubEntity.introtext!),
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
/*Html(
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
  ),*/
}
