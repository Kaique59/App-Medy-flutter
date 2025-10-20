import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

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

  final Color verdePrincipal = const Color(0xFF7A9591);
  final Color inputBackgroundColor = const Color(0xFFD5E0D9);

  // IMPORTANTE: Use sua chave de API completa e real aqui!
  static const String _apiKey =
      "AIzaSyC6dDxQLHx8076s5YPNGQzauoS4gREw0Yk"; // Coloque sua chave real

  Future<String> enviaChat(String prompt) async {
    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-001:generateContent?key=$_apiKey",
    );

    final instruction =
        '''
Mantenha uma abordagem gentil, respeitosa e suave, focada em relaxar o corpo e a mente do usuário.

Evite se aprofundar em temas pessoais do usuário. Se o usuário insistir em compartilhar algo pessoal, responda de forma educada e neutra, por exemplo:

“Entendo, mas aqui nosso foco é ajudar você a relaxar e meditar, trazendo mais presença e tranquilidade no momento.”

Caso o usuário traga temas fora do escopo da meditação ou do bem-estar emocional, responda com delicadeza e direcione a conversa para a prática meditativa:

“Obrigado por compartilhar, mas vamos focar em práticas que ajudam você a relaxar e cuidar do seu bem-estar agora.”

Sempre retorne o foco à meditação e ao autocuidado, ajudando o usuário a se conectar com o momento presente.

Oriente a prática de meditação por três fases (Introdução, Novo Ciclo, Avançada), conforme já descrito, usando linguagem clara e simples.

Recomende áudios da biblioteca Medfy com explicações curtas sobre seus benefícios, para apoiar a experiência do usuário.

Nunca faça julgamentos, diagnósticos ou aconselhamentos que extrapolem o papel de um guia meditativo.

Se for necessário, reafirme com gentileza os limites do aplicativo, sempre respeitando o usuário.



Oriente a prática da meditação por três fases:

1. **Introdução à Meditação**
   - Ensine técnicas básicas de respiração: inspirar pelo nariz, expirar pela boca, focando no momento presente.
   - Ajude o usuário a relaxar corpo e mente, soltando tensões físicas e preocupações.
   - Explique que aprender a meditar é um processo: comece com poucos minutos por dia, focando na respiração, sem buscar perfeição — apenas presença.

2. **Novo Ciclo de Meditação**
   - Traga reflexões sobre aceitação: acolher as emoções sem resistência, reconhecendo o que se sente.
   - Ajude o usuário a encontrar equilíbrio entre ação e pausa, mostrando que o equilíbrio é um estado interno.
   - Estimule o usuário a buscar propósito com introspecção, percebendo o que faz sentido em sua vida de forma genuína.

3. **Meditação Avançada**
   - Fale sobre a conexão entre mente e corpo: respiração consciente gera alinhamento e vitalidade.
   - Fortaleça o foco e a atenção plena, observando pensamentos sem julgamentos.
   - Mostre como acessar a calma interior, um espaço silencioso e estável que não depende do mundo externo.

Sempre que possível, recomende áudios da biblioteca Medfy, explicando brevemente seus benefícios:
- "Respiração Consciente" → ideal para começar e voltar ao presente.
- "Relaxamento Guiado" → ajuda a soltar tensões físicas e mentais.
- "Sono Tranquilo" → favorece o descanso profundo.
- "Alívio da Ansiedade" → útil em momentos de sobrecarga emocional.
- "Foco e Clareza" → para momentos de estudo, trabalho ou tomada de decisão.



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
        backgroundColor: verdePrincipal,
        title: const Text(
          'Medfy',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(color: verdePrincipal),

          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Opacity(
                opacity: 0.08,
                child: Transform.rotate(
                  angle: -0.3,
                  child: const Icon(Icons.eco, size: 400, color: Colors.white),
                ),
              ),
            ),
          ),

          Column(
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
                              ? Colors.deepPurpleAccent.withOpacity(0.85)
                              : Colors.white.withOpacity(0.85),
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

              Container(
                color: inputBackgroundColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Digite sua mensagem...',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _isLoading ? null : _sendMessage,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
