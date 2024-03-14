import 'dart:convert';

import 'package:http/http.dart'as http;

class RecommendationModel {
  String item;
  String image;
  String description;

  // Constructor
  RecommendationModel(
      {required this.item, required this.image, required this.description});

  static List<String>dish = [
    "SpaghettiBolognese",
    "MargheritaPizza",
    "FettuccineAlfredo",
    "CapreseSalad",
    "Lasagna",
    "Bruschetta",
    "MinestroneSoup",
    "Tiramisu",
    "PanzanellaSalad",
    "GnocchiwithPesto",
    "Burritos",
    "NachoswithSalsaandGuacamole",
    "Fajitas",
    "CarnitasTacos",
    "ChileRellenos",
    "Pozole",
    "Tamales",
    "ChilesenNogada",
    "CochinitaPibil",
    "Ceviche",
    "Ramen",
    "Bibimbap",
    "ThaiGreenCurry",
    "DimSum(Assorted)",
    "VietnamesePho",
    "BeefBulgogi",
    "Sushi(Assorted)",
    "ChickenSatay",
    "PadSeeEw",
    "MisoSoup",
    "BabaGanoush",
    "Kebabs(Assorted)",
    "FalafelPlate",
    "FatoushSalad",
    "ShawarmaWrap",
    "StuffedGrapeLeaves(Dolma)",
    "LambKofta",
    "Muhammara",
    "Basbousa",
    "Halva",
    "SpinachandRicottaStuffedShells",
    "EggplantParmesan",
    "VegetablePaella",
    "LentilSalad",
    "Ratatouille",
    "MushroomRisotto",
    "SweetPotatoandBlackBeanEnchiladas",
    "CapresePanini",
    "ButternutSquashSoup",
    "VegetarianMoussaka",
    "VeganPadSeeEw",
    "JackfruitTacos",
    "VeganSushiRolls(Assorted)",
    "LentilCurry",
    "VeganMacandCheese",
    "ChickpeaSalad",
    "VeggieStirfry",
    "VeganChili",
    "VeganBibimbap",
    "CoconutCurryTofu"
  ];

