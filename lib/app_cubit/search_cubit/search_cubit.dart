import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/app_cubit/search_cubit/search_states.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/network/end_point.dart';
import 'package:shop/network/remote/api/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitalState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {

    emit(SearchLoadingState());
    Dio_helper.postData(token: token, path: SEARCH, data: {'text': text})
        .then((value) {

          model=SearchModel.fromJson(value.data);
          emit(SearchSuccessState());

    })
        .catchError((error) {
          print(error.toString());
          emit(SearchErrorState());

    });
  }
}
