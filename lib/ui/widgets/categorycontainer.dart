import 'package:flutter/material.dart';
import 'package:smartshop/global.dart';
import 'package:smartshop/global.dart';

class CategoryContainer extends StatefulWidget {
  const CategoryContainer({
    Key key,
  }) : super(key: key);

  @override
  _CategoryContainerState createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  int _active = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: cats.length,
      itemBuilder: (ctx, i) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _active = i;
            });
          },
          child: Container(
            constraints: BoxConstraints(minWidth: 121),
            margin: EdgeInsets.only(right: i == cats.length - 1 ? 0 : 15.0),
            decoration: BoxDecoration(
              color: _active == i ? kPrimaryColor : kPrimaryLightColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  cats[i].icon,
                  color: _active == i ? Colors.white : Colors.black,
                ),
                Text(
                  "${cats[i].title}",
                  style: TextStyle(
                    color: _active == i ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
