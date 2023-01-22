// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_app/cubit/states.dart';
import 'package:news/modules/business/business_screen.dart';
import 'package:news/modules/science/science_screen.dart';
import 'package:news/modules/sports/sports_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';
class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = const[
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];
  List<Widget> screens =const[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  void changeBottomBar(int index){
    currentIndex = index;
    if(index == 1)getSports();
    if(index == 2)getScience();
    emit(NewsBottomNavState());
  }
  List<dynamic> business =[];
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'d0a014e1b1e4496eb5ba029aaccaea9f',
      },
    ).then((value){
      //print(value.data['totalResults'].toString());
      business = value.data['articles'];
      print(business[0]['title']);
      for (var element in business) {
        if(element['urlToImage']==null){
          element['urlToImage'] = 'https://image.shutterstock.com/image-vector/caution-exclamation-mark-white-red-600w-1055269061.jpg';
        }
      }
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }
  List<dynamic> sports =[];
  void getSports(){
    emit(NewsGetSportsLoadingState());
    if(sports.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'d0a014e1b1e4496eb5ba029aaccaea9f',
        },
      ).then((value){
        //print(value.data['totalResults'].toString());
        sports = value.data['articles'];
        print(sports[0]['title']);
        for (var element in sports) {
          if(element['urlToImage']==null){
            element['urlToImage'] = 'https://image.shutterstock.com/image-vector/caution-exclamation-mark-white-red-600w-1055269061.jpg';
          }
        }
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }

  }
  List<dynamic> science =[];
  void getScience(){
    emit(NewsGetScienceLoadingState());
    if(science.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'d0a014e1b1e4496eb5ba029aaccaea9f',
        },
      ).then((value){
        //print(value.data['totalResults'].toString());
        science = value.data['articles'];
        print(science[0]['title']);
        for (var element in science) {
          if(element['urlToImage']==null){
            element['urlToImage'] = 'https://image.shutterstock.com/image-vector/caution-exclamation-mark-white-red-600w-1055269061.jpg';
          }
        }
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }

  }
  List<dynamic> search =[];

  void getSearch(String value){
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':value,
        'apiKey':'d0a014e1b1e4496eb5ba029aaccaea9f',
      },
    ).then((value){
      //print(value.data['totalResults'].toString());
      search = value.data['articles'];
      //print(search[0]['title']);
      for (var element in search) {
        if(element['urlToImage']==null){
          element['urlToImage'] = 'https://image.shutterstock.com/image-vector/caution-exclamation-mark-white-red-600w-1055269061.jpg';
        }
      }
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });

  }
}


//apiKeyAbdallahMansour=65f7f556ec76449fa7dc7c0069f040ca