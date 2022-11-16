import 'garden.dart';
import 'plant.dart';

class ECData {
  Map<String, Plant> plants = {};
  Map<String, Garden> gardens = {};

  ECData.fromJson(Map<String, dynamic> json) {
    for (int i = 0; i < json["plant_keys"].length; i++) {
      plants[json["plant_keys"][i].toString()] =
          Plant.fromJson(json["plant"][json["plant_keys"][i].toString()]);
    }
    for (int i = 0; i < json["garden_keys"].length; i++) {
      gardens[json["garden_keys"][i].toString()] =
          Garden.fromJson(json["garden"][json["garden_keys"][i].toString()]);
    }
  }

  ECData.empty();

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
