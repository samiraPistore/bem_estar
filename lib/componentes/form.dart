import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final bool isLoading;
  final Function(String username, String password) onSubmeter;

  const LoginForm({Key? key, required this.isLoading, required this.onSubmeter})
    : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _isBotaoHabilitado = false;

  @override
  void initState() {
    super.initState();
    // Escuta as alterações dos campos 
    _nomeController.addListener(_validarCampos);
    _senhaController.addListener(_validarCampos);
  }

  void _validarCampos() {
    final nomePreenchido = _nomeController.text.trim().isNotEmpty;
    final senhaPreenchida = _senhaController.text.trim().isNotEmpty;

    setState(() {
      _isBotaoHabilitado = nomePreenchido && senhaPreenchida;
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Passa os dados para a página/provider tratar
      widget.onSubmeter(_nomeController.text.trim(), _senhaController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nomeController,
            decoration: const InputDecoration(
              labelText: 'Usuário',
              hintText: 'Digite seu usuário',
            ),
            validator: (value) =>
                value == null || value.isEmpty ? 'Campo obrigatório' : null,
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _senhaController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Senha',
              hintText: 'Digite sua senha',
            ),
            validator: (value) =>
                value == null || value.isEmpty ? 'Campo obrigatório' : null,
          ),
          SizedBox(height: 32),

          // espera provider carregar
          widget.isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: _isBotaoHabilitado ? _submitForm : null,
                  child: const Text('Entrar'),
                ),
        ],
      ),
    );
  }
}
