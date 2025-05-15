import 'package:flutter/material.dart';
import '../login_page.dart';
import '../工具/custom_dialog.dart';

class Page5 extends StatelessWidget {
  const Page5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('個人資料'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('隱私設定'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('幫助中心'),
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (context) => CustomDialog(
                      title: "幫助中心",
                      content: "您確定要進入幫助中心嗎？",
                      buttonText: "確定",
                      onConfirm: () {
                        print("使用者查看幫助中心");
                      },
                    ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('登入帳號'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('登出'),
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (context) => CustomDialog(
                      title: "確認登出",
                      content: "您確定要登出嗎？",
                      buttonText: "確定",
                      onConfirm: () {
                        print("使用者已登出");
                      },
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}
