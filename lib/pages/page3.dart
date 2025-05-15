import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // 引入 url_launcher

class Page3 extends StatelessWidget {
  const Page3({super.key});

  // 開啟天氣預報網址
  void _launchWeatherURL() async {
    final Uri url = Uri.parse('https://www.cwa.gov.tw/V8/C/'); // 中央氣象局網址
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw '無法開啟 $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('天氣預報')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: _launchWeatherURL,
            child: const Text('查看天氣預報', style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
