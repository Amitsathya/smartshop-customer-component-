import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/models/item.dart';
import 'package:smartshop/ui/widgets/productcontainer.dart';

class WhishList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int index = 1;
    List<WhishListItem> itemList = Provider.of<List<WhishListItem>>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blueAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.title),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text("Whishlist"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text("User Settings"),
          ),
        ],
        onTap: (value) => {
          if (value == 0)
            {Navigator.pushNamed(context, 'home')}
          else if (value == 2)
            {Navigator.pushNamed(context, 'account')},
        },
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Color(0xfff9f9f9),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My WhishList",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_basket),
            onPressed: () {
              Navigator.pushNamed(context, 'orderscreen');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: .7),
              itemCount: itemList.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductContainer(
                  id: index,
                  barcode: "yes",
                );
              },
            ),
            itemList.length == 0
                ? Center(child: Text('No WishList Items added'))
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
