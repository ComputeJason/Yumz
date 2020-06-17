import 'package:google_maps_flutter/google_maps_flutter.dart';


class Place{

  String placeName;
  String address;
  String description;
  String thumbnail;
  LatLng coord;

  Place({
    this.address,
    this.description,
    this.placeName,
    this.thumbnail,
    this.coord,
  });

}

final List<Place> places = [
  Place(
    placeName: 'Mandarin Gardens',
    address: '5 Siglap Road #11-33 ',
    description: 'My home! Yay I stay here hello.',
    thumbnail: 'https://www.straitstimes.com/sites/default/files/styles/article_pictrure_780x520_/public/articles/2019/03/26/ST_20190326_JSMANDARIN26_4719389.jpg?itok=UO9Mv4K0&timestamp=1553536207',
    coord: LatLng(1.306992, 103.924665),
  ),Place(
    placeName: 'Sheares Hall',
    address: '20 Heng Mui Keng Terrace',
    description: 'Second home away from home',
    thumbnail: 'https://userscontent2.emaze.com/images/e5cc520a-621b-4022-ba0e-b158fe6ae8e3/0c51c23c-b245-4c5a-871c-4fd17ec7b420.JPG',
    coord: LatLng(1.2914, 103.7756),
  ),Place(
    placeName: 'Bedok Mall',
    address: '311 New Upper Changi Rd',
    description: 'Somehow i come here alot',
    thumbnail: 'https://www.capitaland.com/content/dam/capitaland-newsroom/inside/2014/02/feb14_01_leisure.jpg.transform/cap-midres/image.jpg',
    coord: LatLng(1.3246, 103.9297),
  ),Place(
    placeName: 'Bayshore Park',
    address: '60 Bayshore Road Jade Tower',
    description: 'Grandparents & cuzzies :)',
    thumbnail: 'https://sg1-cdn.pgimgs.com/listing/21821690/UPHO.108165006.V800/Bayshore-Park-Bedok-Upper-East-Coast-Singapore.jpg',
    coord: LatLng(1.3110, 103.9373),
  ),Place(
    placeName: 'Bugis+',
    address: '200 Victoria Street',
    description: 'Place for snacks and chill',
    thumbnail: 'https://a.cdn-hotels.com/gdcs/production167/d806/6323a821-df34-41b9-9e8d-68519437f8d8.jpg',
    coord: LatLng(1.2996, 103.8552),
  )
];