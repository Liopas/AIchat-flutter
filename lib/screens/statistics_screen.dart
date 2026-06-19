import 'package:flutter/material.dart';

import '../services/database_service.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() =>
      _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final stats = await DatabaseService().getStatistics();

    setState(() {
      data = stats;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final totalMessages = data!['total_messages'] ?? 0;
    final totalTokens = data!['total_tokens'] ?? 0;

    final avg =
        totalMessages == 0 ? 0 : totalTokens / totalMessages;

    final models =
        data!['model_usage'] as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Статистика"),
        backgroundColor: const Color(0xFF161A1E),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text('Сообщений'),
              trailing: Text('$totalMessages'),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Токенов'),
              trailing: Text('$totalTokens'),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Среднее токенов'),
              trailing: Text(avg.toStringAsFixed(1)),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Использование моделей',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          ...models.entries.map(
            (e) => Card(
              child: ListTile(
                title: Text(e.key),
                subtitle: Text(
                  'Сообщений: ${e.value["count"]}',
                ),
                trailing: Text(
                  '${e.value["tokens"]} ток.',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}