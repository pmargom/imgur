import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imgur/domain/entitites/gallery_entity.dart';
import 'package:imgur/presentation/cubits/home/galleries_cubit.dart';
import 'package:imgur/presentation/widgets/custom_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logging/logging.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _pageNum;
  late ScrollController _scrollController;

  static final Logger _logger = Logger("Home Screen");
  static const String _query = "cars";

  @override
  void initState() {
    super.initState();
    _pageNum = 1;
    _scrollController = ScrollController();
    _setUpScrollEvents();
    _loadData(_query, _pageNum);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _setUpScrollEvents() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        _logger.info("End of result set...");
        _pageNum++;
        _loadData(_query, _pageNum);
      }
    });
  }

  void _loadData(String query, int page) {
    BlocProvider.of<GalleriesCubit>(context).getGalleries(query, page: page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Imgur Gallery List")),
      body: _buildMainContent(),
    );
  }

  Widget _buildMainContent() => Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: _buildConsumer()),
            ],
          ),
        ),
      );

  Widget _buildConsumer() {
    return BlocConsumer<GalleriesCubit, GalleriesState>(
      listener: (context, state) {},
      builder: (_, state) {
        if (state is GalleriesLoading && state.isFirstFetch) {
          return const CircularProgressIndicator.adaptive();
        }

        if (state is GalleriesError) {
          return Text("Error -> ${state.message}");
        }

        List<GalleryEntity> galleries = [];
        bool isLoading = false;

        if (state is GalleriesLoading) {
          galleries = state.oldGalleries;
          isLoading = true;
        } else if (state is GalleriesLoaded) {
          galleries = state.galleries;
          _pageNum = state.page;

          if (galleries.isEmpty) {
            return const Text("No data found");
          }
        }
        return _buildGalleryList(galleries, isLoading);

        // return const SizedBox();
      },
    );
  }

  Widget _buildGalleryList(List<GalleryEntity> galleries, bool isLoading) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: galleries.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < galleries.length) {
          final GalleryEntity galleryEntity = galleries[index];
          return Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: ListTile(
              title: _buildItemTitle(galleryEntity),
              subtitle: Text(galleryEntity.description ?? "No description"),
              trailing: const Icon(Icons.chevron_right_outlined),
              onTap: () => _onSelectedItem(galleryEntity),
            ),
          );
        } else {
          return _showLoadingMoreIndicator();
        }
      },
    );
  }

  Widget _showLoadingMoreIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.red,
          size: 50,
        ),
      ),
    );
  }

  void _onSelectedItem(GalleryEntity gallery) {
    _logger.info("Gallery with id: ${gallery.id} selected");
  }

  Widget _buildItemTitle(GalleryEntity galleryEntity) {
    final String? firstImageUrl = galleryEntity.images.isEmpty ? null : galleryEntity.images.first.link;
    return Wrap(
      children: [
        Text(galleryEntity.title ?? "No title"),
        if (firstImageUrl != null)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: double.maxFinite,
            height: 200,
            child: CustomNetworkImage(firstImageUrl: firstImageUrl),
          )
      ],
    );
  }
}
