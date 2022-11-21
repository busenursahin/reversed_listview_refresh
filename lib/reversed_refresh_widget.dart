import 'package:flutter/material.dart';

class ReversedRefreshWidget extends StatefulWidget {
  ReversedRefreshWidget({Key? key, required this.child, this.onRefresh})
      : super(key: key);

  final ListView child;
  final Function? onRefresh;

  @override
  State<ReversedRefreshWidget> createState() => _ReversedRefreshWidgetState();
}

class _ReversedRefreshWidgetState extends State<ReversedRefreshWidget> {
  late final _scrollController; /* = ScrollController()..addListener(_onScroll); */
  
  var isLoading = false;

  @override
  void initState() {
    _scrollController = widget.child.controller!;
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.minScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= 0) {
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() => isLoading = true);
    }

    if (maxScroll - currentScroll == 0 && widget.onRefresh != null) {
      widget.onRefresh!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        isLoading ? ListLoadingWidget() : const SizedBox(),
      ],
    );
  }
}

class ListLoadingWidget extends StatelessWidget {
  const ListLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
