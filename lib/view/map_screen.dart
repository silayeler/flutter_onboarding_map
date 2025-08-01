import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/map_tile_view_model.dart';
import '../../model/place_model.dart';
import 'package:auto_route/auto_route.dart';
import '../routes/app_router.dart';

@RoutePage()
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mapVM = Provider.of<MapTileViewModel>(context);

    final places = mapVM.places;
    final tileUrl = mapVM.getTileUrl();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Harita'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (tile) {
              mapVM.changeTile(tile);
            },
            itemBuilder: (context) {
              return mapVM.availableTiles.map((tile) {
                return PopupMenuItem<String>(
                  value: tile,
                  child: Text(tile),
                );
              }).toList();
            },
            icon: const Icon(Icons.layers), 
          )
        ],
      ),
      body: SizedBox.expand(
        child: FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(39.9208, 32.8541),
            initialZoom: 6.0,
          ),
          children: [
            TileLayer(
              urlTemplate: tileUrl,
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: places.map((place) {
                return Marker(
                  width: 40.0,
                  height: 40.0,
                  point: LatLng(place.latitude, place.longitude),
                  child: GestureDetector(
                    onTap: () {
                      context.pushRoute(
                        DetailRoute(
                          title: place.name,
                          description: place.description,
                          lat: place.latitude,
                          long: place.longitude,
                        ),
                      );
                    },
                    child: const Icon(Icons.location_on,
                        color: Colors.red, size: 30),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
