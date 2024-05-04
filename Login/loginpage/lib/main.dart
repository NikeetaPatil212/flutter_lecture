import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  //Controllers
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  //KEYS
  //GlobalKey<FormFieldState> userNameKey = GlobalKey<FormFieldState>();
  //GlobalKey<FormFieldState> passwordNameKey = GlobalKey<FormFieldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Login Page"),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: 
            Form(
              key: _formKey,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.network(
                      "https://cdn-icons-png.flaticon.com/512/295/295128.png",
                      height: 90,width: 90,),                  
                    const SizedBox(height: 20,),

                    TextFormField(
                    controller: userNameTextEditingController,
                    //key: userNameKey,
                   
                   
                    decoration: InputDecoration(
                        hintText: "Enter Useraname",
                        label: const Text("Enter Username"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                        ),
                      ),
                      validator: (value) {
                        print("In Username Validator");
                        if(value == null || value.isEmpty){
                          return "Please enter username";
                        }else{
                          return null;
                        }
                      },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20,),

                  TextFormField(
                    controller: passwordTextEditingController,
                    //key: passwordNameKey,
                    obscureText: true, //make secuure passowrd
                    obscuringCharacter: "*", //insted of showing password
                    decoration: InputDecoration(
                        hintText: "Enter Password",
                        label: const Text("Enter password"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        suffixIcon: const Icon(
                          Icons.remove_red_eye_outlined,
                        ),
                      ),
                      validator: (value) {
                        print("In Password Validator");
                        if(value == null || value.isEmpty){
                          return "Please enter password";
                        }else{
                          return null;
                        }
                      },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: (){
                      bool loginValidate = _formKey.currentState!.validate();
                      if(loginValidate){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login Successful"),),
                        );
                      }else{
                         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login Failed"),
                          ),
                        );
                      }
                    }, 
                    child: const Text("Login"),
                  ),
              ],)
              
              ),
              ),
              );
  }
}