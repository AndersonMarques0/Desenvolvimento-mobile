import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io' show Platform;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MapaLocalizacao(),
    );
  }
}

class MapaLocalizacao extends StatefulWidget {
  const MapaLocalizacao({super.key});

  @override
  State<MapaLocalizacao> createState() => _MapaLocalizacaoState();
}

class _MapaLocalizacaoState extends State<MapaLocalizacao> {
  GoogleMapController? _mapController;
  LatLng? _posicaoAtual;
  final Set<Marker> _markers = {};
  bool _loadingLocation = false;
  String? _errorMsg;

  static const LatLng _defaultLatLng = LatLng(-23.5505, -46.6333);
  static const CameraPosition _initialCamera = CameraPosition(
    target: _defaultLatLng,
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    _obterLocalizacao();
  }

  Future<void> _obterLocalizacao() async {
    setState(() {
      _loadingLocation = true;
      _errorMsg = null;
    });

    try {
      bool servicoAtivo = await Geolocator.isLocationServiceEnabled();
      if (!servicoAtivo) {
        setState(() {
          _errorMsg = 'Serviço de localização está desativado. Por favor, ative o GPS.';
          _loadingLocation = false;
        });
        return;
      }

      LocationPermission permissao = await Geolocator.checkPermission();
      if (permissao == LocationPermission.denied) {
        permissao = await Geolocator.requestPermission();
        if (permissao == LocationPermission.denied) {
          setState(() {
            _errorMsg = 'Permissão de localização negada.';
            _loadingLocation = false;
          });
          return;
        }
      }

      if (permissao == LocationPermission.deniedForever) {
        setState(() {
          _errorMsg =
              'Permissão negada permanentemente. Abra as configurações do app para permitir.';
          _loadingLocation = false;
        });
        return;
      }

      // Configurações de localização atualizadas
      final LocationSettings locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 0,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 10),
      );

      Position posicao = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      final latlng = LatLng(posicao.latitude, posicao.longitude);

      setState(() {
        _posicaoAtual = latlng;
        _markers.clear();
        _markers.add(Marker(
          markerId: const MarkerId('pos_atual'),
          position: latlng,
          infoWindow: const InfoWindow(title: 'Você está aqui'),
        ));
        _loadingLocation = false;
      });

      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(latlng, 16),
        );
      }
    } catch (e) {
      setState(() {
        _errorMsg = 'Erro ao obter localização: $e';
        _loadingLocation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Localização no Mapa'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
              if (_posicaoAtual != null) {
                _mapController!
                    .animateCamera(CameraUpdate.newLatLngZoom(_posicaoAtual!, 16));
              }
            },
            initialCameraPosition: _initialCamera,
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            compassEnabled: true,
            mapToolbarEnabled: true,
          ),

          if (_loadingLocation)
            const Center(child: CircularProgressIndicator()),

          if (_errorMsg != null)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Card(
                color: Colors.red.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _errorMsg!,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),

          Positioned(
            bottom: 80,
            right: 16,
            child: FloatingActionButton(
              onPressed: _obterLocalizacao,
              backgroundColor: Colors.green,
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
