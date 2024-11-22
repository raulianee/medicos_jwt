import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medicos_jwt/model/usuario_model.dart';


class LoginController {
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  FlutterSecureStorage storage = FlutterSecureStorage();
  UsuarioModel usuarioModel = UsuarioModel();

  Future<bool> logar() async {
    usuarioModel.email = email.text;
    usuarioModel.setSenha(senha.text);
    //obtendo token
    String? token = await usuarioModel.logar();
    //salvando token
    await storage.write(key: 'token', value: token);
    return token != "";
  }
}
