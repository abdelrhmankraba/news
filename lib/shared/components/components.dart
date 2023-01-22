import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news/modules/web_view/web_view_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 0.0,
  bool isUpperCase = true,
  required String text,
  required Function function,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextForm({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String label,
  bool formEnable = true,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPress,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  required Function validate,
  bool isPassword = false,
}) =>
    TextFormField(
      obscureText: isPassword,
      enabled: formEnable,
      controller: controller,
      keyboardType: keyboardType,
      onTap: () {
        onTap!();
      },
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      onChanged: (value) {
        onChange!(value);
      },
      validator: (s) {
        return validate(s);
      },
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null ? IconButton(
                onPressed: () {
                  suffixPress!();
                },
                icon: Icon(
                  suffix,
                ),
              ) : null,
      ),
    );

Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(

        padding: const EdgeInsets.all(20.0),

        child: Row(

          children: [

            Container(

              height: 120.0,

              width: 120.0,

              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(15.0),

                image: DecorationImage(

                  image: NetworkImage('${article['urlToImage']}'),

                  fit: BoxFit.cover,

                ),

              ),

            ),
            const SizedBox(

              width: 20.0,

            ),
            Expanded(

              child: Container(

                height: 120.0,

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Expanded(

                      child: Text(

                        '${article['title']}',

                        style: Theme.of(context).textTheme.headline6,

                        maxLines: 3,

                        overflow: TextOverflow.ellipsis,

                      ),

                    ),

                    Text(

                      '${article['publishedAt']}',

                      style: const TextStyle(

                        color: Colors.grey,

                      ),

                    ),

                  ],

                ),

              ),

            ),

          ],

        ),

      ),
);

Widget articleBuilder(list, context,{isSearch = false}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: ((context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 20.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            )),
        itemCount: list.length,
      ),
      fallback: (context) => isSearch ? Container(): const Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
