import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../services/database_service.dart';

class ExpensesChartScreen extends StatefulWidget {
  const ExpensesChartScreen({super.key});

  @override
  State<ExpensesChartScreen> createState() =>
      _ExpensesChartScreenState();
}

class _ExpensesChartScreenState
    extends State<ExpensesChartScreen> {
  List<Map<String, dynamic>> rows = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    rows = await DatabaseService().getDailyCosts();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final spots = <FlSpot>[];

    for (int i = 0; i < rows.length; i++) {
      final value =
          (rows[i]['total_cost'] as num?)?.toDouble() ?? 0;

      spots.add(
        FlSpot(i.toDouble(), value),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Расходы"),
        backgroundColor: const Color(0xFF161A1E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: LineChart(
                 LineChartData(
                   titlesData: FlTitlesData(
                     bottomTitles: AxisTitles(
                       sideTitles: SideTitles(
                         showTitles: true,
                         interval: 1,
                         getTitlesWidget: (value, meta) {
                           final index = value.toInt();

                           if (index < 0 || index >= rows.length) {
                             return const SizedBox();
                           }

                           return Text(
                             rows[index]['day']?.toString() ?? '',
                           );
                         },
                       ),
                     ),
                   ),
                   lineBarsData: [
                     LineChartBarData(
                       spots: spots,
                       isCurved: true,
                     ),
                   ],
                 )
               )
      ),
    );
  }
}