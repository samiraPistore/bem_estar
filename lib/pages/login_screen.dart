import 'package:bem_estar/componentes/form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bem_estar/providers/auth_provider.dart'; 

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Escuta as alterações no AuthProvider 
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30.0),
        child: SafeArea(
          child: Column(
          
            children: [
            
              Image.asset(
                'assets/logo.png', 
                width: MediaQuery.of(context).size.width * 0.4, 
              ),
              SizedBox(height: 40),
              
              
              LoginForm(
                isLoading: authProvider.isLoading,
                onSubmeter: (username, password) async {
                 
                  final sucesso = await authProvider.login(username, password);
                  
                  if (sucesso && context.mounted) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else if (context.mounted) {
                
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Usuário ou senha incorretos.'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}