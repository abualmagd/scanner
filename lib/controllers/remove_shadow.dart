import 'package:flutter/material.dart';
import 'package:opencv_4/opencv_4.dart';
import 'dart:io';

class ImageEdit {

  removeShadow(File file) async {
    //path
    var path = file.path;

/*
    //blur image
    var img = await Cv2.blur(pathString: path,
        kernelSize: [45, 45],
        anchorPoint: [20, 30],
        borderType: Cv2.BORDER_DEFAULT);

    //th1 cv threshold
    var th1 = await Cv2.threshold(pathString: path,
        thresholdValue: 127,
        maxThresholdValue: 255,
        thresholdType: Cv2.THRESH_BINARY);
    //adaptive threshold
    var th2 = await Cv2.adaptiveThreshold(pathString: path,
        maxValue: 255,
        adaptiveMethod: Cv2.ADAPTIVE_THRESH_MEAN_C,
        thresholdType: Cv2.THRESH_BINARY,
        blockSize: 11,
        constantValue: 2);
*/
    //th3 the best to remove image remove
    var th3 = await Cv2.adaptiveThreshold(pathString: path,
        maxValue: 255,
        adaptiveMethod: Cv2.ADAPTIVE_THRESH_GAUSSIAN_C,
        thresholdType: Cv2.THRESH_BINARY,
        blockSize: 11,
        constantValue: 2);
  }

  otsuRemoveShadow(File file) async{
    var path = file.path;


    var blur =await Cv2.gaussianBlur(
        pathString: path, kernelSize: [5.0, 5.0], sigmaX: 0);

  var  blurFile=File.fromRawPath(blur!);

    var otsu = Cv2.threshold(pathString:blurFile.path,
        thresholdValue:0,
        maxThresholdValue:255,
        thresholdType:Cv2.THRESH_BINARY+Cv2.THRESH_OTSU);
  }

}