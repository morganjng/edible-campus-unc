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

  ECData(Map<String, dynamic> jsonData) {
    for (int i = 0; i < jsonData["plant_keys"].length; i++) {
      plants[jsonData["plant_keys"][i].toString()] = Plant(
        jsonData["plant"][jsonData["plant_keys"][i].toString()]["common"]
            .toString(),
        jsonData["plant"][jsonData["plant_keys"][i].toString()]["scientific"]
            .toString(),
        jsonData["plant"][jsonData["plant_keys"][i].toString()]["images"]
            .toList(),
        jsonData["plant"][jsonData["plant_keys"][i].toString()]["recipes"]
            .toString(),
        jsonData["plant"][jsonData["plant_keys"][i].toString()]["description"]
            .toString(),
        jsonData["plant"][jsonData["plant_keys"][i].toString()]["key"]
            .toString(),
      );
    }
    for (int i = 0; i < jsonData["garden_keys"].length; i++) {
      gardens[jsonData["garden_keys"][i].toString()] = Garden(
        jsonData["garden"][jsonData["garden_keys"][i].toString()]["title"]
            .toString(),
        jsonData["garden"][jsonData["garden_keys"][i].toString()]["latitude"]
            .toDouble(),
        jsonData["garden"][jsonData["garden_keys"][i].toString()]["longitude"]
            .toDouble(),
        jsonData["garden"][jsonData["garden_keys"][i].toString()]["plants"]
            .toList(),
        jsonData["garden"][jsonData["garden_keys"][i].toString()]["images"]
            .toList(),
        jsonData["garden"][jsonData["garden_keys"][i].toString()]["key"]
            .toList(),
      );
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
