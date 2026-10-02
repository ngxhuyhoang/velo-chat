import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velo_chat/providers/auth_provider.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _emailErrorMessage;
  String? _passwordErrorMessage;

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _emailErrorMessage = null;
      _passwordErrorMessage = null;
    });

    try {
      await ref
          .read(authProvider.notifier)
          .login(_emailController.text.trim(), _emailController.text.trim());
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT, // ≈ ToastAndroid.SHORT
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
      );
    }
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? "";
    if (email.isEmpty) return "Vui lòng nhập Email";
    if (!email.contains("@")) return "Email không hợp lệ";
    return null;
  }

  String? _validatePassword(String? value) {
    final password = value ?? "";
    if (password.isEmpty) return "Vui lòng nhập mật khẩu";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 16,
              children: [
                TextFormField(
                  controller: _emailController,
                  validator: _validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                ),
                if (_emailErrorMessage != null)
                  Text(
                    _emailErrorMessage!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                TextFormField(
                  controller: _passwordController,
                  validator: _validatePassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                ),
                if (_passwordErrorMessage != null)
                  Text(
                    _passwordErrorMessage!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                FilledButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          submit();
                        },
                  child: Text("Đăng nhập"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
