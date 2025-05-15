import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  // ✅ 新增簡體轉繁體函式
  String convertToTraditionalChinese(String text) {
    return text
        .replaceAll("的", "的")
        .replaceAll("你", "您")
        .replaceAll("吗", "嗎")
        .replaceAll("是的", "是的")
        .replaceAll("推荐", "推薦")
        .replaceAll("活动", "活動")
        .replaceAll("酒店", "飯店")
        .replaceAll("价格", "價格")
        .replaceAll("联系", "聯繫")
        .replaceAll("电话", "電話")
        .replaceAll("帮助", "幫助")
        .replaceAll("问题", "問題")
        .replaceAll("免费", "免費")
        .replaceAll("信息", "資訊")
        .replaceAll("欢迎", "歡迎")
        .replaceAll("旅游", "旅遊")
        .replaceAll("体验", "體驗")
        .replaceAll("服务", "服務")
        .replaceAll("风景", "風景")
        .replaceAll("天气", "天氣")
        .replaceAll("专门", "專門")
        .replaceAll("关于", "關於")
        .replaceAll("如果", "如果")
        .replaceAll("怎么样", "怎麼樣")
        .replaceAll("不错", "不錯")
        .replaceAll("现在", "現在")
        .replaceAll("了解", "瞭解")
        .replaceAll("下载", "下載")
        .replaceAll("网页", "網頁")
        .replaceAll("这样", "這樣")
        .replaceAll("为什么", "為什麼")
        .replaceAll("对不起", "對不起")
        .replaceAll("谢谢", "謝謝")
        .trim();
  }

  void sendMessage() async {
    String message = _controller.text.trim();
    if (message.isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "text": message});
      _controller.clear();
      _isLoading = true;
    });

    var dio = Dio();
    try {
      var response = await dio.post(
        'http://192.168.0.13:1234/詢問/詢問',
        options: Options(headers: {"Content-Type": "application/json"}),
        data: {"question": message},
      );

      print("🟢 API 回應: ${response.data}");

      String aiResponse = "⚠️ AI 沒有有效回應";

      if (response.data != null && response.data is Map) {
        if (response.data.containsKey("data") &&
            response.data["data"] is Map &&
            response.data["data"].containsKey("answer")) {
          aiResponse = response.data["data"]["answer"].toString();

          // ✅ 過濾 <think> 內容
          aiResponse =
              aiResponse
                  .replaceAll(RegExp(r'<think>.*?</think>', dotAll: true), '')
                  .trim();

          // ✅ 移除 ** 符號
          aiResponse = aiResponse.replaceAll("**", "").trim();

          // ✅ 轉換為繁體中文
          aiResponse = convertToTraditionalChinese(aiResponse);
        }
      }

      setState(() {
        _messages.add({"sender": "ai", "text": aiResponse});
      });
    } catch (e) {
      print("❌ 錯誤訊息: $e");
      setState(() {
        _messages.add({"sender": "ai", "text": "❌ 無法連接到 AI 伺服器: $e"});
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('海洋遊憩智慧助理')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message["sender"] == "user";
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message["text"]!,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading) const CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _isLoading ? null : sendMessage(),
                    decoration: const InputDecoration(
                      hintText: "輸入你的問題...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _isLoading ? null : sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
