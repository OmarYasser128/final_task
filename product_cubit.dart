import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'profile_states.dart';
import 'product.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading()); // Show loading state
    try {
      Response response = await Dio().get('https://fakestoreapi.com/products');

      List<ProductModel> products = (response.data as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();

      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError("Failed to load products"));
    }
  }
}
