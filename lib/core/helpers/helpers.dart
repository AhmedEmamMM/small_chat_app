import 'package:flutter/material.dart';

   SizedBox verticalSpace(double hight) => SizedBox(height: hight);
   SizedBox horizontalSpace(double width) => SizedBox(width: width);

//format aouble calue into money
String makeDoubleToMoneyToString(double price) =>
    "\$ ${price.toStringAsFixed(2)}";

// format list of addons into a string summary
  // String formatAddons(List<Addon> addons) {
  //   return addons
  //       .map((addon) => "${addon.name} (${formatPrice(addon.price)})")
  //       .join(", ");
  // }


// //sort out and return a list of food items that belong to a specific category
//   List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
//     return fullMenu.where((food) => food.category == category).toList();
//   }

// return list of foods in givin category
// List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
//     return FoodCategory.values.map((category) {
//       // get category menu
//       List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);

//       return ListView.builder(
//           itemCount: categoryMenu.length,
//           physics: const NeverScrollableScrollPhysics(),
//           padding: EdgeInsets.zero,
//           itemBuilder: (context, index) {
//             // get individal food
//             final food = categoryMenu[index];

//             //return food tile UI
//             return FoodTile(
//                 food: food,
//                 onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => FoodPage(food: food)))).animate().fadeIn(duration: 1500.ms, delay: 600.ms).shake().scaleXY();
//           });
//     }).toList();
//   }