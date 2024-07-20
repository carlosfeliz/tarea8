import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'location_provider.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapController _mapController;
  late Marker _marker;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _setMarker();
  }

  Future<void> _setMarker() async {
    final provider = Provider.of<LocationProvider>(context, listen: false);
    final placemarks = await placemarkFromCoordinates(provider.latitude, provider.longitude);
    final placemark = placemarks.first;

    setState(() {
      _marker = Marker(
        point: LatLng(provider.latitude, provider.longitude),
        builder: (ctx) => IconButton(
          icon: const Icon(Icons.location_on),
          color: Colors.red,
          iconSize: 40.0,
          onPressed: () {
            showDialog(
              context: ctx,
              builder: (ctx) => AlertDialog(
                title: Text('${provider.name} ${provider.surname}'),
                content: Text('${placemark.locality}, ${placemark.country}'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Cerrar'),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(provider.latitude, provider.longitude),
          zoom: 15.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [_marker],
          ),
        ],
      ),
    );
  }
}
