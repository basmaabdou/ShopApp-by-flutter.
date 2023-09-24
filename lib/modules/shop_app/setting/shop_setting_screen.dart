import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/componant/component.dart';
import '../../../shared/componant/constants.dart';

class ShopSettingScreen extends StatelessWidget {

  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();

  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, ShopStates state) {
      },
      builder: (BuildContext context, ShopStates state) {
        nameController.text=ShopCubit.get(context).userModel!.data!.name!;
        emailController.text=ShopCubit.get(context).userModel!.data!.email!;
        phoneController.text=ShopCubit.get(context).userModel!.data!.phone!;

        return ConditionalBuilder(
         // متلعبش علي loading لان احيانا بيجيب ايرور
        condition: ShopCubit.get(context).userModel != null,
        builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
                    children: [
                      if(state is ShopLoadingUpdateUserState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextForm(
                          controller: nameController,
                          type: TextInputType.name,
                          labelText: "UserName",
                          prefix: Icons.person,
                          validate: (value){
                            if(value.isEmpty){
                              return 'name must be not empty';
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextForm(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          labelText: "Email Address",
                          prefix: Icons.email,
                          validate: (value){
                            if(value.isEmpty){
                              return 'email must be not empty';
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextForm(
                          controller: phoneController,
                          type: TextInputType.phone,
                          labelText: "Phone",
                          prefix: Icons.phone,
                          validate: (value){
                            if(value.isEmpty){
                              return 'phone must be not empty';
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                        function: ()
                        {
                          if(formKey.currentState!.validate())
                          {
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        text: 'update',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                          function: (){
                            signOut(context);
                          },
                          text: "LOGOUT"
                      ),

                    ],
                  ),
        ),
              ),
            ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },

    );
  }
}
