import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/state_mangment/app_cubit.dart';
import 'package:shop_app/shared/state_mangment/app_state.dart';

import 'favorite_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchControler = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'can\'t be empty';
                    }
                  },
                  controller: searchControler,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    label: Text('Search'),
                    border: OutlineInputBorder(),
                  ),
                  onFieldSubmitted: (value) {
                    AppCubit.get(context).searchProduct(value);
                  },
                ),
                if (state is SearchLoadingState) LinearProgressIndicator(),
                SizedBox(height: 20,),
                if(state is SearchSuccessState)
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => favoriteItem(
                        cubit.searchModel!.data!.data![index], cubit,
                        isOldprice: false),
                    separatorBuilder: (context, index) => sperator(),
                    itemCount: cubit.searchModel!.data!.data!.length,
                    physics: BouncingScrollPhysics(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
