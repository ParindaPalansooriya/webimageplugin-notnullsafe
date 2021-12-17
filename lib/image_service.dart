import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:path_provider/path_provider.dart';

Widget WebImage(String url,{
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
  File file;
  bool isFirst = true;
  ImageServices service = ImageServices();
  Future loadFile(url,setState)async{
    file = await service.getImage(url);
    setState((){});
  }
  return StatefulBuilder(builder: (context, setState) {
    double size = width!=null && height!=null?width<height?width:height:null;
    if(isFirst) {
      loadFile(url, setState);
      isFirst =false;
    }
    if(file==null){
      return SizedBox(width: width,height: height,child: SizedBox(width: size,height: size,child: Center(
        child: LoadingIndicator(
            indicatorType: Indicator.ballScale,
            colors: const [Colors.grey],
            // strokeWidth: 2,
            // backgroundColor: Colors.transparent,
            // pathBackgroundColor: Colors.transparent
        ),
      )));
    }else{
      return Image.file(file,
        color: color,
        fit: fit,
        height: height,
        width: width,
        key: key,
        alignment: alignment,
        errorBuilder:errorBuilder??(BuildContext context, Object error, StackTrace stackTrace,){
          if(file.existsSync()){
            file.delete();
          }
          return SizedBox(width: size,height: size,child: const Icon(Icons.error,color: Colors.grey));
        },
        centerSlice: centerSlice,
          frameBuilder:frameBuilder,
          scale:scale,
          semanticLabel:semanticLabel,
          excludeFromSemantics:excludeFromSemantics,
          opacity:opacity,
          colorBlendMode:colorBlendMode,
          repeat:repeat,
          matchTextDirection:matchTextDirection,
          gaplessPlayback:gaplessPlayback,
          isAntiAlias:isAntiAlias,
          filterQuality:filterQuality,
          cacheWidth:cacheWidth,
          cacheHeight:cacheHeight
      );
    }
  },);

}

class ImageServices{

  static Directory tempDir;

  Future<File> getImage(String url) async {
    if(url!=null) {
      tempDir ??= await getTemporaryDirectory();
      var tempDirFin = Directory(tempDir.path+"/images/");
      if(!(await tempDirFin.exists())){
        await tempDirFin.create(recursive: true);
      }
      String imageImage = url.split("//").last.replaceAll("/", "_").replaceFirst(".", "");
      String folder = tempDir.path+"/images/";
      String fullPath = folder + imageImage;
      try {
        File file = File(fullPath);
        if (await file.exists()) {
        } else {
          await _download2(url, fullPath);
          file = File(fullPath);
        }
        return file;
      } catch (e) {
        File file = File(fullPath);
        if(file.existsSync()){
          file.delete();
        }
        throw Exception("WebImage Error >>>>> "+e.toString());
      }
    }
    throw Exception("WebImage Error >>>>> no url");
  }

   Future _download2(String url, String savePath) async {
    try {
      Response response = await Dio().get(
        url,
        onReceiveProgress: _showDownloadProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return (status??0) < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      File file = File(savePath);
      if(file.existsSync()){
        file.delete();
      }
      throw Exception("WebImage Error >>>>> "+e.toString());
    }
  }

   void _showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
}
