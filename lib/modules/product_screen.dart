import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/home_models.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/state_mangment/app_cubit.dart';
import 'package:shop_app/shared/state_mangment/app_state.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is SetFavoriteSuccessState)
            if(state.model.status==false){
              toast(color: Colors.red, message:state.model.message??'');
            }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return ConditionalBuilder(
            condition:cubit.productModel!=null&&cubit.productModel!.status==true,
              builder: (context) => buildProducts(cubit.productModel,cubit.categoryModel,context),
              fallback: (context) => Center(child: CircularProgressIndicator()));

        }
        );

    }
  Widget buildProducts(HomeModel? model,CategoryModel? categoryModel,context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model!.data!.banners
                .map((e) =>
                Image(
                  image: NetworkImage('${e.image}'),
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ))
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 4),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              reverse: false,
              viewportFraction: 1,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),),
                SizedBox(height: 10,),
                Container(
                  height: 100,
                  child: ListView.separated(
                      itemBuilder:(context,index)=>categoryItem(categoryModel!.data!.data![index]) ,
                      separatorBuilder:(context,index)=> SizedBox(width: 10,),
                      itemCount: categoryModel!.data!.data!.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                  ),
                ),
                SizedBox(height: 20,),
                Text('Products',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            color: Colors.grey,
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.75,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(model.data!.products.length, (index) =>
                  buildItem(model.data!.products[index],context),),
            ),
          ),
        ],
      ),
    );
  }
  Widget categoryItem(Data model){
    return  Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image:NetworkImage(model.image??''),
          width: 100,
          height: 100,
        ),
        Container(
          color: Colors.black.withOpacity(0.6),
          width:100,
          child: Text(
            model.name??'',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign:TextAlign.center,
          ),

        ),
      ],
    );

  }
  Widget buildItem(Product product,context) {
    var cubit =AppCubit.get(context);
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: NetworkImage(product.image ?? ''),
                  height: 200,
                  width: double.infinity,
                ),
              ),
              if(product.disCount != 0)
              Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('DisCount',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  child: Text(product.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  height: 25,
                ),
                Row(
                  children: [
                    Text('price:${product.price!.round()}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 5,),
                    if(product.disCount != 0)
                      Text('${product.oldPrice!.round()}',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                       cubit.addFavorite(product.id);
                      },
                      icon: CircleAvatar(child: Icon(Icons.favorite_outline_sharp,
                      color: Colors.white,),
                      radius: 15,
                      backgroundColor:cubit.favorites[product.id]!=null&&cubit.favorites[product.id]==true?Colors.blue:Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
