import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Layout/components.dart';
import 'package:shop/app_cubit/search_cubit/search_cubit.dart';

import '../../app_cubit/search_cubit/search_states.dart';

class Search_screen extends StatelessWidget {
  var textController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
            listener: (context, state) {},
            builder: (context, state) => Scaffold(
                appBar: AppBar(
                  title: Text('Search'),
                ),
                body: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        defaultFormField(
                            type: TextInputType.text,
                            onSubmitted: (String text) { SearchCubit.get(context)
                                .search(textController.text);

                            },
                            c: textController,
                            labeltext: 'Search',
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'enter word to search';
                              } else {
                                return null;
                              }
                            }),
                        if (state is SearchLoadingState)
                          LinearProgressIndicator(),
                        SizedBox(
                          height: 15.0,
                        ),
                          if(SearchCubit.get(context).model!=null)
                          Expanded(
                            child: ConditionalBuilder(
                              condition: state is !SearchLoadingState,
                              builder: (context) => ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildProductItem(
                                          SearchCubit.get(context)
                                              .model!
                                              .data!
                                              .data![index],
                                          context),
                                  separatorBuilder: (context, index) =>
                                      myDivider(),
                                  itemCount: SearchCubit.get(context)
                                      .model!
                                      .data!
                                      .data!
                                      .length),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            ),
                          ),
                      ],
                    ),
                  ),
                ))));
  }
}
