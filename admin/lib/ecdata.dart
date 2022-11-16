import 'garden.dart';
import 'plant.dart';

class ECData {
  Map<String, Plant> plants = {};
  Map<String, Garden> gardens = {};

  ECData.fromJson(Map<String, dynamic> json) {
    for (int i = 0; i < json["plant_keys"].length; i++) {
      plants[json["plant_keys"][i].toString()] = Plant.fromJson(
          json["plant"][json["plant_keys"][i].toString()],
          json["plant_keys"][i].toString());
    }
    for (int i = 0; i < json["garden_keys"].length; i++) {
      gardens[json["garden_keys"][i].toString()] = Garden.fromJson(
          json["garden"][json["garden_keys"][i].toString()],
          json["garden_keys"][i].toString());
    }
  }

  ECData.empty();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> rv = {
      "plant_keys": plants.keys,
      "garden_keys": gardens.keys,
    };
    Map<String, dynamic> ps = {};
    Map<String, dynamic> gs = {};

    for (String plant_key in plants.keys) {
      ps[plant_key] = plants[plant_key]!.toJson();
    }
    for (String garden_key in gardens.keys) {
      gs[garden_key] = gardens[garden_key]!.toJson();
    }
    rv["garden"] = gs;
    rv["plant"] = ps;

    return rv;
  }

  GardenPage gardenPage(String key) {
    return GardenPage(garden: gardens[key]!, plants: plants, gardens: gardens);
  }

  GardensPage gardensPage() {
    return GardensPage(gardens: gardens, plants: plants);
  }

  PlantPage plantPage(String key) {
    return PlantPage(plant: plants[key]!, gardens: gardens);
  }

  PlantsPage plantsPage() {
    return PlantsPage(
      gardens: gardens,
      plants: plants,
    );
  }
}
