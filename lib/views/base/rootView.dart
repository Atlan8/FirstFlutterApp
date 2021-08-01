import 'package:first_flutter_app/engine/customColors.dart';
import 'package:first_flutter_app/engine/customIcons.dart';
import 'package:first_flutter_app/views/base/tabbar.dart';
import 'package:first_flutter_app/views/home/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RootView extends StatefulWidget {
  RootView({
    Key? key,
    required this.title
  }): super(key: key);
  final String title;

  _RootView createState() => _RootView();
}

class _RootView extends State<RootView> {
  int _currentIndex = 0;
  Color _inactiveColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: CustomColors.primaryColor,
      ),
      body: getBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      HomePage(),
      Container(
        alignment: Alignment.center,
        child: Text('新鲜事', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
      ),
      Container(
        alignment: Alignment.center,
        child: Text('消息', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
      ),
      Container(
        alignment: Alignment.center,
        child: Text('我的', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
      ),
    ];

    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }

  Widget _buildBottomBar() {
    return CustomAnimateBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCurrentRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: [
        BottomNavyBarItem(
          icon: Icon(CustomIcons.home),
          title: Text('首页'),
          activeColor: Colors.green,
          inActiveColor: _inactiveColor,
          textAlign: TextAlign.center
        ),
        BottomNavyBarItem(
            icon: Icon(CustomIcons.activity),
            title: Text('新鲜事'),
            activeColor: Colors.pink,
            inActiveColor: _inactiveColor,
            textAlign: TextAlign.center
        ),
        BottomNavyBarItem(
            icon: Icon(CustomIcons.message),
            title: Text('消息'),
            activeColor: Colors.purpleAccent,
            inActiveColor: _inactiveColor,
            textAlign: TextAlign.center
        ),
        BottomNavyBarItem(
            icon: Icon(CustomIcons.mine),
            title: Text('我的'),
            activeColor: Colors.blue,
            inActiveColor: _inactiveColor,
            textAlign: TextAlign.center
        )
      ],
    );
  }
}