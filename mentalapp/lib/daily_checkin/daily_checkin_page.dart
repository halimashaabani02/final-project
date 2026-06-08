import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyCheckinPage extends StatefulWidget {
  const DailyCheckinPage({super.key});

  @override
  State<DailyCheckinPage> createState() => _DailyCheckinPageState();
}

class CheckinEntry {
  final DateTime date;
  final String mood;
  final int energy;
  final int sleep;
  final int stress;
  final String gratitude;
  final List<String> activities;
  final String notes;

  CheckinEntry({
    required this.date,
    required this.mood,
    required this.energy,
    required this.sleep,
    required this.stress,
    required this.gratitude,
    required this.activities,
    required this.notes,
  });
}

class _DailyCheckinPageState extends State<DailyCheckinPage> {
  final List<CheckinEntry> _checkinHistory = [];
  String? _selectedMood;
  int _energyLevel = 3;
  int _sleepHours = 7;
  int _stressLevel = 3;
  final TextEditingController _gratitudeController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final List<String> _selectedActivities = [];
  
  final List<Map<String, dynamic>> _moodOptions = [
    {'emoji': '😊', 'label': 'Great', 'color': Colors.green},
    {'emoji': '😌', 'label': 'Good', 'color': Colors.lightGreen},
    {'emoji': '😐', 'label': 'Okay', 'color': Colors.yellow},
    {'emoji': '😔', 'label': 'Low', 'color': Colors.orange},
    {'emoji': '😰', 'label': 'Struggling', 'color': Colors.red},
  ];

  final List<String> _activityOptions = [
    'Exercise',
    'Meditation',
    'Reading',
    'Social time',
    'Nature walk',
    'Creative hobby',
    'Healthy eating',
    'Good sleep',
    'Journaling',
    'Music/Art',
  ];

  bool _hasCheckedInToday() {
    if (_checkinHistory.isEmpty) return false;
    final today = DateTime.now();
    final lastCheckin = _checkinHistory.first.date;
    return today.year == lastCheckin.year &&
           today.month == lastCheckin.month &&
           today.day == lastCheckin.day;
  }

  void _saveCheckin() {
    if (_selectedMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your mood')),
      );
      return;
    }

    final moodOption = _moodOptions.firstWhere((mood) => mood['emoji'] == _selectedMood);
    final entry = CheckinEntry(
      date: DateTime.now(),
      mood: moodOption['label'],
      energy: _energyLevel,
      sleep: _sleepHours,
      stress: _stressLevel,
      gratitude: _gratitudeController.text,
      activities: List.from(_selectedActivities),
      notes: _notesController.text,
    );

    setState(() {
      _checkinHistory.insert(0, entry);
      _resetForm();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Daily check-in saved successfully!')),
    );
  }

