import 'package:event_planning/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:event_planning/models/event_model.dart';
import 'package:event_planning/utils/app_styles.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String selectedType = 'Sport';

  final List<String> eventTypes = [
    'Sport',
    'Birthday',
    'Meeting',
    'Exhibition',
  ];

  final Map<String, String> typeToImage = {
    'Sport': 'assets/images/sport.png',
    'Birthday': 'assets/images/birthday.png',
    'Meeting': 'assets/images/meeting.png',
    'Exhibition': 'assets/images/exhibition.png',
  };

  final Map<String, IconData> typeToIcon = {
    'Sport': Icons.sports_soccer,
    'Birthday': Icons.cake,
    'Meeting': Icons.business_center,
    'Exhibition': Icons.event,
  };

  void _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (date != null) setState(() => selectedDate = date);
  }

  void _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => selectedTime = time);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      final finalDate = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      final event = EventModel(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        imagePath: typeToImage[selectedType]!,
        date: finalDate,
        type: selectedType,
      );

      Navigator.pop(context, event);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Event", style: AppStyles.bold20Primary),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primaryLight),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              /// 🔹 Type Image Banner
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  typeToImage[selectedType]!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              /// 🔹 Type Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: eventTypes.map((type) {
                    final isSelected = selectedType == type;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(type),
                        selected: isSelected,
                        onSelected: (_) => setState(() => selectedType = type),
                        selectedColor: AppColors.primaryLight,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : color.onBackground,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),
              Text("Title", style: AppStyles.bold14Primary),

              /// 🔹 Title
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Event Title",
                  prefixIcon: Icon(Icons.edit, color: AppColors.primaryLight),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a title'
                    : null,
              ),
              const SizedBox(height: 12),
              Text("Description", style: AppStyles.bold14Primary),

              /// 🔹 Title
              /// 🔹 Description
              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Event Description",
                  alignLabelWithHint: true,
                  prefixIcon: Icon(
                    Icons.description,
                    color: AppColors.primaryLight,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a description'
                    : null,
              ),
              const SizedBox(height: 20),

              /// 🔹 Date Picker
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.calendar_today,
                  color: AppColors.primaryLight,
                ),
                title: Text("Event Date"),
                trailing: Text(
                  selectedDate == null
                      ? 'Select Date'
                      : DateFormat('dd/MM/yyyy').format(selectedDate!),
                  style: AppStyles.bold16Primary,
                ),
                onTap: _pickDate,
              ),

              /// 🔹 Time Picker
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.access_time, color: AppColors.primaryLight),
                title: Text("Event Time"),
                trailing: Text(
                  selectedTime == null
                      ? 'Select Time'
                      : selectedTime!.format(context),
                  style: AppStyles.bold16Primary,
                ),
                onTap: _pickTime,
              ),

              const SizedBox(height: 30),

              /// 🔹 Location Picker (UI Only for Now)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Location", style: AppStyles.bold16Primary),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      // Placeholder: no functionality yet
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blue.withOpacity(0.05),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.my_location,
                              color: Color.fromARGB(255, 223, 221, 230),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Choose Event Location",
                              style: AppStyles.bold16Primary,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Color.fromARGB(255, 8, 60, 232),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              const SizedBox(height: 30),

              /// 🔹 Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryLight,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("Add Event", style: AppStyles.bold16White),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
