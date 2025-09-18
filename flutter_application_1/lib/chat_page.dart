import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage(this.text, this.isUser);
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  /// Coloque aqui sua API KEY do Gemini
  static const String _apiKey = "AIzaSyC6dDxQLHx8076s5YPNGQzauoS4gREw0Yk";

  Future<String> sendToGemini(String prompt) async {
    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-001:generateContent?key=$_apiKey",
    );

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {
              "text":
                  "Você é um aplicativo de meditação chamado Medfy. Mas vc trabalhara na parte do Chat de desabafo, seu dever é ser servir como um psicologo, você deve se adequar com seu usuário, de início de respostas mais curtas para que o usuário não se canse, vc deve ajudalo a fazer rotinas de meditação recomendar audios de nossa biblíoteca. sempre seja gentil $prompt",
            },
          ],
        },
      ],
    });

    try {
      final httpClient = HttpClient();
      final request = await httpClient.postUrl(url);

      request.headers.contentType = ContentType.json;
      request.write(body);

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody);
        final text = data["candidates"]?[0]?["content"]?["parts"]?[0]?["text"];
        return text ?? "⚠️ Resposta vazia do Gemini.";
      } else {
        return "Erro ${response.statusCode}: $responseBody";
      }
    } catch (e) {
      return "Erro de conexão: $e";
    }
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text, true));
      _isLoading = true;
    });
    _controller.clear();

    final response = await sendToGemini(text);

    setState(() {
      _messages.add(ChatMessage(response, false));
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Medfy')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: msg.isUser ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        color: msg.isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Digite sua mensagem...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _isLoading ? null : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
