import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_screen.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/network/local/shared_preferance.dart';
import 'package:shop_app/shared/state_mangment/login_state.dart';
import 'package:shop_app/shared/state_mangment/register_cubit.dart';
import 'package:shop_app/shared/state_mangment/register_state.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var emailControler = TextEditingController();
  var nameControler = TextEditingController();
  var phoneControler = TextEditingController();
  var passwordControler = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.model.status ?? true) {
              CacheHelper.saveData(
                  key: 'token', value: state.model.data!.token);
              token=state.model.data!.token;
              toast(
                  color: Colors.green, message: state.model.message ?? 'null');
                 goToFinal(context,HomeScreen());
            } else {
              toast(color: Colors.red, message: state.model.message ?? 'null');
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextField(
                          validat: (String? value) {
                            if (value!.isEmpty) {
                              return 'name can\'t be empty';
                            }
                            return null;
                          },
                          controller: nameControler,
                          keyboardType: TextInputType.name,
                          label: "Name",
                          prefixIcon: Icons.person,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextField(
                          validat: (String? value) {
                            if (value!.isEmpty) {
                              return 'Email can\'t be empty';
                            }
                            return null;
                          },
                          controller: emailControler,
                          keyboardType: TextInputType.emailAddress,
                          label: "Email Address",
                          prefixIcon: Icons.email,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextField(
                            validat: (String? value) {
                              if (value!.isEmpty) {
                                return 'password too short';
                              }
                              return null;
                            },
                            controller: passwordControler,
                            keyboardType: TextInputType.visiblePassword,
                            label: "Password",
                            prefixIcon: Icons.lock,
                            isPassword: cubit.isPassword,
                            suffixIcon: cubit.suffix,
                            suffixPressed: () {
                              cubit.changeShown();
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextField(
                          validat: (String? value) {
                            if (value!.isEmpty) {
                              return 'phone can\'t be empty';
                            }
                            return null;
                          },
                          controller: phoneControler,
                          keyboardType: TextInputType.number,
                          label: "Phone Number",
                          prefixIcon: Icons.phone,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                    email: emailControler.text,
                                    name: nameControler.text,
                                    phone: phoneControler.text,
                                    password: passwordControler.text);
                              }
                            },
                            title: 'Register',
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
