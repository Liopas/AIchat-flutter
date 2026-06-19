import 'package:flutter/material.dart';

import '../services/provider_settings_service.dart';

class ProviderSettingsScreen extends StatefulWidget {
  const ProviderSettingsScreen({super.key});

  @override
  State<ProviderSettingsScreen> createState() =>
      _ProviderSettingsScreenState();
}

class _ProviderSettingsScreenState
    extends State<ProviderSettingsScreen> {
  final apiController = TextEditingController();
  final urlController = TextEditingController();

  String provider = "OpenRouter";

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final data = await ProviderSettingsService().load();

    setState(() {
      provider = data['provider']!;
      apiController.text = data['apiKey']!;
      urlController.text = data['baseUrl']!;
    });
  }

  Future<void> save() async {
    await ProviderSettingsService().save(
      provider: provider,
      apiKey: apiController.text,
      baseUrl: urlController.text,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Настройки сохранены'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF161A1E),
        title: const Text("Провайдер"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: provider,
              items: const [
                DropdownMenuItem(
                  value: 'OpenRouter',
                  child: Text('OpenRouter'),
                ),
                DropdownMenuItem(
                  value: 'VSEGPT',
                  child: Text('VSEGPT'),
                ),
              ],
              onChanged: (v) {
                setState(() {
                  provider = v!;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: apiController,
              decoration: const InputDecoration(
                labelText: 'API Key',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: 'Base URL',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: save,
              child: const Text('Сохранить'),
            )
          ],
        ),
      ),
    );
  }
}