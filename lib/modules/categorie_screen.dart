import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/state_mangment/app_cubit.dart';
import 'package:shop_app/shared/state_mangment/app_state.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=AppCubit.get(context);
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition:cubit.categoryModel!=null&&cubit.categoryModel!.status==true ,
          builder:(context)=>ListView.separated(
            itemBuilder:(context,index)=>buildcCtegoryScreen(cubit.categoryModel!.data!.data![index],context) ,
            separatorBuilder:(context,index)=> sperator(),
            itemCount: cubit.categoryModel!.data!.data!.length,
            physics: BouncingScrollPhysics(),
          ) ,
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        );

        },

    );
  }
  Widget buildcCtegoryScreen(Data model,context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image(image:NetworkImage(model.image??''),
          width: 100,
            height: 100,
          ),
          SizedBox(width: 30,),
          Text(model.name??'',
          maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style:Theme.of(context).textTheme.bodyText2
          ),
          Spacer(),
          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))

        ],
      ),
    );
  }
}
