import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragUpdate: _handleVerticalDrag,
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  final path = widget.images[index];
                  return Center(
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Image.asset(path, fit: BoxFit.cover),
                    ),
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                physics: const BouncingScrollPhysics(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '${_currentIndex + 1}/${widget.images.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                left: 0,
                child: BackButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}