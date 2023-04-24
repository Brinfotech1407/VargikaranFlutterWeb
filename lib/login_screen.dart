import 'package:flutter/material.dart';
import 'package:vargikaran_web_app/utils/vargikarn_utils.dart';

import 'home/home.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: const Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final double _formProgress = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              alignment: Alignment.centerLeft,
              child: Text('Welcome!', style: Theme.of(context).textTheme.headlineSmall),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: LinearProgressIndicator(value: _formProgress),
            ),
            Utils().textFormFiledView(
              order: 200,
              controller: _usernameTextController,
              hintText: 'Enter User Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return  'Please enter some text';
                } else if (value != 'admin') {
                  return 'Enter UserName is not correct';
                }
                return null;
              },
            ),
            Utils().textFormFiledView(
              order: 201,
              controller: _passwordTextController,
              hintText: 'Enter Password',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return  'Please enter some text';
                } else if (value != 'admin') {
                  return 'Enter password is not correct';
                }
                return null;
              },
            ),
            const SizedBox(height: 14,),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                      return states.contains(MaterialState.disabled)
                          ? null
                          : Colors.white;
                    }),
                backgroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                      return states.contains(MaterialState.disabled)
                          ? null
                          : Colors.blueGrey;
                    }),
                elevation: MaterialStateProperty.all(1),

              ),
              onPressed: () {
                if(_usernameTextController.text.isNotEmpty && _passwordTextController.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage(),),
                  );
                }
              },
              child:  const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Login', style:TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
