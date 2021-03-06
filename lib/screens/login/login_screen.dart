import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validators.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget{

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
                builder: (_, userManager, child){
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        controller: emailController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(hintText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email){
                          if(!emailValid(email!)){
                            return 'Email inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        controller: passController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(hintText: 'Senha'),
                        autocorrect: false,
                        obscureText: true,
                        validator: (pass){
                          if(pass!.isEmpty || pass.length < 6) {
                            return 'Ops, algo deu errado';
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: (){

                          },
                          padding: EdgeInsets.zero,
                          child: const Text('Esqueci a senha'),
                        ),
                      ),
                      SizedBox(
                        height: 44,
                        child: RaisedButton(
                          onPressed: userManager.loading ? null : (){
                            if(formKey.currentState!.validate()){
                              context.read<UserManager>().signIn(
                                  user: UserAuth(
                                      email: emailController.text,
                                      password: passController.text
                                  ),
                                  onFail: (e){
                                    scaffoldKey.currentState!.showSnackBar(
                                        SnackBar(
                                          content: Text('Falha ao entrar: $e'),
                                          backgroundColor: Colors.red,
                                        )
                                    );
                                  },
                                  onSuccess: (){
                                    // TODO: FECHAR TELA DE LOGIN
                                  }
                              );
                            }
                          },

                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: userManager.loading ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ) :
                          const Text('Entrar', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                    ],
                  );
                },

            ),
          ),
        ),
      ),
    );

  }


}