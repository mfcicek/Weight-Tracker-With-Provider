import 'package:flutter/widgets.dart';
import 'package:provider_tracker/models/weight.dart';

class WeightState with ChangeNotifier {
  List<Weight> _weights = [
    Weight(value: 79, time: DateTime.utc(2021, 01, 30)),
    Weight(value: 85, time: DateTime.utc(2021, 01, 23)),
    Weight(value: 87, time: DateTime.utc(2021, 01, 14)),
    Weight(value: 93, time: DateTime.utc(2021, 01, 7)),
    Weight(value: 95, time: DateTime.utc(2021, 01, 01)),
  ];

  List<Weight> get weights => _weights;

  add(Weight weight) {
    _weights.insert(0, weight);
    notifyListeners();
  }
}
