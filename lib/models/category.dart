import 'package:flutter/material.dart';

class Category {
  // blueprint for an object
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange, // default color
  });

  final String id;
  final String title;
  final Color color;
}
