import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class Page4 extends StatefulWidget {
  const Page4({super.key});

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  final List<Map<String, String>> _items = [];
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  void _addTextNote() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _items.add({'type': 'text', 'content': text});
        _textController.clear();
      });
    }
  }

  void _addUrlNote() {
    final url = _urlController.text.trim();
    if (url.isNotEmpty) {
      setState(() {
        _items.add({'type': 'url', 'content': url});
        _urlController.clear();
      });
    }
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String fileName = result.files.single.name;
      setState(() {
        _items.add({'type': 'file', 'content': fileName});
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI 對話收藏 / 上傳 / 連結')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: const InputDecoration(
                          hintText: '輸入文字內容...',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.save, color: Colors.blue),
                      onPressed: _addTextNote,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _urlController,
                        decoration: const InputDecoration(
                          hintText: '輸入網址連結...',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.link, color: Colors.green),
                      onPressed: _addUrlNote,
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: _pickFile,
                  icon: const Icon(Icons.upload_file),
                  label: const Text('上傳檔案'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                final isText = item['type'] == 'text';
                final isUrl = item['type'] == 'url';
                final isFile = item['type'] == 'file';

                return Card(
                  child: ListTile(
                    leading: Icon(
                      isText
                          ? Icons.bookmark
                          : isUrl
                          ? Icons.link
                          : Icons.insert_drive_file,
                      color:
                          isText
                              ? Colors.amber
                              : isUrl
                              ? Colors.green
                              : Colors.grey,
                    ),
                    title:
                        isUrl
                            ? GestureDetector(
                              onTap: () => _launchUrl(item['content']!),
                              child: Text(
                                item['content']!,
                                style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                            : Text(item['content']!),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeItem(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
