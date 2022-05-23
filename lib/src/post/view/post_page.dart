import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_cart/src/comments/comments.dart';
import 'package:flutter_shopping_cart/src/post/models/rm_post.dart';

import '../post.dart';
import '../post.dart';

class PostPage extends StatefulWidget {
  final int? userId;

  const PostPage({Key? key, this.userId}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    context.read<PostBloc>().add(PostStarted(widget.userId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post')),
      body: Column(
        children: [
          Expanded(
            child: PostList(),
          ),
        ],
      ),
    );
  }
}

class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is PostLoaded) {
          return ListView.separated(
            padding:const EdgeInsets.all(16),
            itemCount: state.cart.items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final item = state.cart.items[index];
              return ItemTile(
                item: item,
              );
            },
          );
        }
        return const Text('Something went wrong!');
      },
    );
  }
}

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final RMPost item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.cyanAccent.withOpacity(0.3),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.title ?? "name",
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(item.body ?? "body"),
          const SizedBox(
            height: 8,
          ),
          ExpansionTile(
            title:const Text("Comments"),
            children: [
              CommentsPage(postId: item.id,),
            ],
            onExpansionChanged: (value) {
              if(value){
                context.read<CommentsBloc>().add(CommentsStarted(item.id!));
              }
              print("Value ${item.id}");
            },
          ),
        ],
      ),
    );
  }
}
