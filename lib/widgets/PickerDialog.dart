import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../widgets/itemcard.dart';

class PickerDialog extends StatefulWidget {
  const PickerDialog({super.key});

  @override
  State<PickerDialog> createState() => _PickerDialogState();
}

class _PickerDialogState extends State<PickerDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog();
  }
}
