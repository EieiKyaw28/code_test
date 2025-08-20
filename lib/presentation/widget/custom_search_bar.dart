import 'package:flutter/material.dart';
import 'package:sky_cast_weather/service/responsive_service.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final TextEditingController controller;
  final VoidCallback? onSearch;

  const CustomSearchBar({
    super.key,
    this.hintText = "Search...",
    this.onChanged,
    this.onClear,
    required this.controller,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return isDesktop
        ? Row(
            children: [
              TextField(
                controller: controller,
                onChanged: onChanged,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                  border: InputBorder.none,
                ),
                cursorColor: Colors.white,
              ),
              const SizedBox(width: 10),
              ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, value, child) {
                  return value.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            onSearch?.call();
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 26,
                          ))
                      : const SizedBox();
                },
              )
            ],
          )
        : Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, value, child) {
                  return value.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            onSearch?.call();
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 26,
                          ))
                      : const SizedBox();
                },
              )
            ],
          );
  }
}
