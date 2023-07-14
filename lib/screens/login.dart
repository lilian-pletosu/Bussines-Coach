import 'package:bussines_coach/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  String? errorMessage = '';
  bool isLogin = true;
  bool isDone = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _errorMessage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        errorMessage == '' ? '' : 'Humm ? $errorMessage',
        style: GoogleFonts.poppins(color: Colors.red),
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: isLogin
            ? signInWithEmailAndPassword
            : createUserWithEmailAndPassword,
        child: Text(
          isLogin ? 'Logare' : 'Înregistrare',
          style: GoogleFonts.poppins(),
        ));
  }

  Widget _logo() {
    return Padding(
      padding: const EdgeInsets.only(
        // bottom: 80.0,
        left: 32.0,
        right: 32.0,
      ),
      child: Align(
          alignment: Alignment.topCenter,
          child: Image.asset('images/logo_coach.png')),
    );
  }

  Widget _introText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        isLogin ? 'Intră în cont' : 'Crează un cont nou',
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(
          isLogin
              ? 'Nu ai un cont? Creează-ți!'
              : 'Ai deja un cont? Loghează-te',
          style: GoogleFonts.poppins(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: _title()),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _logo(),
            Column(
              children: [
                _introText(),
                _entryField('Email', _emailController),
                _entryField('Password', _passwordController),
                _errorMessage(),
                _submitButton(),
                _loginOrRegisterButton()
              ],
            )
          ],
        ),
      ),
    );
  }
}
