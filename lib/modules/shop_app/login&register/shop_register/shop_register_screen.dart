import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../layout/shop_app/shop_layout.dart';
import '../../../../shared/componant/component.dart';
import '../../../../shared/componant/constants.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../Login&register_cubit/cubit.dart';
import '../Login&register_cubit/states.dart';


class ShopRegisterScreen extends StatelessWidget {


  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passController=TextEditingController();
  var phoneController=TextEditingController();

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopLoginRegisterCubit,ShopLoginRegisterStates>(
      listener: (context,state){
      if(state is ShopSuccessRegisterState) {
        if(state.loginModel.status!){
          print(state.loginModel.message);
          print(state.loginModel.data!.token);
          CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value) {
            token=state.loginModel.data!.token;
            navigateFinish(context, ShopLayout());
          });
        }else{
          print(state.loginModel.message);
          messageToast(
              msg: state.loginModel.message!,
              state: ToastStates.ERROR
          );

        }
      }
      },
      builder: (context,state){
        return Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black
                        ),
                      ),
                      Text(
                        'register now to browse our hot offer',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultTextForm(
                        controller: nameController,
                        type: TextInputType.name,
                        labelText: "UserName",
                        prefix: Icons.person,
                        validate: (value){
                          if(value.isEmpty){
                            return 'the name not allow to be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultTextForm(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        labelText: "Email Address",
                        prefix: Icons.email,
                        validate: (value){
                          if(value.isEmpty){
                            return 'the email not allow to be empty';
                          }
                          return null;
                        },
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      defaultTextForm(
                        controller: passController,
                        type: TextInputType.visiblePassword,
                        labelText: "Password",
                        prefix: Icons.lock,
                        validate: (value){
                          if(value.isEmpty){
                            return 'password is too short';
                          }
                          return null;
                        },
                        isPassword: ShopLoginRegisterCubit.get(context).isPassword,
                        suffix: ShopLoginRegisterCubit.get(context).suffix,
                        suffixPressed: (){
                          ShopLoginRegisterCubit.get(context).changePasswordIcons();
                        },
                        onSubmit: (value){
                          }
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultTextForm(
                        controller: phoneController,
                        type: TextInputType.phone,
                        labelText: "Phone",
                        prefix: Icons.phone,
                        validate: (value){
                          if(value.isEmpty){
                            return 'the phone not allow to be empty';
                          }
                          return null;
                        },
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopLoadingRegisterState,
                        builder: (context)=>defaultButton(
                          function: (){
                            if(formKey.currentState!.validate()) {
                              ShopLoginRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passController.text,
                                  phone: phoneController.text
                              );
                            }},
                          text: 'Register',
                        ),
                        fallback:(context)=> Center(child: CircularProgressIndicator()),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