  static List<RecommendationModel> food_data = [

    RecommendationModel(
        item: "Spaghetti Bolognese",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/Spaghetti%20Bolognese.jpg?alt=media&token=29bc9394-5fcb-4828-8582-603485528f9d",
        description: "A classic Italian dish featuring al dente spaghetti tossed in a rich, savory sauce made with ground beef, tomatoes, onions, garlic, herbs, and spices. Garnished with grated Parmesan cheese and fresh basil for a flavorful experience."),

    RecommendationModel(
        item: "Margherita Pizza",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/Margherita%20Pizza.jpg?alt=media&token=bc3aaa44a9da4d16937b535371c163f8",
        description: "A traditional Neapolitan pizza topped with a simple yet flavorful combination of fresh tomatoes, mozzarella cheese, basil leaves, and olive oil on a thin crust. A classic dish that celebrates the essence of Italian cuisine."
    ),
    RecommendationModel(
        item: "Fettuccine Alfredo",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/Fettuccine%20Alfredo.jpg?alt=media&token=86b7d8ca6bae4ed7bda1b842d64d0e2f",
        description: "Silky ribbons of fettuccine pasta coated in a creamy sauce made with butter, heavy cream, and Parmesan cheese. Seasoned with garlic, salt, and pepper, this indulgent Italian dish is a decadent comfort food favorite."
    ),
    RecommendationModel(
        item: "Caprese Salad",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/Caprese%20Salad.jpg?alt=media&token=5a22c80bf47141b7bd04918259d5e46e",
        description: "A refreshing Italian salad consisting of ripe tomatoes, fresh mozzarella cheese, and basil leaves, drizzled with extra virgin olive oil and balsamic glaze. A simple yet elegant dish that highlights the vibrant flavors of its quality ingredients."
    ),
    RecommendationModel(
        item: "Lasagna",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/Lasagna.jpg?alt=media&token=419d6b7d6a2e4d95a50bf17d0911e7a9",
        description: "Layers of wide pasta sheets interlaced with rich meat sauce, creamy béchamel, and melted mozzarella cheese, baked until golden and bubbling. A comforting Italian classic that embodies hearty flavors and satisfying textures in every bite."
    ),
    RecommendationModel(
        item: "Bruschetta",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/Bruschetta.jpg?alt=media&token=8a751d98533a4296882f16098e7d4cac",
        description: "Toasted bread topped with diced tomatoes, garlic, basil, and olive oil. A simple yet vibrant appetizer bursting with fresh flavors."
    ),
    RecommendationModel(
        item: "Minestrone Soup",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/Minestrone%20Soup.jpg?alt=media&token=1058471de3a149ba9a63b7782694be27",
        description: "A hearty Italian soup brimming with vegetables, beans, pasta, and herbs in a savory broth. A comforting and nutritious dish perfect for any occasion."
    ),
    RecommendationModel(
        item: "Tiramisu",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/Tiramisu.jpg?alt=media&token=15c065e86ba94bdfaab3796c41bcb48c",
        description: "A decadent Italian dessert made with layers of coffee-soaked ladyfingers, mascarpone cheese, cocoa powder, and a hint of liqueur. Creamy, rich, and indulgent, it's a beloved classic."
    ),
    RecommendationModel(
        item: "Panzanella Salad",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/Panzanella%20Salad.jpg?alt=media&token=70ec47b3b9c84e8a864e141446fb11ed",
        description: "A Tuscan salad featuring ripe tomatoes, cucumbers, onions, basil, and stale bread cubes tossed in a vinaigrette dressing. A refreshing and satisfying dish that celebrates the essence of summer."
    ),
    RecommendationModel(
        item: "Gnocchi with Pesto",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/Gnocchi%20with%20Pesto.jpg?alt=media&token=8c14fb18e14841608f9e88afa3729a93",
        description: "Soft potato dumplings tossed in a vibrant pesto sauce made with basil, garlic, pine nuts, Parmesan cheese, and olive oil. A delicious and comforting Italian dish bursting with fresh flavors."
    ),
    RecommendationModel(
        item: "Burritos",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Burritos.jpg?alt=media&token=d9a5fb11ca2746af998b0a1847afd229",
        description: "Flour tortillas filled with seasoned meat, rice, beans, cheese, and salsa, wrapped into a convenient handheld meal. A staple of Mexican cuisine known for its versatility and satisfying flavors."
    ),
    RecommendationModel(
        item: "Nachos with Salsa and Guacamole",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Nachos%20with%20Salsa%20and%20Guacamole.jpg?alt=media&token=b8d25da5e1e14e2396104b71711cf648",
        description: "Crispy tortilla chips topped with tangy salsa, creamy guacamole, melted cheese, and various toppings. A popular appetizer or snack bursting with bold Mexican flavors."
    ),
    RecommendationModel(
        item: "Fajitas",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Fajitas.jpg?alt=media&token=47a0b7e70e57465183ed751f7e26a1b8",
        description: "Sizzling hot strips of grilled meat, usually beef or chicken, served with sautéed onions and bell peppers. Accompanied by warm tortillas, sour cream, guacamole, and salsa for assembling flavorful wraps."
    ),
    RecommendationModel(
        item: "Carnitas Tacos",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Carnitas%20Tacos.jpg?alt=media&token=5a11b5eb54d6431d84edbee54ac0d58d",
        description: "Tender, slow-cooked pork seasoned with spices and citrus, served on soft corn tortillas. Topped with onions, cilantro, and salsa, these tacos offer a delicious balance of savory and tangy flavors."
    ),
    RecommendationModel(
        item: "Chile Rellenos",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Chile%20Rellenos.webp?alt=media&token=e5236abbf48e4c6d85121c76a88cde31",
        description: "Roasted poblano peppers stuffed with cheese, dipped in egg batter, and fried until golden. Served with a flavorful tomato sauce, these stuffed peppers offer a harmonious blend of spicy and creamy textures."
    ),
    RecommendationModel(
        item: "Pozole",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Pozole.jpg?alt=media&token=673cc416fb4f442a9a0ed731b1ba5af3",
        description: "A hearty Mexican soup made with hominy, tender pork, and a rich broth flavored with chilies and spices. Garnished with shredded cabbage, radishes, lime, and other toppings for a satisfying meal."
    ),
    RecommendationModel(
        item: "Tamales",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Tamales.jpg?alt=media&token=b02f1c36407648a387f93f007d84ddb0",
        description: "Corn masa dough filled with savory or sweet fillings, wrapped in corn husks, and steamed until cooked through. A traditional Mexican dish enjoyed during celebrations and festivals, offering a delightful blend of textures and flavors."
    ),
    RecommendationModel(
        item: "Chiles en Nogada",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Chiles%20en%20Nogada.jpg?alt=media&token=3b3435ee861245a5a48b09ec19c162ef",
        description: "Poblano peppers stuffed with a mixture of ground meat, fruits, and spices, topped with a creamy walnut sauce, and garnished with pomegranate seeds and parsley. A festive dish symbolizing the colors of the Mexican flag."
    ),
    RecommendationModel(
        item: "Cochinita Pibil",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Cochinita%20Pibil.jpg?alt=media&token=84d6ba6376c44c0f9439331de315adc7",
        description: "Tender, slow-roasted pork marinated in achiote paste, citrus juices, and spices, traditionally wrapped in banana leaves for cooking. Served with pickled onions and warm tortillas, it's a flavorful specialty from the Yucatán region."
    ),
    RecommendationModel(
        item: "Ceviche",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Ceviche.jpg?alt=media&token=45a64c08051d4dee81305f61ca467e73",
        description: "Fresh raw fish marinated in citrus juices, typically lime or lemon, along with onions, tomatoes, cilantro, and chili peppers. Served cold as a refreshing and tangy appetizer or light meal, perfect for warm weather."
    ),
    RecommendationModel(
        item: "Ramen",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Ramen%20%20Copy.jpg?alt=media&token=1460656b5ae5432fa5275925ed163eeb",
        description: "Japanese noodle soup featuring wheat noodles served in a flavorful broth, topped with sliced pork, soft-boiled egg, green onions, seaweed, and other toppings. A comforting and hearty dish with various regional variations."
    ),
    RecommendationModel(
        item: "Bibimbap",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Bibimbap%20%20Copy.webp?alt=media&token=8af6f5b9850b44bcba87103e53f18596",
        description: "A Korean mixed rice dish topped with assorted vegetables, meat (often beef), a fried egg, and spicy gochujang sauce. It offers a harmonious blend of flavors and textures in each bite."
    ),
    RecommendationModel(
        item: "Thai Green Curry",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Thai%20Green%20Curry%20%20Copy.jpg?alt=media&token=9d835749fa0a434e933f24c1428a260a",
        description: "A fragrant Thai curry made with green curry paste, coconut milk, meat or seafood, and vegetables. It's known for its vibrant green color and complex flavors, often served with rice."
    ),
    RecommendationModel(
        item: "Dim Sum (Assorted)",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Dim%20Sum%20(Assorted)%20%20Copy.jpg?alt=media&token=9a9b7c48cb4b4119b9b606aaf4570928",
        description: "A variety of bite-sized Chinese dishes served in bamboo steamers or small plates, including dumplings, buns, rolls, and other savory or sweet treats. Dim sum is enjoyed as a brunch or lunch option."
    ),
    RecommendationModel(
        item: "Vietnamese Pho",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Vietnamese%20Pho%20%20Copy.jpg?alt=media&token=7ed6911c4de14a64ba2a9e5b42b90dea",
        description: "A Vietnamese noodle soup featuring flavorful broth, rice noodles, and thinly sliced beef or chicken. Served with fresh herbs, bean sprouts, lime, and chili peppers on the side for customization."
    ),
    RecommendationModel(
        item: "Beef Bulgogi",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Beef%20Bulgogi%20%20Copy.webp?alt=media&token=644faf7b198b42b386266c575aef80ff",
        description: "Korean grilled marinated beef, typically served with rice and accompanied by lettuce leaves, ssamjang (spicy paste), and various side dishes. It's known for its tender, sweet, and savory flavors."
    ),
    RecommendationModel(
        item: "Sushi (Assorted)",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Sushi%20(Assorted)%20%20Copy.jpg?alt=media&token=572f4425b6804331b7fe0820d1af71b3",
        description: "A Japanese dish consisting of vinegared rice topped with various ingredients such as raw or cooked seafood, vegetables, and occasionally tropical fruits. Sushi comes in a variety of forms including nigiri, maki, and sashimi."
    ),
    RecommendationModel(
        item: "Chicken Satay",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Chicken%20Satay%20%20Copy.webp?alt=media&token=00f470038bbe4504acacfc50d061bebe",
        description: "Skewered and grilled marinated chicken served with a peanut sauce, cucumber slices, and rice or flatbread. A popular Southeast Asian street food known for its flavorful and aromatic profile."
    ),
    RecommendationModel(
        item: "Pad See Ew",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Pad%20See%20Ew%20%20Copy.jpg?alt=media&token=a28541d247bb48c1b30dcff2cf732fce",
        description: "A Thai stir-fried noodle dish made with wide rice noodles, Chinese broccoli, egg, and choice of meat, all cooked in a sweet and savory sauce. It's a comforting and satisfying Thai street food favorite."
    ),
    RecommendationModel(
        item: "Miso Soup",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Miso%20Soup%20%20Copy.webp?alt=media&token=6b7a05bfe72a43af8807acd75e6a73fd",
        description: "A Japanese soup made with dashi broth and fermented soybean paste (miso), often containing tofu, seaweed, green onions, and other ingredients. It's a staple dish in Japanese cuisine, served as a starter or side dish."
    ),
    RecommendationModel(
        item: "Baba Ganoush",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Baba%20Ganoush.jpg?alt=media&token=ab8576061bab4c3cb1335797322cdbdb",
        description: "A creamy Middle Eastern dip made from roasted eggplant, tahini, garlic, lemon juice, and olive oil. It offers a smoky flavor and smooth texture, perfect for spreading on pita bread or enjoying as a dip with vegetables."
    ),
    RecommendationModel(
        item: "Kebabs (Assorted)",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Kebabs%20(Assorted).webp?alt=media&token=beec259b9d394943b8541a565765a3af",
        description: "Skewered and grilled pieces of meat, such as lamb, chicken, or beef, marinated in spices and served with rice or flatbread. A popular Middle Eastern dish known for its flavorful and tender meat."
    ),
    RecommendationModel(
        item: "Falafel Plate",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Falafel%20Plate.jpg?alt=media&token=9340a6751c104fde9c81e066f114b84b",
        description: "Crispy chickpea fritters served with tahini sauce, hummus, pickles, and salad. A vegetarian favorite in Middle Eastern cuisine, falafel offers a satisfying combination of textures and flavors."
    ),
    RecommendationModel(
        item: "Fatoush Salad",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Fatoush%20Salad.webp?alt=media&token=d7b6046d860746079e759147c4b26691",
        description: "A refreshing salad made with mixed greens, tomatoes, cucumbers, radishes, and crispy pieces of toasted pita bread. Tossed with a zesty sumac dressing, it's a light and flavorful dish perfect for summer."
    ),
    RecommendationModel(
        item: "Shawarma Wrap",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Shawarma%20Wrap.webp?alt=media&token=a9b576fdbe874e84b115332a879dd6f2",
        description: "Thinly sliced marinated meat, typically chicken, beef, or lamb, wrapped in a warm pita bread with tahini sauce, pickles, and vegetables. A popular street food in the Middle East, offering a delicious and portable meal option."
    ),
    RecommendationModel(
        item: "Stuffed Grape Leaves (Dolma)",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Stuffed%20Grape%20Leaves%20(Dolma).jpg?alt=media&token=a796b11ed8b8453b9d3b7a78c3601321",
        description: "Grape leaves stuffed with a savory mixture of rice, pine nuts, herbs, and sometimes ground meat. Cooked and served with yogurt or a lemony sauce, dolma is a flavorful and traditional dish in Middle Eastern cuisine."
    ),
    RecommendationModel(
        item: "Lamb Kofta",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Lamb%20Kofta.webp?alt=media&token=802434ae9dd545da972507dbe81e2d70",
        description: "Spiced ground lamb or beef shaped into skewers or patties and grilled or roasted. Served with rice, flatbread, or salad, lamb kofta offers a juicy and aromatic experience with its blend of Middle Eastern spices."
    ),
    RecommendationModel(
        item: "Muhammara",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Muhammara.jpg?alt=media&token=164a141b277e4fc9b4df8b7d4dd3c7e7",
        description: "A vibrant red dip made from roasted red peppers, walnuts, breadcrumbs, olive oil, and spices. Muhammara has a rich and slightly spicy flavor, perfect for spreading on bread or as a dip for vegetables."
    ),
    RecommendationModel(
        item: "Basbousa",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Basbousa.jpg?alt=media&token=a51dc1569aab42369cf8dcd244e1cdcc",
        description: "A sweet Middle Eastern dessert made from semolina flour, sugar, yogurt, and coconut, soaked in a sugar syrup flavored with rosewater or orange blossom water. Basbousa has a dense and moist texture with a hint of floral sweetness."
    ),
    RecommendationModel(
        item: "Halva",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/halva.jpg?alt=media&token=d2c85b4e1a5d455a9b101bc76b98f0f6",
        description: "A dense and sweet confection made from sesame paste (tahini) or other nut butters, mixed with sugar and sometimes flavored with spices or nuts. Halva comes in various textures and flavors, offering a rich and indulgent treat in Middle Eastern cuisine."
    ),
    RecommendationModel(
        item: "Spinach and Ricotta Stuffed Shells",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Spinach%20and%20Ricotta%20Stuffed%20Shells.jpg?alt=media&token=ab779043abf64530a07ef25eb2baca66",
        description: "Pasta shells filled with a mixture of spinach, ricotta cheese, garlic, and herbs, baked in marinara sauce and topped with melted mozzarella. A comforting and flavorful vegetarian twist on a classic Italian dish."
    ),
    RecommendationModel(
        item: "Eggplant Parmesan",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Eggplant%20Parmesan.webp?alt=media&token=75bed822017b4c6283e2b08a1097dc55",
        description: "Slices of eggplant coated in breadcrumbs, fried until golden, then layered with marinara sauce and melted mozzarella cheese. Baked until bubbly, it's a hearty and satisfying vegetarian option."
    ),
    RecommendationModel(
        item: "Vegetable Paella",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Vegetable%20Paella.jpg?alt=media&token=d275d33adf0c40d2a64271ea07c62e67",
        description: "A Spanish rice dish cooked with saffron-infused broth, loaded with assorted vegetables like bell peppers, peas, tomatoes, and artichokes. Flavored with garlic, paprika, and other spices, it's a colorful and flavorful vegetarian meal."
    ),
    RecommendationModel(
        item: "Lentil Salad",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Lentil%20Salad.jpg?alt=media&token=bb2eeb4448174f5c96bf8a67fd679f4f",
        description: "A nutritious salad featuring cooked lentils tossed with diced vegetables, fresh herbs, and a tangy vinaigrette dressing. Packed with protein and fiber, it's a satisfying and healthy vegetarian option for lunch or dinner."
    ),
    RecommendationModel(
        item: "Ratatouille",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Ratatouille.webp?alt=media&token=e599c8da9bef4854b0ba1b7176ec2898",
        description: "A French vegetable stew made with eggplant, zucchini, bell peppers, onions, and tomatoes, cooked in olive oil with garlic and herbs. Ratatouille is a flavorful and versatile dish that can be enjoyed on its own or served with crusty bread or pasta."
    ),
    RecommendationModel(
        item: "Mushroom Risotto",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Mushroom%20Risotto.jpg?alt=media&token=6955b5bc09b44e27889fab41ce8b3505",
        description: "Creamy Italian rice dish cooked with Arborio rice, mushroom broth, and sautéed mushrooms. Finished with butter, Parmesan cheese, and fresh herbs, it's a luxurious and comforting vegetarian option perfect for any occasion."
    ),
    RecommendationModel(
        item: "Sweet Potato and Black Bean Enchiladas",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Sweet%20Potato%20and%20Black%20Bean%20Enchiladas.jpg?alt=media&token=0759cd7bd50c4a048a2c1636ddb9a6cb",
        description: "Soft tortillas filled with mashed sweet potatoes, black beans, onions, and spices, topped with enchilada sauce and melted cheese. Baked until bubbly, they offer a delicious and nutritious twist on traditional enchiladas."
    ),
    RecommendationModel(
        item: "Caprese Panini",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Caprese%20Panini.jpg?alt=media&token=99238a6fe1294429a8b98e2642a0fae0",
        description: "A grilled sandwich filled with fresh mozzarella cheese, ripe tomatoes, basil leaves, and a drizzle of balsamic glaze, pressed between slices of crusty bread. A simple yet satisfying vegetarian option bursting with Mediterranean flavors."
    ),
    RecommendationModel(
        item: "Butternut Squash Soup",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Butternut%20Squash%20Soup.webp?alt=media&token=fbf24014289648dfba15dbd02d64f18a",
        description: "A creamy and velvety soup made with roasted butternut squash, onions, garlic, and vegetable broth. Seasoned with warming spices like cinnamon and nutmeg, it's a comforting and nutritious vegetarian option for cooler days."
    ),
    RecommendationModel(
        item: "Vegetarian Moussaka",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Vegetarian%20Moussaka.jpg?alt=media&token=a0eb4b2fd5e0443d9afa5967087d6be2",
        description: "A Greek casserole dish featuring layers of roasted eggplant, potatoes, and zucchini, topped with a creamy béchamel sauce and baked until golden. Flavorful and satisfying, it's a vegetarian take on the classic meat-based dish."
    ),
    RecommendationModel(
        item: "Vegan Pad See Ew",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypal-d0893.appspot.com/o/Vegan%20Pad%20See%20Ew.jpg?alt=media&token=0bcbc130-aae5-4c2a-8066-f6d013ba0f17",
        description: "A plant-based version of the Thai stir-fried noodle dish made with wide rice noodles, tofu, and assorted vegetables, all cooked in a savory sauce. A flavorful and satisfying vegan option with bold Asian-inspired flavors."
    ),
    RecommendationModel(
        item: "Jackfruit Tacos",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Jackfruit%20Tacos.webp?alt=media&token=c895c73ac7f44d97baece9eefe0fa595",
        description: "Tender jackfruit simmered in spices and served in taco shells with salsa, avocado, and cilantro. A delicious and satisfying vegan alternative to traditional meat tacos, offering a unique texture and flavor."
    ),
    RecommendationModel(
        item: "Vegan Sushi Rolls (Assorted)",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Vegan%20Sushi%20Rolls%20(Assorted).webp?alt=media&token=7e10823a82d64aaabce04e49bc405ebc",
        description: "Sushi rolls filled with a variety of fresh vegetables like cucumber, avocado, carrots, and bell peppers, wrapped in seaweed and rice. A colorful and flavorful vegan option perfect for sushi lovers."
    ),
    RecommendationModel(
        item: "Lentil Curry",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Lentil%20Curry.webp?alt=media&token=c9d44245cf9b46bcace0480907ee4c9f",
        description: "A fragrant and hearty curry made with lentils, coconut milk, and a blend of spices like curry powder, turmeric, and cumin. Served with rice or flatbread, it's a nutritious and satisfying vegan meal."
    ),
    RecommendationModel(
        item: "Vegan Mac and Cheese",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Vegan%20Mac%20and%20Cheese.jpg?alt=media&token=24fd18cb966949979b14fee3e3ecfec6",
        description: "Creamy pasta dish made with a dairy-free cheese sauce, usually using cashews or nutritional yeast for flavor and creaminess. A comforting and indulgent vegan version of a classic comfort food favorite."
    ),
    RecommendationModel(
        item: "Chickpea Salad",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Chickpea%20Salad.jpg?alt=media&token=03b9c6cb2c344d2492c13755996cdd3c",
        description: "A refreshing salad featuring chickpeas tossed with crunchy vegetables like cucumber, bell peppers, and tomatoes, dressed with a zesty vinaigrette. Packed with protein and fiber, it's a nutritious and satisfying vegan option."
    ),
    RecommendationModel(
        item: "Veggie Stir-fry",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Veggie%20Stirfry.jpg?alt=media&token=bb85662fad0a4ca0910797b6e5838a4f",
        description: "A colorful and flavorful stir-fry made with an assortment of vegetables like broccoli, bell peppers, mushrooms, and snap peas, cooked in a savory sauce. Quick, easy, and versatile, it's a delicious vegan option for a quick meal."
    ),
    RecommendationModel(
        item: "Vegan Chili",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/%20Vegan%20Chili.jpg?alt=media&token=63f64fb9817a4a0b8a21d3ee67384fc4",
        description: "Hearty chili made with beans, vegetables, tomatoes, and spices, cooked until thick and flavorful. A comforting and satisfying vegan dish perfect for chilly days, served with rice, cornbread, or tortilla chips."
    ),
    RecommendationModel(
        item: "Vegan Bibimbap",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Vegan%20Bibimbap.webp?alt=media&token=5b082f94167b44228bc84fe70b85d44c",
        description: "A Korean mixed rice dish featuring assorted vegetables like spinach, mushrooms, carrots, and bean sprouts, served with a spicy gochujang sauce. A colorful and nutritious vegan option with vibrant flavors and textures."
    ),
    RecommendationModel(
        item: "Coconut Curry Tofu",
        image: "https://firebasestorage.googleapis.com/v0/b/tastypald0893.appspot.com/o/Coconut%20Curry%20Tofu.webp?alt=media&token=ee3509299a054a1b81cb9fe0cbdfd20d",
        description: "Tofu cubes simmered in a creamy coconut curry sauce with vegetables like bell peppers, peas, and carrots. Fragrant spices like ginger, garlic, and turmeric add depth of flavor, making it a delicious and satisfying vegan meal."
    ),


  ];

  static String generated_text = "";

  static void getvalue(item){
      for(RecommendationModel data in RecommendationModel.food_data){
        if(data.item==item){
          print(data.image);
        }
      }
  }

  static List<String> dishes = generated_text.split('\n').map((dish) {
    // Remove leading numbers and dots
    return dish.replaceAll(RegExp(r"^\d+\.\s*"),"");
  }).toList();



}
