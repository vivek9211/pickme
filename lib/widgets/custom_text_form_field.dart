import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    this.shape,
    this.padding,
    this.variant,
    this.fontStyle,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    this.focusNode,
    this.isObscureText = false,
    this.textInputAction = TextInputAction.next,
    this.maxLines,
    this.hintText,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.validator,
  });

  final TextFormFieldShape? shape;
  final TextFormFieldPadding? padding;
  final TextFormFieldVariant? variant;
  final TextFormFieldFontStyle? fontStyle;
  final Alignment? alignment;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? isObscureText;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final String? hintText;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment!,
      child: _buildTextFormFieldWidget(),
    )
        : _buildTextFormFieldWidget();
  }

  Widget _buildTextFormFieldWidget() {
    return Container(
      width: width,
      margin: margin,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        style: _setFontStyle(),
        obscureText: isObscureText!,
        textInputAction: textInputAction!,
        maxLines: maxLines ?? 1,
        decoration: _buildDecoration(),
        validator: validator,
      ),
    );
  }

  InputDecoration _buildDecoration() {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: _setHintStyle(),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      filled: _setFilled(),
      fillColor: _setFillColor(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  TextStyle _setHintStyle() {
    return TextStyle(
      color: Colors.grey, // Light gray color for the hintText
    );
  }

  TextStyle _setFontStyle() {
    switch (fontStyle) {
      default:
        return TextStyle(
          color: Colors.black, // Default text color
          fontSize: 16, // Default font size
          fontFamily: 'SF UI Display', // Default font family
          fontWeight: FontWeight.w400, // Default font weight
        );
    }
  }

  OutlineInputBorder _setBorderStyle() {
    switch (variant) {
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
    }
  }

  BorderRadius _setOutlineBorderRadius() {
    switch (shape) {
      default:
        return BorderRadius.circular(14);
    }
  }

  Color _setFillColor() {
    switch (variant) {
      default:
        return Colors.grey[100]!; // Fill color for the TextFormField
    }
  }

  bool _setFilled() {
    switch (variant) {
      default:
        return true; // Fill the TextFormField with color
    }
  }

  EdgeInsetsGeometry _setPadding() {
    switch (padding) {
      case TextFormFieldPadding.PaddingAll14:
        return EdgeInsets.all(14);
      default:
        return EdgeInsets.all(18);
    }
  }
}

enum TextFormFieldShape {
  RoundedBorder14,
}

enum TextFormFieldPadding {
  PaddingAll18,
  PaddingAll14,
}

enum TextFormFieldVariant {
  FillGray100,
}

enum TextFormFieldFontStyle {
  SFUIDisplayRegular16,
}
