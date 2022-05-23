import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_cart/src/comments/models/rm_comment.dart';

import '../comments.dart';

class CommentsPage extends StatelessWidget {


  const CommentsPage({Key? key, this.postId}) : super(key: key);

  final int? postId;


  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {
        if (state is CommentsLoaded ||(CommentsLoaded.commentMap[postId!]!=null)) {
          return ListView.builder(
            shrinkWrap: true,
            physics:const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => ItemTile(
              item: CommentsLoaded.commentMap[postId!]!.commentList[index],
            ),
            itemCount: CommentsLoaded.commentMap[postId!]!.commentList.take(3).length,
          );
        }

        if (state is CommentsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Text('Something went wrong!');
      },
    );
  }
}

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final RMComment item;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.cyanAccent.withOpacity(0.3),
        ),
        padding: const EdgeInsets.all(8),
        child: Text(item.body ?? "company name"),
      ),
    );
  }
}