  void _resetForm() {
    _selectedMood = null;
    _energyLevel = 3;
    _sleepHours = 7;
    _stressLevel = 3;
    _gratitudeController.clear();
    _notesController.clear();
    _selectedActivities.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Check-in'),
        backgroundColor: const Color(0xFF667EEA),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange.withOpacity(0.1),
              Colors.pink.withOpacity(0.1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_hasCheckedInToday())
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green),
                  ),
                  child: const Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green),
                      const SizedBox(width: 8),
                      const Text(
                        'You\'ve already checked in today!',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              
              const Text(
                'How are you feeling today?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF667EEA),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Take a moment to reflect on your day',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),

              // Mood Selection
              _buildSectionTitle('Current Mood'),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _moodOptions.length,
                  itemBuilder: (context, index) {
                    final mood = _moodOptions[index];
                    final isSelected = _selectedMood == mood['emoji'];
                    
                    return GestureDetector(
                      onTap: () {
                        if (!_hasCheckedInToday()) {
                          setState(() {
                            _selectedMood = mood['emoji'];
                          });
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? mood['color'] : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? mood['color'] : Colors.grey.shade300,
                            width: isSelected ? 3 : 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              mood['emoji'],
                              style: const TextStyle(fontSize: 24),
                            ),
                            Text(
                              mood['label'],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Energy Level
              _buildSliderSection('Energy Level', _energyLevel.toDouble(), 1, 5, (value) {
                if (!_hasCheckedInToday()) {
                  setState(() {
                    _energyLevel = value.toInt();
                  });
                }
              }, 'Very Low', 'Very High'),
              
              // Sleep Hours
              _buildSliderSection('Sleep Hours', _sleepHours.toDouble(), 0, 12, (value) {
                if (!_hasCheckedInToday()) {
                  setState(() {
                    _sleepHours = value.toInt();
                  });
                }
              }, '0h', '12h'),
              
              // Stress Level
              _buildSliderSection('Stress Level', _stressLevel.toDouble(), 1, 5, (value) {
                if (!_hasCheckedInToday()) {
                  setState(() {
                    _stressLevel = value.toInt();
                  });
                }
              }, 'Very Low', 'Very High'),
              
              const SizedBox(height: 24),

              // Gratitude
              _buildSectionTitle('What are you grateful for today?'),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _gratitudeController,
                  maxLines: 3,
                  enabled: !_hasCheckedInToday(),
                  decoration: InputDecoration(
                    hintText: 'I\'m grateful for...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Activities
              _buildSectionTitle('What did you do today?'),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _activityOptions.map((activity) {
                  final isSelected = _selectedActivities.contains(activity);
                  return FilterChip(
                    label: Text(activity),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (!_hasCheckedInToday()) {
                        setState(() {
                          if (selected) {
                            _selectedActivities.add(activity);
                          } else {
                            _selectedActivities.remove(activity);
                          }
                        });
                      }
                    },
                    backgroundColor: Colors.white,
                    selectedColor: const Color(0xFF667EEA).withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: isSelected ? const Color(0xFF667EEA) : Colors.grey.shade700,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Additional Notes
              _buildSectionTitle('Additional Notes (Optional)'),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _notesController,
                  maxLines: 3,
                  enabled: !_hasCheckedInToday(),
                  decoration: InputDecoration(
                    hintText: 'Anything else you\'d like to note...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Save Button
              if (!_hasCheckedInToday())
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveCheckin,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Save Check-in',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              const SizedBox(height: 32),

              // History
              if (_checkinHistory.isNotEmpty) ...[
                const Text(
                  'Your Check-in History',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF667EEA),
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _checkinHistory.length,
                  itemBuilder: (context, index) {
                    final entry = _checkinHistory[index];
                    return _buildHistoryCard(entry);
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF667EEA),
        ),
      ),
    );
  }

  Widget _buildSliderSection(String title, double value, double min, double max, 
      Function(double) onChanged, String minLabel, String maxLabel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(minLabel, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(
              value.toInt().toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF667EEA),
              ),
            ),
            Text(maxLabel, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          activeColor: const Color(0xFF667EEA),
          onChanged: onChanged,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildHistoryCard(CheckinEntry entry) {
    final moodOption = _moodOptions.firstWhere((mood) => mood['label'] == entry.mood);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                moodOption['emoji'],
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 8),
              Text(
                entry.mood,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF667EEA),
                ),
              ),
              const Spacer(),
              Text(
                DateFormat('MMM d, yyyy').format(entry.date),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildMetricChip('Energy', entry.energy, 5),
              const SizedBox(width: 8),
              _buildMetricChip('Sleep', entry.sleep, 12),
              const SizedBox(width: 8),
              _buildMetricChip('Stress', entry.stress, 5),
            ],
          ),
          if (entry.gratitude.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'Grateful: ${entry.gratitude}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
          if (entry.activities.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              children: entry.activities.map((activity) => 
                Chip(
                  label: Text(activity, style: const TextStyle(fontSize: 10)),
                  backgroundColor: const Color(0xFF667EEA).withOpacity(0.1),
                )
              ).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMetricChip(String label, int value, int max) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF667EEA).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$label: $value/$max',
        style: const TextStyle(fontSize: 12, color: Color(0xFF667EEA)),
      ),
    );
  }
}
