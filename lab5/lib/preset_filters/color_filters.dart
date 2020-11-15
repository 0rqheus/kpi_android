import 'package:photofilters/filters/color_filters.dart';
import 'package:photofilters/filters/subfilters.dart';
import 'package:photofilters/filters/filters.dart';

class InversFilter extends ColorFilter {
  InversFilter() : super(name: "Invers") {
    subFilters.add(new InvertSubFilter());
  }
}

class RedFilter extends ColorFilter {
  RedFilter() : super(name: "Red") {
    subFilters.add(new RGBScaleSubFilter(4, 1, 1));
  }
}

class GreenFilter extends ColorFilter {
  GreenFilter() : super(name: "Green") {
    subFilters.add(new RGBScaleSubFilter(1, 4, 1));
  }
}

class BlueFilter extends ColorFilter {
  BlueFilter() : super(name: "Blue") {
    subFilters.add(new RGBScaleSubFilter(1, 1, 4));
  }
}

List<Filter> myColorFiltersList = [
  InversFilter(),
  RedFilter(),
  GreenFilter(),
  BlueFilter()
];
