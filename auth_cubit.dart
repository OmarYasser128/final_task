import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:final_project/auth_states.dart';
import 'package:final_project/user_model.dart';
import 'dart:developer';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());
  Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://qzoumdyohfddboyvfodi.supabase.co/auth/v1/",
      headers: {
        "apikey":
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF6b3VtZHlvaGZkZGJveXZmb2RpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkzNTA0NjMsImV4cCI6MjA1NDkyNjQ2M30.0756FNrNMhKzZCZpZdWyjhdm5D0GJr1jX-gzrsBORm4",
      },
    ),
  );

  Future<void> register({
    required Map<String, dynamic> data,
  }) async {
    emit(RegisterLoadingState());
    try {
      // post request with dio
      Response response = await dio.post(
        "signup",
        data: data,
      );
      userModel = UserModel.fromJson(json: response.data);
      log(response.data.toString());
      emit(RegisterSuccessState());
    } catch (e) {
      emit(RegisterErrorState(message: e.toString()));
    }
  }

  UserModel? userModel;
  // Login User Method
  Future<void> login({required Map<String, dynamic> data}) async {
    emit(LoginLoadingState());
    try {
      // post request with dio
      Response response = await dio.post(
        "token?grant_type=password",
        data: data,
      );

      userModel = UserModel.fromJson(json: response.data);
      log("User name is ${userModel?.name}");
      log("Access Token is ${userModel?.accessToken}");
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(message: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(LogoutLoadingState());
    try {
      Response response = await dio.post(
        "logout",
        options: Options(
          headers: {"Authorization": "Bearer ${userModel?.accessToken}"},
        ),
      );
      if (response.statusCode == 204) {
        emit(LogoutSuccessState());
      } else {
        throw "Failed to logout";
      }
    } catch (e) {
      emit(LogoutErrorState(errMsg: e.toString()));
    }
  }
}
