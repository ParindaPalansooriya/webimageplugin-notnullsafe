
import 'package:flutter/material.dart';

import 'image_service.dart';

Widget WebImagePluginPry(String url,{
  Key key,
  double scale = 1.0,
  ImageFrameBuilder frameBuilder,
  ImageErrorWidgetBuilder errorBuilder,
  String semanticLabel,
  bool excludeFromSemantics = false,
  double width,
  double height,
  Color  color,
  Animation<double> opacity,
  BlendMode colorBlendMode,
  BoxFit fit = BoxFit.contain,
  Alignment alignment = Alignment.center,
  ImageRepeat repeat = ImageRepeat.noRepeat,
  Rect centerSlice,
  bool matchTextDirection = false,
  bool gaplessPlayback = false,
  bool isAntiAlias = false,
  FilterQuality filterQuality = FilterQuality.low,
  int cacheWidth,
  int cacheHeight,
}){
  return WebImage(url,
      key: key,
      fit: fit,
      height: height,
      width: width,
      color: color,
      alignment: alignment,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      centerSlice: centerSlice,
      colorBlendMode: colorBlendMode,
      errorBuilder: errorBuilder,
      excludeFromSemantics: excludeFromSemantics,
      filterQuality: filterQuality,
      frameBuilder: frameBuilder,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      matchTextDirection: matchTextDirection,
      opacity: opacity,
      repeat: repeat,
      scale: scale,
      semanticLabel: semanticLabel
  );
}
