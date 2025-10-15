import 'package:event_planning/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:event_planning/models/event_model.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:event_planning/services/firestore_service.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String selectedType = 'Sport';

  bool _saving = false;

  final List<String> eventTypes = const [
    'Sport',
    'Birthday',
    'Meeting',
    'Exhibition',
  ];

  final Map<String, String> typeToImage = const {
    'Sport': 'assets/images/sport.png',
    'Birthday': 'assets/images/birthday.png',
    'Meeting': 'assets/images/meeting.png',
    'Exhibition': 'assets/images/exhibition.png',
  };

  final Map<String, IconData> typeToIcon = const {
    'Sport': Icons.sports_soccer,
    'Birthday': Icons.cake,
    'Meeting': Icons.business_center,
    'Exhibition': Icons.event,
  };

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2035),
    );
    if (date != null) setState(() => selectedDate = date);
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => selectedTime = time);
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedDate == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please select a date')));
      return;
    }
    if (selectedTime == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please select a time')));
      return;
    }

    final finalDate = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    setState(() => _saving = true);
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw Exception('User not logged in');

      final event = EventModel(
        id: 'temp', // سيُستبدل بـ doc.id عند القراءة
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        date: finalDate,
        type: selectedType,
        imagePath: typeToImage[selectedType] ?? 'assets/images/birthday.png',
        isSaved: false,
        ownerId: uid,
      );

      await FirestoreService.addEvent(event);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event added successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
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

              // اختيار النوع
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: eventTypes.map((type) {
                    final isSelected = selectedType == type;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        avatar: Icon(
                          typeToIcon[type],
                          size: 18,
                          color: isSelected ? Colors.white : color.onBackground,
                        ),
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

              // العنوان
              Text("Title", style: AppStyles.bold14Primary),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Event Title",
                  prefixIcon: Icon(Icons.edit, color: AppColors.primaryLight),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) =>
                (value == null || value.trim().isEmpty)
                    ? 'Please enter a title'
                    : null,
              ),
              const SizedBox(height: 12),

              // الوصف
              Text("Description", style: AppStyles.bold14Primary),
              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Event Description",
                  alignLabelWithHint: true,
                  prefixIcon:
                  Icon(Icons.description, color: AppColors.primaryLight),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) =>
                (value == null || value.trim().isEmpty)
                    ? 'Please enter a description'
                    : null,
              ),
              const SizedBox(height: 20),

              // التاريخ
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.calendar_today, color: AppColors.primaryLight),
                title: const Text("Event Date"),
                trailing: Text(
                  selectedDate == null
                      ? 'Select Date'
                      : DateFormat('dd/MM/yyyy').format(selectedDate!),
                  style: AppStyles.bold16Primary,
                ),
                onTap: _pickDate,
              ),

              // الوقت
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.access_time, color: AppColors.primaryLight),
                title: const Text("Event Time"),
                trailing: Text(
                  selectedTime == null
                      ? 'Select Time'
                      : selectedTime!.format(context),
                  style: AppStyles.bold16Primary,
                ),
                onTap: _pickTime,
              ),
              const SizedBox(height: 30),

              // (Placeholder) اختيار الموقع
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Location", style: AppStyles.bold16Primary),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      // TODO: اختر الموقع لاحقًا
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
                              color: Color(0xFFDfDDE6),
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
                          const Icon(Icons.chevron_right, color: Color(0xFF083CE8)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // زر إضافة الحدث
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saving ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryLight,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _saving
                      ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : Text("Add Event", style: AppStyles.bold16White),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
