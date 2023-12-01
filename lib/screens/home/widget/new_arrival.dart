import 'package:flutter/material.dart';
import 'package:screen_project/screens/home/widget/categories_list.dart';
import 'package:screen_project/models/coffee.dart';
import 'package:screen_project/screens/home/widget/coffees_item.dart';

class NewArrival extends StatelessWidget{
  final coffeesList = Coffees.generateCoffees();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CategoriesList(title: 'Categories'),
          Container(
            height: 280,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 25),
              scrollDirection: Axis.horizontal,
                itemBuilder: (context,index) => CoffeesItem(coffeesList[index]),
                separatorBuilder: (_,index) => SizedBox(width: 10,),
                itemCount: coffeesList.length
            ),
          ),
        ],
      ),
    );
  }

}