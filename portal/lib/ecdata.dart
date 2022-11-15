import 'garden.dart';
import 'plant.dart';

class ECData {
  Map<String, Plant> plants = {};
  Map<String, Garden> gardens = {};
  bool isApp = true;

  ECData(Map<String, dynamic> jsonData, bool _isApp) {
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
      );
    }
    isApp = _isApp;
  }

  ECData.empty();

  GardenPage gardenPage(String key) {
    return GardenPage(
        garden: gardens[key]!, plants: plants, gardens: gardens, isApp: isApp);
  }

  GardensPage gardensPage() {
    return GardensPage(gardens: gardens, plants: plants, isApp: isApp);
  }

  PlantPage plantPage(String key) {
    return PlantPage(plant: plants[key]!, gardens: gardens, isApp: isApp);
  }

  PlantsPage plantsPage() {
    return PlantsPage(gardens: gardens, plants: plants, isApp: isApp);
  }
}
