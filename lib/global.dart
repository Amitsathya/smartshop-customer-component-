import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

String lorem =
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptas at, aspernatur blanditiis veritatis nam ea corrupti architecto, ipsum dolor sunt facere quasi, laborum fugiat earum laudantium adipisci corporis esse magnam.";

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

class Product {
  final String title, description, price, img;
  Product({this.title, this.description, this.price, this.img});
}

List<Product> productsList = [
  Product(
    description: lorem,
    title: "Maggi Noodles",
    price: "46",
    img:
        "https://www.maggi.in/sites/default/files/styles/product_image_desktop_617_900/public/maggi-without-onion-and-gralic.png?itok=sYoiuu06",
  ),
  Product(
    description: lorem,
    title: "Bourbon Biscuit",
    price: "27",
    img:
        "https://ik.imagekit.io/dunzo/c2l5YWdINEhhdDBjeVpYeUE5SjVXUT09-product_image.jpg?tr=w-436,h-436,cm-pad_resize",
  ),
  Product(
    description: lorem,
    title: "Hide & Seek",
    price: "30",
    img:
        "https://www.rdmall.in/image/cache/products/Groceries/Biscuits/parle-hide-seek-chocolate-chip-cookies-200-gm-910x1155.png",
  ),
  Product(
    description: lorem,
    title: "Lays Indian Magic Masala",
    price: "10",
    img:
        "https://homebaskets.in/wp-content/uploads/2020/07/lay-s-india-s-magic-masala-removebg-preview.png",
  ),
  Product(
    description: lorem,
    title: "Maggi Noodles",
    price: "46",
    img:
        "https://www.maggi.in/sites/default/files/styles/product_image_desktop_617_900/public/maggi-without-onion-and-gralic.png?itok=sYoiuu06",
  ),
  Product(
    description: lorem,
    title: "Bourbon Biscuit",
    price: "27",
    img:
        "https://ik.imagekit.io/dunzo/c2l5YWdINEhhdDBjeVpYeUE5SjVXUT09-product_image.jpg?tr=w-436,h-436,cm-pad_resize",
  ),
  Product(
    description: lorem,
    title: "Hide & Seek",
    price: "30",
    img:
        "https://www.rdmall.in/image/cache/products/Groceries/Biscuits/parle-hide-seek-chocolate-chip-cookies-200-gm-910x1155.png",
  ),
  Product(
    description: lorem,
    title: "Lays Indian Magic Masala",
    price: "10",
    img:
        "https://homebaskets.in/wp-content/uploads/2020/07/lay-s-india-s-magic-masala-removebg-preview.png",
  ),
  Product(
    description: lorem,
    title: "Maggi Noodles",
    price: "46",
    img:
        "https://www.maggi.in/sites/default/files/styles/product_image_desktop_617_900/public/maggi-without-onion-and-gralic.png?itok=sYoiuu06",
  ),
  Product(
    description: lorem,
    title: "Bourbon Biscuit",
    price: "27",
    img:
        "https://ik.imagekit.io/dunzo/c2l5YWdINEhhdDBjeVpYeUE5SjVXUT09-product_image.jpg?tr=w-436,h-436,cm-pad_resize",
  ),
  Product(
    description: lorem,
    title: "Hide & Seek",
    price: "30",
    img:
        "https://www.rdmall.in/image/cache/products/Groceries/Biscuits/parle-hide-seek-chocolate-chip-cookies-200-gm-910x1155.png",
  ),
  Product(
    description: lorem,
    title: "Lays Indian Magic Masala",
    price: "10",
    img:
        "https://homebaskets.in/wp-content/uploads/2020/07/lay-s-india-s-magic-masala-removebg-preview.png",
  ),
  Product(
    description: lorem,
    title: "Maggi Noodles",
    price: "46",
    img:
        "https://www.maggi.in/sites/default/files/styles/product_image_desktop_617_900/public/maggi-without-onion-and-gralic.png?itok=sYoiuu06",
  ),
  Product(
    description: lorem,
    title: "Bourbon Biscuit",
    price: "27",
    img:
        "https://ik.imagekit.io/dunzo/c2l5YWdINEhhdDBjeVpYeUE5SjVXUT09-product_image.jpg?tr=w-436,h-436,cm-pad_resize",
  ),
  Product(
    description: lorem,
    title: "Hide & Seek",
    price: "30",
    img:
        "https://www.rdmall.in/image/cache/products/Groceries/Biscuits/parle-hide-seek-chocolate-chip-cookies-200-gm-910x1155.png",
  ),
  Product(
    description: lorem,
    title: "Lays Indian Magic Masala",
    price: "10",
    img:
        "https://homebaskets.in/wp-content/uploads/2020/07/lay-s-india-s-magic-masala-removebg-preview.png",
  ),
  Product(
    description: lorem,
    title: "Maggi Noodles",
    price: "46",
    img:
        "https://www.maggi.in/sites/default/files/styles/product_image_desktop_617_900/public/maggi-without-onion-and-gralic.png?itok=sYoiuu06",
  ),
  Product(
    description: lorem,
    title: "Bourbon Biscuit",
    price: "27",
    img:
        "https://ik.imagekit.io/dunzo/c2l5YWdINEhhdDBjeVpYeUE5SjVXUT09-product_image.jpg?tr=w-436,h-436,cm-pad_resize",
  ),
  Product(
    description: lorem,
    title: "Hide & Seek",
    price: "30",
    img:
        "https://www.rdmall.in/image/cache/products/Groceries/Biscuits/parle-hide-seek-chocolate-chip-cookies-200-gm-910x1155.png",
  ),
  Product(
    description: lorem,
    title: "Lays Indian Magic Masala",
    price: "10",
    img:
        "https://homebaskets.in/wp-content/uploads/2020/07/lay-s-india-s-magic-masala-removebg-preview.png",
  ),
  Product(
    description: lorem,
    title: "Maggi Noodles",
    price: "46",
    img:
        "https://www.maggi.in/sites/default/files/styles/product_image_desktop_617_900/public/maggi-without-onion-and-gralic.png?itok=sYoiuu06",
  ),
  Product(
    description: lorem,
    title: "Bourbon Biscuit",
    price: "27",
    img:
        "https://ik.imagekit.io/dunzo/c2l5YWdINEhhdDBjeVpYeUE5SjVXUT09-product_image.jpg?tr=w-436,h-436,cm-pad_resize",
  ),
  Product(
    description: lorem,
    title: "Hide & Seek",
    price: "30",
    img:
        "https://www.rdmall.in/image/cache/products/Groceries/Biscuits/parle-hide-seek-chocolate-chip-cookies-200-gm-910x1155.png",
  ),
  Product(
    description: lorem,
    title: "Lays Indian Magic Masala",
    price: "10",
    img:
        "https://homebaskets.in/wp-content/uploads/2020/07/lay-s-india-s-magic-masala-removebg-preview.png",
  ),
];

class Category {
  final String title;
  final IconData icon;

  Category({this.title, this.icon});
}

List<Category> cats = [
  Category(
    icon: FontAwesome5Solid.cookie_bite,
    title: "Snacks",
  ),
  Category(
    icon: MaterialCommunityIcons.leaf,
    title: "Vegetables",
  ),
  Category(
    icon: MaterialCommunityIcons.bottle_wine,
    title: "Drinks",
  ),
  Category(
    icon: FontAwesome5Solid.drumstick_bite,
    title: "Meat",
  ),
  Category(
    icon: FontAwesome5Solid.apple_alt,
    title: "Fruits",
  ),
];
