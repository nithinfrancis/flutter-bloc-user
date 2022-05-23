import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_cart/src/album/album.dart';
import 'package:flutter_shopping_cart/src/post/post.dart';
import 'package:flutter_shopping_cart/src/user/bloc/user_state.dart';
import 'package:flutter_shopping_cart/src/user/models/rm_user.dart';

import '../user.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          UserAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is UserLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => ItemTile(
                      item: state.catalog.userList[index],
                    ),
                    childCount: state.catalog.userList.length,
                  ),
                );
              }
              return const SliverFillRemaining(
                child: Text('Something went wrong!'),
              );
            },
          ),
        ],
      ),
    );
  }
}

class UserAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('User'),
      floating: true,
    );
  }
}

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final RMUser item;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.cyanAccent.withOpacity(0.3),
        ),
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.name ?? "name",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(item.company?.name ?? "company name"),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostPage(userId: item.id,)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.black54,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Post",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AlbumPage(
                            userId: item.id,
                          )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_to_photos_outlined,
                            color: Colors.black54,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Album",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),

      // ListTile(
      //   leading: Text('#${item.id}'),
      //   title: Text(item.name??"name"),
      //   subtitle: Text(item.company?.name??"company name"),
      //   // trailing: item.isDeleting
      //   //     ? const CircularProgressIndicator()
      //   //     : IconButton(
      //   //         icon: const Icon(Icons.delete, color: Colors.red),
      //   //         onPressed: () => onDeletePressed(item.id),
      //   //       ),
      // ),
    );
  }
}

class UserListItem extends StatelessWidget {
  const UserListItem(this.item, {Key? key}) : super(key: key);

  final RMUser item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.headline6;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            const SizedBox(width: 24),
            Expanded(child: Text(item.name ?? "", style: textTheme)),
            const SizedBox(width: 24),
            // AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
