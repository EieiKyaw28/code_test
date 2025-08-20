import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sky_cast_weather/common/app_theme.dart';

import 'package:sky_cast_weather/common/common_text_field.dart';
import 'package:sky_cast_weather/common/extension.dart';

class CommonTypeAhead<T> extends StatefulWidget {
  const CommonTypeAhead({
    super.key,
    this.label,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.suffix,
    this.floatingLabelStyle = const TextStyle(color: Colors.red),
    required this.itemBuilder,
    required this.suggestionsCallback,
    required this.onSuggestionSelected,
    this.controller,
    this.onTap,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.textStyle,
    this.enabled = true,
    this.width = 300,
    this.onSubmitted,
    this.title,
    this.titleColor,
    this.errorBuilder,
    this.initalValue,
    this.dropdownIcon = true,
    this.inputFormatters,
    this.throwError = false,
    this.iconColor,
    this.borderColor,
    this.minimumCharacterForSuggestion = 2,
    this.onClear,
    this.fillColor,
    this.focusNode,
    this.suggestionController,
  });

  final Widget? label;
  final String? hintText;
  final String? initalValue;

  final Widget? prefix;
  final Widget? suffix;

  final TextStyle? floatingLabelStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;

  final TextEditingController? controller;

  final GestureTapCallback? onTap;
  final Function(String)? onChanged;
  final TextInputAction textInputAction;
  final Widget Function(BuildContext, T) itemBuilder;
  final Widget Function(BuildContext, Object?)? errorBuilder;
  final FutureOr<Iterable<T>?> Function(String) suggestionsCallback;
  final Function(T) onSuggestionSelected;
  final String? Function(String?)? validator;
  final bool enabled;
  final double width;
  final void Function(String)? onSubmitted;
  final String? title;
  final Color? titleColor;
  final bool dropdownIcon;
  final bool throwError;
  final List<TextInputFormatter>? inputFormatters;
  final Color? borderColor;
  final Color? iconColor;
  final int minimumCharacterForSuggestion;
  final void Function()? onClear;
  final Color? fillColor;
  final FocusNode? focusNode;
  final SuggestionsController<T>? suggestionController;

  @override
  State<CommonTypeAhead<T>> createState() => _CommonTypeAheadState<T>();
}

class _CommonTypeAheadState<T> extends State<CommonTypeAhead<T>> {
  late final SuggestionsController<T> suggestionController;

  @override
  void initState() {
    super.initState();
    suggestionController =
        widget.suggestionController ?? SuggestionsController<T>();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 50,
      width: widget.width,
      child: TypeAheadField<T>(
        focusNode: widget.focusNode,
        controller: widget.controller,
        suggestionsController: suggestionController,
        suggestionsCallback: (search) async {
          final data = await widget.suggestionsCallback(search);

          if (data is Iterable<T>) {
            return data.toList();
          } else {
            return data;
          }
        },
        itemSeparatorBuilder: (context, index) =>
            const Divider(color: Colors.black, thickness: .5),
        builder: (context, controller, focusNode) {
          return CommonTextField(
            hintText: widget.hintText,
            controller: controller,
            focusNode: focusNode,
            autofocus: false,
            label: widget.label,
            inputFormatters: widget.inputFormatters,
            filledColor: widget.fillColor ?? Colors.white,
            textInputAction: widget.textInputAction,
            onChanged: (value) => widget.onChanged?.call(value),
            onTap: widget.onTap,
            onSubmitted: (value) => widget.onSubmitted?.call(value),
            validator: widget.validator,
            prefix: widget.prefix,
            suffix: widget.suffix == null
                ? null
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.onClear == null
                          ? const SizedBox()
                          : IconButton(
                              onPressed: widget.onClear,
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                color: Colors.red,
                              ),
                            ),
                      5.hGap,
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        color: widget.iconColor ?? Colors.black,
                        size: 40,
                      ),
                      5.hGap,
                    ],
                  ),
          );
        },
        loadingBuilder: (_) => LinearProgressIndicator(
          color: AppTheme.purpleShade1,
          borderRadius: BorderRadius.circular(5),
        ),
        decorationBuilder: (context, child) => DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0),
          ),
          child: child,
        ),
        itemBuilder: widget.itemBuilder,
        onSelected: (data) {
          suggestionController.close();

          widget.onSuggestionSelected(data);
        },
      ),
    );
  }
}
