import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_meddi_yosidey/blocs/blocs_export.dart';

import 'package:technical_test_meddi_yosidey/libraries/components/widgets_generic.dart';
import 'package:technical_test_meddi_yosidey/libraries/utilities/displayInfo.dart';
import 'package:technical_test_meddi_yosidey/libraries/utilities/validations.dart';
import 'package:technical_test_meddi_yosidey/models/user/user_model.dart';
import 'package:technical_test_meddi_yosidey/screens/global/global_export.dart';
import 'package:technical_test_meddi_yosidey/screens/user/user_export.dart';
import 'package:technical_test_meddi_yosidey/libraries/app_data.dart' as app_data;
import 'package:technical_test_meddi_yosidey/services/requests/hospital_request.dart';
import 'package:technical_test_meddi_yosidey/services/requests/user_request.dart';

class UserLoginPage extends StatelessWidget {
  const UserLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UserBloc(globalBloc: BlocProvider.of<GlobalBloc>(context));
      },
      child: const UserLoginFrom(),
    );
  }
}

class UserLoginFrom extends StatefulWidget {
  const UserLoginFrom({super.key});

  @override
  State<UserLoginFrom> createState() => _UserLoginFromState();
}

class _UserLoginFromState extends State<UserLoginFrom> {
  final _formKeyLogin = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final vl = Validations();
  late bool isLoading = false;
  late bool isObscure = true;

  void onPressLogin() {
    if (_formKeyLogin.currentState!.validate()) {
      BlocProvider.of<UserBloc>(context).add(UserLoginInEvent(
          user: UserLogin(
        userName: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      )));
    }
  }

  void onPressRegister() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const UserCreatePage()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GlobalBloc, GlobalState>(
      listener: (context, state) {},
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          setState(() {
            if (state is UserInitialState) {}
            if (state is UserLoadingState) {
              isLoading = true;
              FocusScope.of(context).requestFocus(FocusNode());
            }
            if (state is UserSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Exito"),
                  action: SnackBarAction(label: "Entiendo", onPressed: () {}),
                ),
              );
              isLoading = false;
            }
            if (state is UserFailedState) {
              isLoading = false;
              _passwordController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Usuario o contraseña incorrecta"),
                  action: SnackBarAction(label: "Entiendo", onPressed: () {}),
                ),
              );
            }
          });
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Scaffold(
                appBar: AppBar(title: const Text("Inicia session")),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Form(
                        onChanged: () {
                          setState(() {});
                        },
                        key: _formKeyLogin,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(app_data.appTitle, style: TextStyle(fontSize: displayDensity(context) * 0.03)),
                              const Icon(Icons.person, size: 128),
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  labelText: "Correo Electrónico",
                                  hintText: "Ingresa Correo Electrónico",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (!vl.isEmail(value!)) {
                                    return "Correo Electrónico requerido";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 32),
                              TextFormField(
                                controller: _passwordController,
                                keyboardType: TextInputType.text,
                                obscureText: isObscure,
                                decoration: InputDecoration(
                                  labelText: "Contraseña",
                                  hintText: "Ingresa Contraseña",
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isObscure = !isObscure;
                                      });
                                    },
                                    icon: visibility(isObscure),
                                  ),
                                ),
                                validator: (value) {
                                  if (vl.isEmpty(value ?? "")) {
                                    return "Contraseña requerida";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 32),
                              SizedBox(
                                width: double.infinity,
                                height: 54,
                                child: ElevatedButton(
                                    onPressed: (isLoading || _passwordController.text.isEmpty) ? null : onPressLogin,
                                    child: const Text("Iniciar sesión")),
                              ),
                              const SizedBox(height: 8),
                              TextButton(onPressed: (isLoading) ? null : onPressRegister, child: const Text("Registrarte")),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (isLoading) loadingIndicator(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
