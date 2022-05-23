import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_cart/src/photos/models/rm_photos.dart';

import '../photos.dart';

class PhotosPage extends StatefulWidget {
  final int? userId;

  const PhotosPage({Key? key, this.userId}) : super(key: key);

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  @override
  void initState() {
    context.read<PhotosBloc>().add(PhotosStarted(widget.userId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photos')),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: PhotosList(),
            ),
          ),
        ],
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemNameStyle = Theme.of(context).textTheme.headline6;

    return BlocBuilder<PhotosBloc, PhotosState>(
      builder: (context, state) {
        if (state is PhotosLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is PhotosLoaded) {
          return GridView.builder(
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: state.photos.items.length,
            itemBuilder: (context, index) {
              final item = state.photos.items[index];
              return Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.hardEdge,
                child:ItemTile(
                  item: item,
                )
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

  final RMPhotos item;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: item.url??"",
      placeholder: (context, url) =>const Center(
        child:  SizedBox(
            height: 30,
            width: 30,
            child:  CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
