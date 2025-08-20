import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sky_cast_weather/common/app_theme.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    this.title,
    this.controller,
    this.isError,
    this.errorText,
    this.maxLines = 1,
    this.height = 60,
    this.width = 250,
    this.isDense = true,
    this.suffix,
    this.hintText,
    this.prefix,
    this.textInputType,
    this.inputFormatters,
    this.onChanged,
    this.inactiveBorderColor = Colors.grey,
    this.filledColor,
    this.onTap,
    this.onSubmitted,
    this.titleFontSize,
    this.labelColor = AppTheme.purpleShade2,
    this.focusColor = AppTheme.purpleShade2,
    this.titleColor = AppTheme.purpleShade2,
    this.cursorColor = AppTheme.purpleShade2,
    this.labelStyle,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.autofocus = false,
    this.keyboardType,
    this.hintStyle,
    this.borderRadius,
    this.style,
    this.hasBorder = true,
    this.textAlign = TextAlign.start,
    this.initialValue,
    this.focusNode,
    this.borderColor,
    this.borderThickness,
    this.autovalidateMode,
    this.errorMaxLines,
    this.isCollapsed = false,
    this.contentPadding,
    this.label,
  });
  final String? title;
  final TextEditingController? controller;
  final bool? isError;
  final String? errorText;
  final TextStyle? style;
  final int? maxLines;
  final double? height;
  final double? width;
  final bool isDense;
  final Widget? suffix;
  final String? hintText;
  final Widget? prefix;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final Color inactiveBorderColor;
  final Color? filledColor;
  final GestureTapCallback? onTap;
  final Function(String)? onSubmitted;
  final Widget? label;
  final Color? labelColor;

  final double? titleFontSize;
  final Color titleColor;
  final Color focusColor;
  final Color cursorColor;
  final TextStyle? labelStyle;
  final String? Function(String)? validator;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;

  final BorderRadius? borderRadius;
  final bool hasBorder;
  final TextAlign textAlign;
  final String? initialValue;
  final FocusNode? focusNode;
  final Color? borderColor;
  final double? borderThickness;
  final int? errorMaxLines;
  final bool isCollapsed;
  final EdgeInsetsGeometry? contentPadding;
  final AutovalidateMode? autovalidateMode;
  @override
  Widget build(BuildContext context) {
    // Bool isDesktop = ResponsiveWrapper.of(context).isLargerThan(TABLET);.
    return SizedBox(
      // height: 100,
      width: width ?? 250,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  if (title != null)
            // SizedBox(
            //   height: 25,
            //   child: Text(title ?? "", style: TextStyle(fontSize: 16)),
            // ),
            SizedBox(
              //  height: 100,
              child: TextFormField(
                controller: controller,
                initialValue: initialValue,
                focusNode: focusNode,
                decoration: InputDecoration(
                  label: label,
                  floatingLabelStyle: TextStyle(color: labelColor),
                  hintText: hintText,
                  hintStyle:
                      hintStyle ?? TextStyle(fontSize: 14, color: Colors.grey),
                  errorText: (isError ?? false) ? errorText : null,
                  errorMaxLines: errorMaxLines,
                  isCollapsed: isCollapsed,
                  isDense: isDense,
                  contentPadding: contentPadding ??
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  prefixIcon: prefix,
                  suffixIcon: suffix,
                  suffixIconConstraints: const BoxConstraints(
                    minHeight: 19,
                    minWidth: 19,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minHeight: 24,
                    minWidth: 24,
                  ),
                  filled: true,
                  fillColor: filledColor ?? Colors.white,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor ?? AppTheme.purpleShade2,
                      width: borderThickness ?? 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    gapPadding: 0.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor ?? focusColor,
                      width: borderThickness ?? 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    gapPadding: 0.0,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: hasBorder
                        ? BorderSide(
                            color: borderColor ?? inactiveBorderColor,
                            width: borderThickness ?? 1,
                          )
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                    gapPadding: 0.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: hasBorder
                        ? BorderSide(
                            color: borderColor ?? inactiveBorderColor,
                            width: borderThickness ?? 1,
                          )
                        : BorderSide.none,
                    borderRadius: borderRadius ?? BorderRadius.circular(5),
                    gapPadding: 0.0,
                  ),
                  border: OutlineInputBorder(
                    borderSide: hasBorder
                        ? BorderSide(
                            color: borderColor ?? inactiveBorderColor,
                            width: borderThickness ?? 1,
                          )
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                    gapPadding: 0.0,
                  ),
                  alignLabelWithHint: true,
                ),
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                style: style,
                textAlign: textAlign,
                autofocus: autofocus,
                showCursor: true,
                maxLines: maxLines,
                onChanged: onChanged,
                onTap: onTap,
                onFieldSubmitted: onSubmitted,
                validator: (str) => validator?.call(str!),
                inputFormatters: inputFormatters,
                cursorColor: cursorColor,
                autovalidateMode: autovalidateMode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
