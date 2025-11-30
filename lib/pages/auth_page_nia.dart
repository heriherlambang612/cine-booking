import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPageNIA extends StatefulWidget {
  @override
  State<AuthPageNIA> createState() => _AuthPageNIAState();
}

class _AuthPageNIAState extends State<AuthPageNIA> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  bool isLogin = true;
  bool loading = false;

  final auth = FirebaseAuth.instance;

  Future submit() async {
    if (!emailC.text.endsWith("@student.univ.ac.id")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gunakan email student.univ.ac.id")),
      );
      return;
    }

    try {
      setState(() => loading = true);

      if (isLogin) {
        await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );
      } else {
        await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );
      }

      Navigator.pushReplacementNamed(context, "/home");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Terjadi kesalahan")));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),

                // ICON LOGIN
                Icon(
                  isLogin ? Icons.lock_open : Icons.person_add,
                  size: 70,
                  color: Colors.blueAccent,
                ),

                const SizedBox(height: 10),

                Text(
                  isLogin ? "Selamat Datang" : "Daftar Akun",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // EMAIL
                TextField(
                  controller: emailC,
                  decoration: InputDecoration(
                    labelText: "Email Student",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // PASSWORD
                TextField(
                  controller: passC,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // BUTTON LOGIN / REGISTER
                loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: submit,
                        child: Text(
                          isLogin ? "Login" : "Register",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),

                const SizedBox(height: 15),

                // TEXT LOGIN / REGISTER SWITCH
                TextButton(
                  onPressed: () {
                    setState(() => isLogin = !isLogin);
                  },
                  child: Text(
                    isLogin
                        ? "Belum punya akun? Register"
                        : "Sudah punya akun? Login",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
