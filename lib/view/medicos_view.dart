import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:medicos_jwt/view/login_view.dart';

class MedicosView extends StatefulWidget {
  const MedicosView({super.key});

  @override
  State<MedicosView> createState() => _MedicosViewState();
}

class _MedicosViewState extends State<MedicosView> {
  final storage = FlutterSecureStorage();
  String? token = '';

  // Obter o valor da storage
  Future<void> inicializador() async {
    token = await storage.read(key: 'token');
 //verificar se o token expirou
    if (token == "" || JwtDecoder.isExpired(token!)) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginView()));
      //remover o token da storage
    };
  }

  @override
  void initState() {
    super.initState();
    inicializador();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: storage.read(key: 'token'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('Medicos'),
              ),
              body: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Medicos ${snapshot.data ?? ''}'),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                      label: Text('Procurar médicos'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await storage.delete(key: 'token');
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginView()));
                      },
                      icon: Icon(Icons.logout),
                      label: Text('Sair'),
                      
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
 
 
// Scaffold(
//       appBar: AppBar(
//         title: Text('Medicos'),
//       ),
//       body: SizedBox(
//         width: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Medicos'),
//             ElevatedButton.icon(
//               onPressed: (){},
//               icon: Icon(Icons.search),
//               label: Text('Procurar médicos'),
//             )
//           ],
//         ),
//       ),
//     );
 
 