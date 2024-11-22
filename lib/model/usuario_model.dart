import 'dart:convert';
 
import 'package:http/http.dart' as http;
class UsuarioModel {
  String? email;
  String? nome;
  String? _senha;
 
  void setSenha(senha){
    _senha = senha;
  }
 
    Future<String?> logar() async {
    final response = await http.post(
        Uri.parse('http://pin0581814w10-1.senacsp.edu.br:3010/login'),
        body: jsonEncode ({"email": email, "senha": _senha}),
        headers: {"Content-Type": "application/json; charset=utf-8"});
      if (response.statusCode == 200) {
        Map<String, dynamic> resposta = jsonDecode(response.body) as Map<String, dynamic>;
        return resposta['token'];
    } else {
      throw Exception('Falha ao logar');
    }
  }
 
 
}