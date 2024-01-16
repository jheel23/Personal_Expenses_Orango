import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToDoNotifier extends StateNotifier<List<String>> {
  ToDoNotifier() : super([]);

  void add(String item) {
    state = [...state, item];
  }

  void remove(String item) {
    state = state.where((element) => element != item).toList();
  }
}
