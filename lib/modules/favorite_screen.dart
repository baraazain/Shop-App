import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/state_mangment/app_cubit.dart';
import 'package:shop_app/shared/state_mangment/app_state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
        },
        builder: (context,state){
          var cubit=AppCubit.get(context);
          if(cubit.favoriteModel!= null && cubit.favoriteModel!.status==true)
          return ListView.separated(
            itemBuilder:(context,index)=>favoriteItem(cubit.favoriteModel!.data!.data![index].product,cubit) ,
            separatorBuilder:(context,index)=> sperator(),
            itemCount:cubit.favoriteModel!.data!.data!.length,
            physics: BouncingScrollPhysics(),
          );
          else return Container(child: Center(child: Text('Don\'t Have Any Product Favorite')),);
        },
      );
  }

}
Widget favoriteItem(product,cubit,{isOldprice=true}){
  return Container(
    height:100,
    width:double.infinity,
    child: Row(
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: NetworkImage(product!.image ?? ''),
                height: 100,
                width: 100,
              ),
            ),
            if(product.discount != 0 && isOldprice==true)
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
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(product.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text('price:${product.price!.round()}',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(width: 5,),
                  if(product.discount != 0 && isOldprice==true)
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

