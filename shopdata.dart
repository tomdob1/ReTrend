class shopDetail{
  final int id;
  final String shop;
  final String location;
  final String description;
  final String image;

  shopDetail({this.id, this.shop, this.location, this.description, this.image});


}

final shopDetails = [
  shopDetail(
      id: 0,
      shop: "Beyond Retro",
      location: "London",
      description: "Welcome to Beyond Retro",
      image: "assets/appimages/beyondRetro.png"
  ),
  shopDetail(
      id: 1,
      shop: "Rokit",
      location: "London",
      description: "Welcome to Rokit",
      image: "assets/appimages/rokit.png"
  ),
  shopDetail(
      id: 2,
      shop: "COW",
      location: "Nottingham",
      description: "Welcome to COW",
      image: "assets/appimages/cow.png"
  ),
  shopDetail(
      id: 3,
      shop: "Urban Fox",
      location: "Bristol",
      description: "Welcome to Urban Fox",
      image: "assets/appimages/urbanFox.png"
  ),shopDetail(
      id: 4,
      shop: "Brag",
      location: "Sheffield",
      description: "Welcome to Brag",
      image: "assets/appimages/brag.png"
  ),
  shopDetail(
      id: 5,
      shop: "Flip",
      location: "Newcastle",
      description: "Welcome to flip",
      image: "assets/appimages/flip.png"
  ),
];
