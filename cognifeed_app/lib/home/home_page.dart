import 'package:cached_network_image/cached_network_image.dart';
import 'package:cognifeed_app/articles/articles_bloc.dart';
import 'package:cognifeed_app/articles/articles_event.dart';
import 'package:cognifeed_app/articles/articles_model.dart';
import 'package:cognifeed_app/articles/articles_state.dart';
import 'package:cognifeed_app/widgets/application_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../constants/cognifeed_constants.dart';

class HomePage extends StatefulWidget {
  static const route = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<ArticlesBloc>(context).add(GetHomePageArticlesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationScaffold(
      child: BlocBuilder<ArticlesBloc, ArticlesState>(
          bloc: BlocProvider.of<ArticlesBloc>(context),
          builder: (BuildContext context, ArticlesState state) {
            if (state is ArticlesLoadedState) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: state.articlesModel.articles.length,
                itemBuilder: (BuildContext context, int index) {
                  return ArticleBox(
                      article: state.articlesModel.articles[index]);
                },
              );
            } else if (state is ArticlesErrorState) {
              return Container(
                child: Text(state.error),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class ArticleBox extends StatefulWidget {
  final Article article;

  const ArticleBox({Key key, @required this.article}) : super(key: key);

  @override
  _ArticleBoxState createState() => _ArticleBoxState();
}

class _ArticleBoxState extends State<ArticleBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.37),
            blurRadius: 4,
          )
        ],
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.article.title.trim(),
                      style: CognifeedTypography.articleTitle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.article.description,
                      style: CognifeedTypography.articleDescription,
                      maxLines: 7,
                    )
                  ],
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 100,
                    child: CachedNetworkImage(
                      imageUrl: widget.article.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    FontAwesome.globe,
                    size: 12,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Website",
                    style:
                        CognifeedTypography.textStyle2.copyWith(fontSize: 14),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "10",
                        style: CognifeedTypography.textStyle2
                            .copyWith(fontSize: 14, height: 1.1),
                      ),
                      Text(
                        "views",
                        style: CognifeedTypography.textStyle2
                            .copyWith(fontSize: 14, height: 1.1),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.article.isFav = !widget.article.isFav;
                      });
                    },
                    child: Icon(
                      widget.article.isFav
                          ? FontAwesome.heart
                          : FontAwesome.heart_o,
                      color: widget.article.isFav ? Colors.red : Colors.black,
                      // size: 18,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      showCustomBottomSheet(context,
                          backgroundColor: Colors.grey[100],
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 18),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200],
                                              width: 2))),
                                  child: Row(
                                    children: <Widget>[
                                      Text("Operating System"),
                                      Container(
                                        height: 10,
                                        width: 15,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      CustomListTile(
                                        icon: Icons.share,
                                        label: "Share",
                                        onPressed: () {},
                                      ),
                                      CustomListTile(
                                        icon: Icons.highlight_off,
                                        label: "Hide this article",
                                        onPressed: () {},
                                      ),
                                      CustomListTile(
                                        icon: FontAwesome.magic,
                                        label: "Manage Interests",
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text('Close'),
                                )
                              ],
                            ),
                          ));
                    },
                    child: Icon(
                      Icons.more_vert,
                      // size: 18,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

void showCustomBottomSheet(BuildContext context,
    {Widget child,
    Function callOnThen,
    Color backgroundColor = Colors.white,
    double bottomPadding = 32,
    Color barColor = const Color(0XFFeeedee)}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[child],
          ),
        );
      }).then((_) {
    if (callOnThen != null) callOnThen();
  });
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const CustomListTile({Key key, this.icon, this.label, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: <Widget>[
            Icon(icon),
            SizedBox(
              width: 14,
            ),
            Text(label)
          ],
        ),
      ),
    );
  }
}
