import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAnimateBottomBar extends StatelessWidget {

  CustomAnimateBottomBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true, // 是否显示菜单阴影，默认为true
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCurrentRadius = 50,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear, // 动画曲线
  }): super(key: key);

  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCurrentRadius;
  final double containerHeight;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final bgColor = backgroundColor ?? Theme.of(context).bottomAppBarColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            )
        ]
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  item: item,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: bgColor,
                  itemCurrentRadius: itemCurrentRadius,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCurrentRadius;
  final Duration animationDuration;
  final Curve curve;

  _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.backgroundColor,
    required this.animationDuration,
    required this.itemCurrentRadius,
    required this.iconSize,
    this.curve = Curves.linear,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected ? 130 : 50,
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          color: isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
          borderRadius: BorderRadius.circular(itemCurrentRadius)
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            width: isSelected ? 130 : 50,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconTheme(
                    data: IconThemeData(
                      size: iconSize,
                      color: isSelected
                          ? item.activeColor.withOpacity(1)
                          : item.inActiveColor == null
                        ? item.activeColor
                          : item.inActiveColor
                    ),
                    child: item.icon
                ),
                if (isSelected)
                  Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: DefaultTextStyle.merge(
                          style: TextStyle(
                            color: item.activeColor,
                            fontWeight: FontWeight.bold
                          ),
                            maxLines: 1,
                            textAlign: item.textAlign,
                            child: item.title
                        ),
                      )
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    required this.icon,
    required this.title,
    this.activeColor = Colors.blue,
    this.textAlign,
    this.inActiveColor
  });

  final Widget icon;
  final Widget title;
  final Color activeColor;
  final Color? inActiveColor;
  final TextAlign? textAlign;
}