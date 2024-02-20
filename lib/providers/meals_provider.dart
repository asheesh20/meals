import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

// Provider is for static value(data) i.e a list that never changes

final mealsProvider = Provider((ref) {
  // function will receive an object automatically . function will be called by flutter riverpod package
  return dummyMeals;
});
