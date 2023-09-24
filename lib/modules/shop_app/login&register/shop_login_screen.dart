import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/login&register/shop_register/shop_register_screen.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/componant/component.dart';
import '../../../shared/componant/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'Login&register_cubit/cubit.dart';
import 'Login&register_cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {

  var emailController=TextEditingController();
  var passController=TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context)=>ShopLoginRegisterCubit(),
      child: BlocConsumer<ShopLoginRegisterCubit,ShopLoginRegisterStates>(
        listener: (context,state){
          if(state is ShopSuccessLoginState) {
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
                      children:  [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'login now to browse our hot offer',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey
                          ),
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
                                return 'the password not allow to be empty';
                              }
                              return null;
                            },
                            isPassword: ShopLoginRegisterCubit.get(context).isPassword,
                            suffix: ShopLoginRegisterCubit.get(context).suffix,
                            suffixPressed: (){
                              ShopLoginRegisterCubit.get(context).changePasswordIcons();
                            },
                            onSubmit: (value){
                              // دي علشان لما يضغط علي الصح يعمل للوجين
                                if(formKey.currentState!.validate()) {
                                  ShopLoginRegisterCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passController.text);
                                }
                          },

                        ),

                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoadingLoginState,
                          builder: (context)=>defaultButton(
                            function: (){
                              if(formKey.currentState!.validate()) {
                                ShopLoginRegisterCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passController.text);
                              }},
                            text: 'Login',
                          ),
                          fallback:(context)=> Center(child: CircularProgressIndicator()),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Don\'t have an account ? '
                            ),
                            defaultTextButton(
                                function: (){
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                text: 'Register Now'
                            ),
                          ],
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
