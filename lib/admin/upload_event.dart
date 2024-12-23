import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UploadEvent extends StatefulWidget {
  const UploadEvent({super.key});

  @override
  State<UploadEvent> createState() => _UploadEventState();
}

class _UploadEventState extends State<UploadEvent> {
  String? selectedCategory;
  String? selectedAgeLimit;
  String? selectedTime;
  DateTime? selectedDate;
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController organizedByController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  final List<String> categories = [
    'Fashion Shows',
    'Comedy Shows',
    'Movies',
    'Party',
    'Musical Shows'
  ];

  final List<String> ageLimits = [
    '5+',
    '8+',
    '10+',
    '12+',
    '14+',
    '16+',
    '18+'
  ];

  List<String> generateTimeList() {
    List<String> times = [];
    for (int i = 0; i < 24; i++) {
      String hour = i.toString().padLeft(2, '0');
      times.add('$hour:00');
    }
    return times;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
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
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                top: 40.0, left: 20.0, right: 20.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 40,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(Icons.arrow_back_ios_new_outlined),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(right: 40),
                        child: Text(
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
                ),
                SizedBox(height: 30.0),

                // Event Image
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 2.0),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
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

                SizedBox(height: 30.0),

                // Event Category
                _buildLabel("Event Category"),
                _buildDropdownField(
                  hint: "Select category",
                  value: selectedCategory,
                  items: categories,
                  onChanged: (value) =>
                      setState(() => selectedCategory = value),
                ),

                SizedBox(height: 20.0),

                // Organized By and Date Row
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Organized By"),
                    _buildInputField(
                      controller: organizedByController,
                      hint: "Enter organizer",
                    ),
                    SizedBox(height: 20.0),

                    // Date
                    _buildLabel("Date"),
                    _buildDateField(),
                    SizedBox(height: 20.0),

                    // Age Limit
                    _buildLabel("Age Limit"),
                    _buildDropdownField(
                      hint: "Select age",
                      value: selectedAgeLimit,
                      items: ageLimits,
                      onChanged: (value) =>
                          setState(() => selectedAgeLimit = value),
                    ),

                    SizedBox(height: 20.0),

                    // Time
                    _buildLabel("Time"),
                    _buildDropdownField(
                      hint: "Select time",
                      value: selectedTime,
                      items: generateTimeList(),
                      onChanged: (value) =>
                          setState(() => selectedTime = value),
                    ),
                  ],
                ),

                SizedBox(height: 20.0),

                // Ticket Price
                _buildLabel("Ticket Price"),
                _buildInputField(
                  controller: priceController,
                  hint: "Enter ticket price",
                  // prefix: "",
                ),
                SizedBox(height: 20.0),

                // Event Details
                _buildLabel("Event Details"),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: detailsController,
                    maxLines: 4,
                    maxLength: 200,
                    decoration: InputDecoration(                      
                      border: InputBorder.none,
                      hintText: "Enter Details",hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                      counterText: "Maximum 200 words",
                    ),
                  ),
                ),
                SizedBox(height: 20.0),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle submit
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2196F3),
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        );
        if (picked != null) {
          setState(() => selectedDate = picked);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
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
                  color: selectedDate != null ? Colors.black87 : Colors.black54,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.calendar_today, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    String? prefix,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14,color: Colors.black54),
          prefixText: prefix,
          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
        ),
        style: TextStyle(fontSize: 16,),
      ),
    );
  }

  Widget _buildDropdownField({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
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
              maximumSize: WidgetStateProperty.all(Size(double.infinity, 250)),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(
              hint,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
            value: value,
            items: items.map((String item) {
              return DropdownMenuItem(
                value: item,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            icon: Icon(Icons.arrow_drop_down, size: 24),
            dropdownColor: Colors.white,
            menuMaxHeight: 250,
            borderRadius: BorderRadius.circular(16),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
