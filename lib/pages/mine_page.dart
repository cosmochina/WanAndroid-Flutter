import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/models/app_theme.dart';
import 'package:wanandroid_flutter/pages/favorite_page.dart';
import 'package:wanandroid_flutter/pages/meizi_page.dart';
import 'package:wanandroid_flutter/pages/my_points_page.dart';
import 'package:wanandroid_flutter/pages/settings_page.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/bezier_clipper.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';
import 'package:wanandroid_flutter/widgets/section_item.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends State<MinePage> {
  double screenWidth = 0;
  List<Color> themeColors = new List();
  int selectedIndex = 0;
  Color resultColor = Colours.appThemeColor;

  @override
  void initState() {
    super.initState();
    themeColors
      ..add(Color(0xffc54945)) //
      ..add(Color(0xfffc5e38)) //
      ..add(Color(0xfffd742d)) //
      ..add(Color(0xfff6b816)) //
      ..add(Color(0xffcae053)) //
      ..add(Color(0xff81c842)) //
      ..add(Color(0xff5cc095)) //
      ..add(Color(0xff569ce4)) //
      ..add(Color(0xff5978e9)) //
      ..add(Color(0xff7668f6)) //
      ..add(Color(0xffa674e6)) //
      ..add(Color(0xffd477e6)) //
      ..add(Color(0xffec7ec5)) //
      ..add(Color(0xffed698b)) //
      ..add(Color(0xfff19fb4)) //
      ..add(Color(0xff323638));
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    var themeColor = Provider.of<AppTheme>(context).themeColor;
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("我的"),
        centerTitle: true,
        colors: [themeColor, themeColor],
      ),
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.only(
                right: 0.1,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: Theme.of(context).accentColor,
                            child: Stack(
                              children: <Widget>[
                                // 贝塞尔背景
                                ClipPath(
                                  clipper: BezierClipper(),
                                  child: Container(
                                    height: 180,
                                    width: screenWidth,
                                    decoration: new BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          themeColor,
                                          themeColor,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // 头像，名字
                                Positioned(
                                  left: 32,
                                  top: 40,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      ClipOval(
                                        child: FadeInImage.assetNetwork(
                                          placeholder: "images/avatar_def.png",
                                          image:
                                              "https://user-gold-cdn.xitu.io/2019/1/9/168329d14a4d9f35",
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 16,
                                        ),
                                        child: Text(
                                          "星火燎原",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 3,
                                  bottom: 15,
                                  child: GestureDetector(
                                    onTap: () {
                                      gotoMyPoints(context);
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "我的积分",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Icon(
                                          Icons.chevron_right,
                                          color: Colors.black45,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              SectionItem(
                                Icons.favorite,
                                "收藏",
                                callback: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return FavoritePage();
                                      },
                                    ),
                                  );
                                },
                                margin: EdgeInsets.only(top: 20),
                              ),
                              SectionItem(
                                Icons.color_lens,
                                "主题颜色",
                                callback: () {
                                  showThemeChooserDialog(context);
                                },
                                margin: EdgeInsets.only(top: 20),
                                hasDivider: true,
                                showMore: true,
                                right: Container(
                                  height: 15,
                                  width: 15,
                                  margin: EdgeInsets.only(
                                    right: 10,
                                  ),
                                  color: resultColor,
                                ),
                              ),
                              SectionItem(
                                Icons.local_florist,
                                "干货妹子",
                                callback: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return MeiziPage();
                                      },
                                    ),
                                  );
                                },
                                hasDivider: true,
                              ),
                              SectionItem(
                                Icons.settings,
                                "设置",
                                callback: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return SettingsPage();
                                      },
                                    ),
                                  );
                                },
                                hasDivider: false,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showThemeChooserDialog(BuildContext context) {
    var result = showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(
              "主题颜色选择",
            ),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 250,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: themeColors.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: themeColors[index],
                            shape: BoxShape.circle,
                          ),
                          width: 30,
                          height: 30,
                          child: Visibility(
                            visible: selectedIndex == index,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            actions: <Widget>[
              Container(
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(resultColor);
                  },
                  child: Text(
                    "取消",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.body1.color,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  right: 20,
                ),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(themeColors[selectedIndex]);
                  },
                  child: Text(
                    "确定",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.body1.color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    result.then((color) {
      print("color = $color");
      Provider.of<AppTheme>(context).updateThemeColor(color);
      setState(() {
        resultColor = color;
      });
    });
  }

  void gotoMyPoints(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((BuildContext context) {
          return MyPointsPage();
        }),
      ),
    );
  }
}
