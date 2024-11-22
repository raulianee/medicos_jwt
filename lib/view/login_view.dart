import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medicos_jwt/controller/login_controller.dart';
import 'package:medicos_jwt/view/medicos_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final storage = FlutterSecureStorage();
  String? teste = 'mensagem';
  LoginController _controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicos'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller.email,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _controller.senha,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                // Executa o login
                if (await _controller.logar()) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MedicosView()));
                }
                ;
              },
              icon: Icon(Icons.login),
              label: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
