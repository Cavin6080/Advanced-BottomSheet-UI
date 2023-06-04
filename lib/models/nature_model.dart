class NatureModel {
  final String title;
  final String artistName;
  final String image;
  NatureModel({
    required this.title,
    required this.artistName,
    required this.image,
  });
  static List<NatureModel> natureList = [
    NatureModel(
      title: 'Yellow Garden',
      artistName: 'By Cavin',
      image: 'assets/image-1.jpeg',
    ),
    NatureModel(
      title: 'Green forest',
      artistName: 'By Milan',
      image: 'assets/image-2.jpeg',
    ),
    NatureModel(
      title: 'Big Mountains',
      artistName: 'By Pratik',
      image: 'assets/image-3.jpeg',
    ),
    NatureModel(
      title: 'Sunset',
      artistName: 'By Steven',
      image: 'assets/image-1.jpeg',
    ),
    NatureModel(
      title: 'Tulip Macro',
      artistName: 'By Luis',
      image: 'assets/image-4.jpeg',
    ),
    NatureModel(
      title: 'Green forest',
      artistName: 'By Milan',
      image: 'assets/image-2.jpeg',
    ),
    NatureModel(
      title: 'Big Sunset',
      artistName: 'By Lisa',
      image: 'assets/image-1.jpeg',
    ),
  ];
}
