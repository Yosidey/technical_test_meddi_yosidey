import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_meddi_yosidey/blocs/blocs_export.dart';

import 'package:technical_test_meddi_yosidey/libraries/components/widgets_generic.dart';
import 'package:technical_test_meddi_yosidey/libraries/app_data.dart' as app_data;
import 'package:technical_test_meddi_yosidey/libraries/utilities/displayInfo.dart';
import 'package:technical_test_meddi_yosidey/libraries/utilities/validations.dart';
import 'package:technical_test_meddi_yosidey/models/user/user_model.dart';
import 'package:technical_test_meddi_yosidey/screens/global/global_export.dart';
import 'package:technical_test_meddi_yosidey/screens/user/user_export.dart';

class UserCreatePage extends StatelessWidget {
  const UserCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UserBloc(globalBloc: BlocProvider.of<GlobalBloc>(context));
      },
      child: const UserCreateFrom(),
    );
  }
}

class UserCreateFrom extends StatefulWidget {
  const UserCreateFrom({super.key});

  @override
  State<UserCreateFrom> createState() => _UserCreateFromState();
}

class _UserCreateFromState extends State<UserCreateFrom> {
  final _formKeyLogin = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _celPhoneController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();
  late bool isObscure1 = true;
  late bool isObscure2 = true;
  final vl = Validations();
  late bool isLoading = false;

  onPressRegister() {
    if (_formKeyLogin.currentState!.validate()) {
      BlocProvider.of<UserBloc>(context).add(UserCreateEvent(
          user: UserCreate(
        name: _nameController.text.trim(),
        userName: _emailController.text.trim(),
        password: _password1Controller.text.trim(),
        cellPhone: _celPhoneController.text.trim(),
      )));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _emailController.dispose();
    _celPhoneController.dispose();
    _password1Controller.dispose();
    _password2Controller.dispose();
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
              isLoading = false;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Usuario registrado con éxito"),
                  action: SnackBarAction(label: "Entiendo", onPressed: () {}),
                ),
              );
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
            if (state is UserFailedState) {
              isLoading = false;
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
                appBar: AppBar(title: const Text("Registra tu usuario")),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Form(
                        key: _formKeyLogin,
                        onChanged: () {
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(app_data.appTitle, style: TextStyle(fontSize: displayDensity(context) * 0.03)),
                              const Icon(Icons.person_add, size: 128),
                              TextFormField(
                                controller: _nameController,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  labelText: "Nombre",
                                  hintText: "Ingresa Nombre completo",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (vl.isEmpty(value ?? "")) {
                                    return "Nombre requerido";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 32),
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  labelText: "Correo Electrónico",
                                  hintText: "Ingresa Correo Electrónico ",
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
                                controller: _celPhoneController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  labelText: "Teléfono",
                                  hintText: "Ingresa Teléfono",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (!vl.isPhone(value!)) {
                                    return "Teléfono requerido";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 32),
                              TextFormField(
                                controller: _password1Controller,
                                keyboardType: TextInputType.text,
                                obscureText: isObscure1,
                                decoration: InputDecoration(
                                    labelText: "Contraseña",
                                    hintText: "Ingresa Contraseña",
                                    border: const OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isObscure1 = !isObscure1;
                                        });
                                      },
                                      icon: visibility(isObscure1),
                                    )),
                                validator: (value) {
                                  if (vl.isEmpty(value!)) {
                                    return "Contraseña requerida";
                                  }
                                  if (!vl.isEquals(_password1Controller.text, _password2Controller.text)) {
                                    return "Las contraseñas no son iguales";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 32),
                              TextFormField(
                                controller: _password2Controller,
                                keyboardType: TextInputType.text,
                                obscureText: isObscure2,
                                decoration: InputDecoration(
                                  labelText: "Repite Contraseña",
                                  hintText: "Ingresa Repite Contraseña",
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isObscure2 = !isObscure2;
                                      });
                                    },
                                    icon: visibility(isObscure2),
                                  ),
                                ),
                                validator: (value) {
                                  if (vl.isEmpty(value!)) {
                                    return "Contraseña requerida";
                                  }
                                  if (!vl.isEquals(_password1Controller.text, _password2Controller.text)) {
                                    return "Las contraseñas no son iguales ";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 32),
                              SizedBox(
                                width: double.infinity,
                                height: 54,
                                child: ElevatedButton(
                                  onPressed: (isLoading) ? null : onPressRegister,
                                  child: const Text("Registrarte"),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (isLoading) loadingIndicator()
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
