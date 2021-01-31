import 'package:flutter/widgets.dart';
import 'package:provider_tracker/models/weight.dart';

class WeightState with ChangeNotifier {
  List<Weight> _weights = [
    Weight(value: 65, time: DateTime.utc(2019, 7, 5)),
    Weight(value: 66, time: DateTime.utc(2019, 8, 5)),
    Weight(value: 67, time: DateTime.utc(2019, 9, 5)),
  ];

  List<Weight> get weights => _weights;

  add(Weight weight) {
    _weights.insert(0, weight);
    notifyListeners();
  }
}
