import 'package:flutter/material.dart';
import 'package:screen_project/models/coffee.dart';
import 'package:screen_project/screens/detail/detail.dart';

class SearchInput extends StatefulWidget {
  final List<Coffees> coffeesList;
  final Function(Coffees) onItemClicked;

  SearchInput({required this.coffeesList, required this.onItemClicked});

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  List<Coffees> filteredCoffees = [];
  bool isSearching = false;
  bool isFiltering = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25, right: 25, left: 25, bottom: 0),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      isSearching = value.isNotEmpty;
                      filteredCoffees = widget.coffeesList
                          .where((coffee) =>
                          coffee.title.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Search Aesthetic Coffee',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                    prefixIcon: Container(
                      padding: EdgeInsets.all(10),
                      child: Image.asset('assets/icons/search.png', width: 20),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isFiltering = !isFiltering;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: isFiltering ? Colors.red : Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                    'assets/icons/filter.png',
                    width: 25,
                  ),
                ),
              ),
            ],
          ),
          if (isSearching || isFiltering)
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: (isSearching ? filteredCoffees : widget.coffeesList)
                    .map(
                      (coffee) => InkWell(
                    onTap: () {
                      widget.onItemClicked(coffee);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Text(
                        coffee.title,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }
}
