import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;





class RecommendationModel {
  String item;
  String image;
  String description;

  // Constructor
  RecommendationModel(
      {required this.item, required this.image, required this.description});

  static List<String>dish =[
    "Spaghetti Bolognese",
    "Margherita Pizza",
    "Fettuccine Alfredo",
    "Caprese Salad",
    "Lasagna",
    "Bruschetta",
    "Minestrone Soup",
    "Tiramisu",
    "Panzanella Salad",
    "Gnocchi with Pesto",
    "Burritos",
    "Nachos with Salsa and Guacamole",
    "Fajitas",
    "Carnitas Tacos",
    "Chile Rellenos",
    "Pozole",
    "Tamales",
    "Chiles en Nogada",
    "Cochinita Pibil",
    "Ceviche",
    "Ramen",
    "Bibimbap",
    "Thai Green Curry",
    "Dim Sum (Assorted)",
    "Vietnamese Pho",
    "Beef Bulgogi",
    "Sushi (Assorted)",
    "Chicken Satay",
    "Pad See Ew",
    "Miso Soup",
    "Baba Ganoush",
    "Kebabs (Assorted)",
    "Falafel Plate",
    "Fatoush Salad",
    "Shawarma Wrap",
    "Stuffed Grape Leaves (Dolma)",
    "Lamb Kofta",
    "Muhammara",
    "Basbousa",
    "Halva",
    "Spinach and Ricotta Stuffed Shells",
    "Eggplant Parmesan",
    "Vegetable Paella",
    "Lentil Salad",
    "Ratatouille",
    "Mushroom Risotto",
    "Sweet Potato and Black Bean Enchiladas",
    "Caprese Panini",
    "Butternut Squash Soup",
    "Vegetarian Moussaka",
    "Vegan Pad See Ew",
    "Jackfruit Tacos",
    "Vegan Sushi Rolls (Assorted)",
    "Lentil Curry",
    "Vegan Mac and Cheese",
    "Chickpea Salad",
    "Veggie Stir-fry",
    "Vegan Chili",
    "Vegan Bibimbap",
    "Coconut Curry Tofu",
    "Grilled Lemon Herb Chicken",
    "Shrimp Scampi",
    "Quinoa Stuffed Bell Peppers",
    "Gluten-free Pizza Margherita",
    "Lemon Garlic Salmon",
    "Stir-fried Beef with Broccoli",
    "Stuffed Zucchini Boats",
    "Greek Yogurt Chicken Salad",
    "Vegetable Curry with Rice",
    "Honey Mustard Glazed Pork Chops",
    "Grilled Salmon with Asparagus",
    "Quinoa and Black Bean Salad",
    "Turkey and Avocado Wrap",
    "Greek Yogurt Parfait",
    "Grilled Vegetable Quinoa Bowl",
    "Kale Salad with Roasted Chickpeas",
    "Baked Chicken Breast with Steamed Vegetables",
    "Cauliflower Rice Stir-fry",
    "Lentil and Vegetable Soup",
    "Zucchini Noodles with Pesto and Cherry Tomatoes"
  ];
}


Future<List<RecommendationModel>>modeldata() async {
  List<RecommendationModel> data =[];
  final String csvString = await rootBundle.loadString('assets/rec.csv');
  final List<List<dynamic>> fields = const CsvToListConverter().convert(csvString);

  for(var row in fields){
    final item =row[0].toString();
    final image =row[1].toString();
    final description =row[2].toString();

    final values=RecommendationModel(item: item, image: image, description: description);

    data.add(values);

  }

  return data;
}


