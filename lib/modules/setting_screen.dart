import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_models.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/state_mangment/app_cubit.dart';
import 'package:shop_app/shared/state_mangment/app_state.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  var nameControler = TextEditingController();
  var emailControler = TextEditingController();
  var phoneControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState) {
          if (state.model.status??false) {
            toast(color: Colors.green, message: state.model.message ?? 'null');
          } else {
            toast(color: Colors.red, message: state.model.message ?? 'null');
          }
        }
      },
      builder: (context, state) {
        if (cubit.userModel!.status==true) {
          nameControler.text = (cubit.userModel?.data?.name ?? 'ff');
          phoneControler.text = (cubit.userModel?.data?.phone ?? 'ff');
          emailControler.text = (cubit.userModel?.data?.email ?? 'ff');
        }


        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(children: [
                Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Switch(
                    value: AppCubit.get(context).isDark,
                    onChanged: (value) {
                      AppCubit.get(context).changeThemeMode(value);
                    }),
              ]),
              Row(children: [
                Text(
                  'Arabic Language',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Switch(
                    value:cubit.language=='ar'?true:false,
                    onChanged: (value) {
                      cubit.changeLanguage(value);
                    }),
              ]),
              ConditionalBuilder(
                condition: cubit.userModel != null&&cubit.userModel!.status==true,
                builder: (context) => buildItem(cubit.userModel!.data, context, state),
                fallback: (context) => Center(child: CircularProgressIndicator()),
              ),
            ]),
          ),
        );
      },
    );
  }

  Widget buildItem(UserData? model, context, state) {
    return SingleChildScrollView(
        child: Column(
          children: [
            if (state is UpdateProfileLoadingState) LinearProgressIndicator(),
            defaultTextField(
                validat: (String? value) {
                  if (value!.isEmpty) {
                    return 'field can\'t be null';
                  }
                },
                controller: nameControler,
                keyboardType: TextInputType.text,
                label: 'Name',
                prefixIcon: Icons.person),
            SizedBox(
              height: 10,
            ),
            defaultTextField(
                validat: (String? value) {
                  if (value!.isEmpty) {
                    return 'field can\'t be null';
                  }
                },
                controller: emailControler,
                keyboardType: TextInputType.emailAddress,
                label: 'Email',
                prefixIcon: Icons.email_outlined),
            SizedBox(
              height: 10,
            ),
            defaultTextField(
                validat: (String? value) {
                  if (value!.isEmpty) {
                    return 'field can\'t be null';
                  }
                },
                controller: phoneControler,
                keyboardType: TextInputType.number,
                label: 'Phone',
                prefixIcon: Icons.phone),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            defaultButton(
                function: () {
                  AppCubit.get(context).updateProfile(
                      email: emailControler.text,
                      phone: phoneControler.text,
                      name: nameControler.text);
                },
                title: 'Update'),
            SizedBox(
              height: 10,
            ),
            defaultButton(
                function: () {
                  logOut(context);
                },
                title: 'logout'),
          ],
        ),
    );
  }
}
