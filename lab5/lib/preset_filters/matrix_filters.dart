import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/utils/convolution_kernels.dart';
import 'package:photofilters/filters/image_filters.dart';
import 'package:photofilters/filters/subfilters.dart';

ConvolutionKernel sharpenKernel =
    new ConvolutionKernel([-1, -1, -1, -1, 9, -1, -1, -1, -1]);
ConvolutionKernel sobelKernel =
    new ConvolutionKernel([0, 1, 0, 1, -4, 1, 0, 1, 0]);

ConvolutionKernel blurKernel = new ConvolutionKernel([
  0,
  0,
  1,
  0,
  0,
  0,
  1,
  1,
  1,
  0,
  1,
  1,
  1,
  1,
  1,
  0,
  1,
  1,
  1,
  0,
  0,
  0,
  1,
  0,
  0
]);

ConvolutionKernel medianKernel = new ConvolutionKernel([
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
]);

ConvolutionKernel erosionKernel = new ConvolutionKernel([
  1,
  2,
  1,
  2,
  4,
  2,
  1,
  2,
  1,
]);

ConvolutionKernel dilationKernel =
    new ConvolutionKernel([0, -0.25, 0, -0.25, 2, -0.25, 0, -0.25, 0]);

List<Filter> myConvolutionFilters = [
  ImageFilter(name: "Blur")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(blurKernel)),
  ImageFilter(name: "Sharpen")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(sharpenKernel)),
  ImageFilter(name: "Median")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(medianKernel)),
  ImageFilter(name: "Sobel")
    ..subFilters.add(ConvolutionSubFilter.fromKernel(sobelKernel)),
  ImageFilter(name: "Erosion")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(erosionKernel)),
  ImageFilter(name: "Dilation")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(dilationKernel)),
];
