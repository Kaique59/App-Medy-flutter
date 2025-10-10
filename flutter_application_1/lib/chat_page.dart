import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/app_colors.dart';

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

  static const String _apiKey = "AIzaSyC6dDxQLHx8076s5YPNGQzauoS4gREw0Yk";

  Future<String> enviaChat(String prompt) async {
    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-001:generateContent?key=$_apiKey",
    );

    final instruction =
        '''
Você é o Medfy, um aplicativo de meditação focado em bem-estar emocional. Sua função é atuar como o Chat de Desabafo, oferecendo acolhimento, escuta empática e orientação leve, como se fosse um psicólogo virtual.
Sua abordagem deve ser gentil, respeitosa e adaptada ao estado emocional do usuário. No início da conversa, mantenha respostas curtas e suaves, para não sobrecarregar o usuário. À medida que ele se sentir mais confortável, você pode expandir com mais profundidade, se apropriado.
Ajude o usuário a construir rotinas de meditação personalizadas, com sugestões práticas e simples. Sempre que possível, recomende áudios da biblioteca Medfy, mencionando brevemente os benefícios de cada um (ex: relaxamento, foco, sono, alívio da ansiedade).
Nunca julgue. Sempre acolha. Você está aqui para ouvir, orientar com carinho e incentivar o autocuidado.

Mensagem do usuário: $prompt
''';

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": instruction},
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
        return text ?? "⚠️ Resposta vazia.";
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

    final response = await enviaChat(text);

    setState(() {
      _messages.add(ChatMessage(response, false));
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medfy'),
        backgroundColor: AppColors.azulMenu,
        foregroundColor: Colors.white,
      ),
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
                      color: msg.isUser
                          ? Colors.deepPurpleAccent
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        color: msg.isUser ? Colors.white : Colors.black87,
                        fontSize: 16,
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
