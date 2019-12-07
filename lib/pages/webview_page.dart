import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/models/app_theme.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage({this.url, this.title});

  @override
  State<StatefulWidget> createState() {
    return WebViewPageState();
  }
}

class WebViewPageState extends State<WebViewPage> {
  List<Map<String, Object>> list = new List();
  var appTheme;

  @override
  void initState() {
    super.initState();
    list
      ..add({"title": "收藏", "icon": Icons.favorite_border})
      ..add({"title": "复制链接", "icon": Icons.link})
      ..add({"title": "浏览器打开", "icon": Icons.open_in_browser})
      ..add({"title": "微信分享", "icon": Icons.share})
      ..add({"title": "刷新", "icon": Icons.refresh});
  }

  @override
  Widget build(BuildContext context) {
    var appTheme = Provider.of<AppTheme>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GradientAppBar(
        title: Text("详情"),
        colors: [
          appTheme.themeColor,
          appTheme.themeColor,
        ],
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              // 显示底部弹框
              showBottomSheet(context, appTheme.themeColor);
            },
            child: Container(
              padding: EdgeInsets.only(
                right: 10,
              ),
              child: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          controller.canGoBack().then((res) {
            print(res);
          });
          controller.currentUrl().then((url) {
            print(url);
          });
        },
        onPageFinished: (String url) {
          print("onPageFinished");
        },
      ),
    );
  }

  showBottomSheet(BuildContext context, Color color) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 290,
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (BuildContext context, int index) {
              return createBottomSheetItem(
                  color, list[index]['title'], list[index]['icon'], (index) {
                handleBottomSheetItemClick(context, index);
              });
            },
            itemCount: list.length,
          ),
        );
      },
    );
  }

  createBottomSheetItem(
      Color color, String title, IconData icon, Function onClick) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: color,
              size: 32,
            ),
          ),
          Text(
            title,
            maxLines: 1,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void handleBottomSheetItemClick(context, index) {
    switch (index) {
      case 0:
        addArticleFavorite();
        break;
      case 1:
        copyLink();
        break;
      case 2:
        openByBrowser();
        break;
      case 3:
        shareWeChat();
        break;
      case 4:
        refresh();
        break;
    }
  }

  void addArticleFavorite() {}

  void copyLink() {}

  void openByBrowser() {}

  void shareWeChat() {}

  void refresh() {}
}
