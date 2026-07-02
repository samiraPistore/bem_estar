import 'package:bem_estar/componentes/btn_shape.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final bool isLoading;
  final Function(String username, String password) onSubmeter;

  const LoginForm({
    super.key,
    required this.isLoading,
    required this.onSubmeter,
  });

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
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome',textAlign: TextAlign.justify),
                SizedBox(height: 10),
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Campo obrigatório' : null,
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Senha',textAlign: TextAlign.justify),
                SizedBox(height: 10),
                TextFormField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Campo obrigatório' : null,
                ),
              ],
            ),
          ),

          SizedBox(height: 32),

          // espera provider carregar
          widget.isLoading
              ? const CircularProgressIndicator()
              : CustomBtn(
                  title: 'Entrar',
                  onpress: () {
                    if (_isBotaoHabilitado = true) {
                      _submitForm();
                    } else {
                      return null;
                    }
                  },
                ),
        ],
      ),
    );
  }
}
