import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/virus_total_response.dart';
import '../utils/const.dart';
import '../widgets/build_stat.dart';

class AnalyzeUrl extends StatefulWidget {
  const AnalyzeUrl({super.key});

  @override
  State<AnalyzeUrl> createState() => _AnalyzeUrlState();
}

class _AnalyzeUrlState extends State<AnalyzeUrl> {
  TextEditingController url = TextEditingController();
  UrlThreatAnalysisResponse? response;

  Future<UrlThreatAnalysisResponse?> sendUrlForThreatAnalysis(String urlToCheck) async {
    final apiUrl = Uri.parse("${URL}/scan/url");

    try {
      final res = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'url': urlToCheck}),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        print("Threat Analysis Response: $data");
        return UrlThreatAnalysisResponse.fromJson(data);
      } else {
        print("❌ Server error: ${res.statusCode}");
      }
    } catch (e) {
      print("⚠️ Failed to analyze URL: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined, color: Colors.white),
        ),
        title: const Text(
          'Antivirus Home',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1a237e), Colors.black],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                controller: url,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white24,
                  hintText: 'Search URL...',
                  hintStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final result = await sendUrlForThreatAnalysis(url.text);
                  setState(() {
                    response = result;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white24,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.white30),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Scan Now',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 24.0),
              if (response != null) ...[
                Text(
                  "Scan Stats:",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                buildStat("Harmless", response!.data.attributes.stats.harmless),
                buildStat("Malicious", response!.data.attributes.stats.malicious),
                buildStat("Suspicious", response!.data.attributes.stats.suspicious),
                buildStat("Timeout", response!.data.attributes.stats.timeout),
                buildStat("Undetected", response!.data.attributes.stats.undetected),
              ],
            ],
          ),
        ),
      ),
    );
  }

}
