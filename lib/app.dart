import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_cart/shopping_repository.dart';

import 'src/album/bloc/album_bloc.dart';
import 'src/comments/comments.dart';
import 'src/photos/photos.dart';
import 'src/post/post.dart';
import 'src/user/bloc/user_event.dart';
import 'src/user/user.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.shoppingRepository}) : super(key: key);

  final ShoppingRepository shoppingRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserBloc()..add(UserStarted()),
        ),
        BlocProvider(
          create: (_) => PostBloc(),
        ),
        BlocProvider(
          create: (_) => CommentsBloc(
          ),
        ),
        BlocProvider(
          create: (_) => AlbumBloc(
          ),
        ),
        BlocProvider(
          create: (_) => PhotosBloc(
          ),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Bloc Shopping Cart',
        initialRoute: '/',
        routes: {
          '/': (_) => UserPage(),
          '/post': (_) => PostPage(),
        },
      ),
    );
  }
}
