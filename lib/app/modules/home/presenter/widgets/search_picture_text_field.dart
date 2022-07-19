import 'package:flutter/material.dart';

class SearchPictureTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchPictureTextField({
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: 'Search',
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
          ),
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(
            Icons.search,
            size: 21,
          ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
