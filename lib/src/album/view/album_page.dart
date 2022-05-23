import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_cart/src/album/models/rm_album.dart';
import 'package:flutter_shopping_cart/src/photos/photos.dart';

import '../album.dart';

class AlbumPage extends StatefulWidget {
  final int? userId;

  const AlbumPage({Key? key, this.userId}) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  void initState() {
    context.read<AlbumBloc>().add(AlbumStarted(widget.userId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Album')),
      body: Column(
        children: [
          Expanded(
            child: AlbumList(),
          ),
        ],
      ),
    );
  }
}

class AlbumList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemNameStyle = Theme.of(context).textTheme.headline6;

    return BlocBuilder<AlbumBloc, AlbumState>(
      builder: (context, state) {
        if (state is AlbumLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AlbumLoaded) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.album.items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final item = state.album.items[index];
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

  final RMAlbum item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PhotosPage(
              userId: item.id,
            )));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.green.withOpacity(0.3),
        ),
        padding:const  EdgeInsets.all(16),
        child: Text(item.title ?? "body"),
      ),
    );
  }
}
