import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:provider_tracker/models/weight.dart';
import 'package:provider_tracker/state/weight_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeightPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1a202b),
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Weight Tracker'),
      ),
      body: Consumer<WeightState>(
        builder: (context, state, widget) {
          var weights = state.weights;
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15),
                  height: 150,
                  child: Card(
                    color: Colors.blueGrey[900],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'Current Weight',
                                textScaleFactor: 1.4,
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                weights.first.value.toString(),
                                textScaleFactor: 2,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'Beginning Weight',
                                textScaleFactor: 1.2,
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(weights.last.value.toString(),
                                  textScaleFactor: 1.8,
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  child: ListView.builder(
                    itemCount: weights.length,
                    itemBuilder: (BuildContext context, int index) {
                      var weight = weights[index];
                      return ListTile(
                        title: Text(
                            "${weight.time.day}.${weight.time.month}.${weight.time.year}",
                            style: TextStyle(color: Colors.white)),
                        trailing: Text(weight.value.toString(),
                            textScaleFactor: 2,
                            style: TextStyle(color: Colors.white)),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(height: 10),
                      SfCartesianChart(
                        title: ChartTitle(text: ''),
                        legend: Legend(
                          isVisible: true,
                          overflowMode: LegendItemOverflowMode.wrap,
                        ),
                        primaryXAxis: DateTimeAxis(
                          labelStyle: TextStyle(color: Colors.white),
                          majorGridLines: MajorGridLines(width: 0),
                        ),
                        primaryYAxis: NumericAxis(
                          labelStyle: TextStyle(color: Colors.white),
                          labelFormat: '{value}',
                        ),
                        series: <LineSeries<Weight, dynamic>>[
                          LineSeries<Weight, DateTime>(
                            color: Colors.purple,
                            animationDuration: 2500,
                            enableTooltip: true,
                            dataSource: weights,
                            xValueMapper: (Weight x, _) => x.time,
                            yValueMapper: (Weight y, _) => y.value,
                            width: 2,
                            name: 'Graph',
                            markerSettings: MarkerSettings(isVisible: true),
                          ),
                        ],
                        tooltipBehavior: TooltipBehavior(enable: true),
                      ),
                      SizedBox(height: 70),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var state = Provider.of<WeightState>(context, listen: false);
          var result = await showDialog<double>(
              context: context,
              builder: (context) => NumberPickerDialog.decimal(
                    initialDoubleValue: state.weights.first.value,
                    maxValue: 200,
                    minValue: 10,
                  ));
          if (result != null && result > 0) {
            state.add(Weight(value: result, time: DateTime.now()));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
