import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final VoidCallback onConfirm;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    required this.buttonText,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: Text(content, style: TextStyle(fontSize: 16)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("取消", style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text(buttonText),
        ),
      ],
    );
  }
}

// 使用方式
void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (context) => CustomDialog(
          title: "提示",
          content: "確定要執行此操作嗎？",
          buttonText: "確定",
          onConfirm: () {
            print("操作已確認");
          },
        ),
  );
}
