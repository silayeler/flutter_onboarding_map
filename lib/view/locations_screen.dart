// lib/view/locations_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart'; // ✅ eklendi (tr())
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/place_model.dart';
import '../viewmodel/place_view_model.dart';

@RoutePage()
class LocationsScreen extends StatelessWidget {
  const LocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<PlaceViewModel>();
    final _ = context.locale; // 4444444

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        title: Text('locations_title'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddDialog(context),
          ),
        ],
      ),
      body: StreamBuilder<List<PlaceModel>>(
        stream: vm.streamPlaces(),
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(
                child: Text('common_error'.tr())); // "Bir hata oluştu"
          }
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snap.data!;
          if (items.isEmpty) {
            return Center(child: Text('locations_empty'.tr())); // "Kayıt yok"
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (c, i) {
              final p = items[i];
              return Dismissible(
                key: ValueKey(p.id ?? '$i'),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (_) async {
                  return await showDialog<bool>(
                        context: c,
                        builder: (_) => AlertDialog(
                          title: Text(
                              'delete_confirm_title'.tr()), // "Silinsin mi?"
                          content: Text(
                            p.description.isEmpty
                                ? 'delete_confirm_content'
                                    .tr() // "Bu kaydı sil"
                                : p.description,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(_, false),
                              child: Text('cancel'.tr()),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(_, true),
                              child: Text('delete'.tr()),
                            ),
                          ],
                        ),
                      ) ??
                      false;
                },
                onDismissed: (_) {
                  final id = p.id;
                  if (id != null) vm.deletePlace(id);
                  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mekan silindi')),
    );
                },
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Theme.of(context).dividerColor),
                  ),
                  title: Text(p.name.isEmpty ? '(Unnamed)' : p.name),
                  subtitle: Text(
                    '${p.description}\nLat: ${p.latitude}, Lng: ${p.longitude}',
                  ),
                  isThreeLine: true,
                  trailing: Text(
                    p.category,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void _showAddDialog(BuildContext context) {
  final vm = context.read<PlaceViewModel>();

  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final catCtrl = TextEditingController();
  final latCtrl = TextEditingController();
  final lngCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void resetAll() {
    nameCtrl.clear();
    descCtrl.clear();
    catCtrl.clear ();
    latCtrl.clear();
    lngCtrl.clear();
  }

  showDialog(
    context: context,
    barrierDismissible:
        false,
    builder: (_) => AlertDialog(
     
      titlePadding: const EdgeInsets.fromLTRB(20, 16, 8, 0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'add_location_title'.tr(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            tooltip: 'close'.tr(), 
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: InputDecoration(
                    labelText: 'name_label'.tr()), 
              ),
              TextFormField(
                controller: descCtrl,
                decoration:
                    InputDecoration(labelText: 'desc_label'.tr()), 
              ),
              TextFormField(
                controller: catCtrl,
                decoration: InputDecoration(
                    labelText: 'category_label'.tr()), 
              ),
              TextFormField(
                controller: latCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'lat_label'.tr()), 
                validator: (v) {
                  final d = double.tryParse(v ?? '');
                  if (d == null)
                    return 'number_required'.tr(); 
                  if (d < -90 || d > 90)
                    return 'lat_range'.tr(); 
                  return null;
                },
              ),
              TextFormField(
                controller: lngCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'lng_label'.tr()), 
                validator: (v) {
                  final d = double.tryParse(v ?? '');
                  if (d == null) return 'number_required'.tr();
                  if (d < -180 || d > 180)
                    return 'lng_range'.tr(); 
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        
        TextButton(
          onPressed: resetAll,
          child: Text('reset'.tr()), 
        ),
        FilledButton(
          onPressed: () async {
            if (!formKey.currentState!.validate()) return;
         

            await vm.addPlace(
              name: nameCtrl.text.trim().isEmpty
                  ? '(Unnamed)'
                  : nameCtrl.text.trim(),
              description: descCtrl.text.trim(),
              latitude: double.parse(latCtrl.text.trim()),
              longitude: double.parse(lngCtrl.text.trim()),
              category:
                  catCtrl.text.trim().isEmpty ? 'general' : catCtrl.text.trim(),
                 
            );

            if (context.mounted) Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mekan başarıyla eklendi')),
      );
          },
          child: Text('save'.tr()), 
        ),
      ],
    ),
  );
}
