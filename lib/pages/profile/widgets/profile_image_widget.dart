import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ProfileImageWidget extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const ProfileImageWidget({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _handleVerticalDrag(DragUpdateDetails details) {
    if (details.primaryDelta != null && details.primaryDelta! > 12) {
      Navigator.of(context).pop();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _handleVerticalDrag,
      onTapUp: _handleTapUp,
      child: Scaffold(
        body: PhotoViewGallery.builder(
          pageController: _pageController,
          itemCount: widget.images.length,
          builder: (context, index) {
            final url = widget.images[index];
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(url),
              heroAttributes: PhotoViewHeroAttributes(tag: url),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            );
          },
          onPageChanged: (index) => setState(() {
            _currentIndex = index;
          }),
          backgroundDecoration:  BoxDecoration(color: Colors.black),
          scrollPhysics: const BouncingScrollPhysics(),
          loadingBuilder: (context, _) => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
