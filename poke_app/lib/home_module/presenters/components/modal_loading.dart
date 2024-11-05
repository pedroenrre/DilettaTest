import 'package:flutter/material.dart';

class ModalLoading extends StatelessWidget {
  final bool showModalLoading;
  const ModalLoading({
    super.key,
    required this.showModalLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (showModalLoading) {
      return Stack(
        children: [
          ModalBarrier(
            color: Colors.black.withOpacity(0.5),
            dismissible: false,
          ),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      );
    }
    return const SizedBox();
  }
}
