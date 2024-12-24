import 'dart:io';
import 'package:event_booking/Pages/bottomnav.dart';
import 'package:event_booking/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class UploadEvent extends StatefulWidget {
  const UploadEvent({super.key});

  @override
  State<UploadEvent> createState() => _UploadEventState();
}

class _UploadEventState extends State<UploadEvent> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Use late initialization to improve performance
  // late final ImagePicker _picker;

  // Controllers
  late final TextEditingController eventNameController;
  late final TextEditingController organizedByController;
  late final TextEditingController priceController;
  late final TextEditingController detailsController;
  late final TextEditingController locationController;

  // State variables
  File? selectedImage;
  String? selectedCategory;
  String? selectedAgeLimit;
  String? selectedTime;
  DateTime? selectedDate;
  bool isLoading = false;

  // Constants moved outside build method
  static const List<String> categories = [
    'Fashion Shows',
    'Comedy Shows',
    'Movies',
    'Party',
    'Musical Shows'
  ];

  static const List<String> ageLimits = [
    '5+',
    '8+',
    '10+',
    '12+',
    '14+',
    '16+',
    '18+'
  ];

  // Generate time list once
  final List<String> timeList =
      List.generate(24, (i) => '${i.toString().padLeft(2, '0')}:00');

  @override
  void initState() {
    super.initState();
    // _picker = ImagePicker();
    eventNameController = TextEditingController();
    organizedByController = TextEditingController();
    priceController = TextEditingController();
    detailsController = TextEditingController();
    locationController = TextEditingController();
  }

  @override
  void dispose() {
    eventNameController.dispose();
    organizedByController.dispose();
    priceController.dispose();
    detailsController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffe3f2fd),
                  Color(0xffbbdefb),
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 30),
                      _buildImagePicker(),
                      const SizedBox(height: 30),
                      _buildForm(),
                      const SizedBox(height: 20),
                      _buildSubmitButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black45,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> getImage() async {
    try {
      final imagePicker = ImagePicker();
      final XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70, // Compress image to reduce size
      );

      if (image != null) {
        setState(() {
          selectedImage = File(image.path);
        });
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildHeader() {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: _buildBackButton(),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 40),
            child: const Text(
              "Upload Event",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () {
        if (Navigator.of(context).canPop()) {
          Navigator.pop(context);
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNav(
                userId: FirebaseAuth.instance.currentUser?.uid ?? '',
              ),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(Icons.arrow_back_ios_new_outlined),
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: getImage,
      child: Center(
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black38, width: 2.0),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: selectedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.file(
                    selectedImage!,
                    fit: BoxFit.cover,
                  ),
                )
              : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt_outlined, size: 35),
                    SizedBox(height: 8),
                    Text(
                      "Add Event Photo",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextFormField(
          label: "Event Name",
          controller: eventNameController,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter event name';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        _buildDropdownField(
          label: "Event Category",
          value: selectedCategory,
          items: categories,
          onChanged: (value) => setState(() => selectedCategory = value),
        ),
        const SizedBox(height: 20),
        _buildTextFormField(
          label: "Organized By",
          controller: organizedByController,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter organizer name';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        _buildDatePicker(),
        const SizedBox(height: 20),
        _buildTextFormField(
          label: "Location",
          controller: locationController,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter location';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        _buildDropdownField(
          label: "Age Limit",
          value: selectedAgeLimit,
          items: ageLimits,
          onChanged: (value) => setState(() => selectedAgeLimit = value),
        ),
        const SizedBox(height: 20),
        _buildDropdownField(
          label: "Time",
          value: selectedTime,
          items: timeList,
          onChanged: (value) => setState(() => selectedTime = value),
        ),
        const SizedBox(height: 20),
        _buildTextFormField(
          label: "Ticket Price",
          controller: priceController,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter ticket price';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        _buildDetailsField(),
      ],
    );
  }

  Widget _buildTextFormField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter ${label.toLowerCase()}",
              hintStyle: const TextStyle(fontSize: 14, color: Colors.black54),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Event Details"),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: detailsController,
            maxLines: 4,
            maxLength: 200,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter event details';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Enter details",
              hintStyle: TextStyle(fontSize: 14, color: Colors.black54),
              counterText: "Maximum 200 words",
            ),
          ),
        ),
      ],
    );
  }

  Future<void> uploadEvent() async {
    if (!_formKey.currentState!.validate() || selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields and select an image"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      String id = randomAlphaNumeric(10);
      Map<String, dynamic> eventData = {
        "image": "",
        "name": eventNameController.text,
        "organizedBy": organizedByController.text,
        "price": priceController.text,
        "category": selectedCategory,
        "ageLimit": selectedAgeLimit,
        "date": selectedDate?.toIso8601String(),
        "time": selectedTime,
        "location": locationController.text,
        "details": detailsController.text,
      };

      await DatabaseMethods().addEvent(eventData, id);

      setState(() {
        eventNameController.clear();
        organizedByController.clear();
        priceController.clear();
        detailsController.clear();
        locationController.clear();
        selectedCategory = null;
        selectedAgeLimit = null;
        selectedTime = null;
        selectedDate = null;
        selectedImage = null;

        // Reset form validation state
        _formKey.currentState?.reset();
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Event uploaded successfully",
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
          duration: Duration(seconds: 2),
        ),
      );
  }catch (e) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error uploading event: $e"),
        backgroundColor: Colors.red,
      ),
    );
  } finally {
    setState(() => isLoading = false);
  }
}

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: !isLoading ? uploadEvent : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2196F3),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 4,
        ),
        child: Text(
          isLoading ? "Uploading..." : "Submit",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              dropdownMenuTheme: DropdownMenuThemeData(
                menuStyle: MenuStyle(
                  maximumSize:
                      WidgetStateProperty.all(const Size(double.infinity, 250)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
              hint: Text(
                "Select ${label.toLowerCase()}",
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              value: value,
              items: items.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select ${label.toLowerCase()}';
                }
                return null;
              },
              icon: const Icon(Icons.arrow_drop_down, size: 24),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(16),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Date"),
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (picked != null) {
              setState(() => selectedDate = picked);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                        : "Select date",
                    style: TextStyle(
                      color: selectedDate != null
                          ? Colors.black87
                          : Colors.black54,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.calendar_today, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
