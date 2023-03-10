import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_app/cubit/cubit.dart';
import 'package:news/layout/news_app/cubit/states.dart';
import 'package:news/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextForm(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  label: 'Search',
                  prefix: Icons.search,
                  onTap: (){},
                  onSubmit: (value){},
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Search must be not empty';
                    }
                  },
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),

              Expanded(child: articleBuilder(list, context,isSearch: true) ),
            ],
          ),
        );
      },
    );
  }
}
