import 'package:flutter/material.dart';

class ResourcesPage extends StatefulWidget {
  const ResourcesPage({super.key});

  @override
  State<ResourcesPage> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources'),
        backgroundColor: const Color(0xFF667EEA),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.withOpacity(0.1),
              Colors.indigo.withOpacity(0.1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mental Health Resources',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF667EEA),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Find help, support, and information about mental health',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),

              // Emergency Helplines
              _buildSectionTitle('🚨 Emergency Helplines'),
              _buildEmergencyCard(),
              const SizedBox(height: 24),

              // Professional Help
              _buildSectionTitle('👨‍⚕️ Professional Help'),
              _buildProfessionalHelpCards(),
              const SizedBox(height: 24),

              // Self-Help Resources
              _buildSectionTitle('📚 Self-Help Resources'),
              _buildSelfHelpCards(),
              const SizedBox(height: 24),

              // Support Groups
              _buildSectionTitle('👥 Support Groups'),
              _buildSupportGroupCards(),
              const SizedBox(height: 24),

              // Mental Health Apps
              _buildSectionTitle('📱 Recommended Apps'),
              _buildAppCards(),
              const SizedBox(height: 24),

              // Educational Content
              _buildSectionTitle('🎓 Educational Content'),
              _buildEducationCards(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF667EEA),
        ),
      ),
    );
  }

  Widget _buildEmergencyCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.red.withOpacity(0.8), Colors.red.withOpacity(0.6)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.emergency, color: Colors.white, size: 28),
                SizedBox(width: 12),
                Text(
                  'Crisis Support',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'If you\'re in immediate crisis or having thoughts of self-harm, please reach out right away:',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 16),
            _buildContactItem('📞', 'Emergency Services', '999 or 112'),
            _buildContactItem('📞', 'Crisis Helpline', '255 800 123 456'),
            _buildContactItem('💬', 'SMS Crisis Line', 'Text HOME to 741741'),
            const SizedBox(height: 8),
            const Text(
              'Available 24/7 - Free and confidential',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionalHelpCards() {
    return Column(
      children: [
        _buildResourceCard(
          'Find a Therapist',
          'Connect with licensed mental health professionals in your area',
          Icons.psychology,
          Colors.blue,
          () => _showTherapistDialog(context),
        ),
        const SizedBox(height: 12),
        _buildResourceCard(
          'Online Counseling',
          'Get professional help from the comfort of your home',
          Icons.computer,
          Colors.green,
          () => _showOnlineCounselingDialog(context),
        ),
        const SizedBox(height: 12),
        _buildResourceCard(
          'Psychiatric Services',
          'Find psychiatrists for medication management',
          Icons.medication,
          Colors.purple,
          () => _showPsychiatricDialog(context),
        ),
      ],
    );
  }

  Widget _buildSelfHelpCards() {
    return Column(
      children: [
        _buildResourceCard(
          'Meditation Guides',
          'Free guided meditation sessions for stress relief',
          Icons.self_improvement,
          Colors.teal,
          () => _showMeditationDialog(context),
        ),
        const SizedBox(height: 12),
        _buildResourceCard(
          'CBT Exercises',
          'Cognitive Behavioral Therapy techniques you can practice',
          Icons.psychology_alt,
          Colors.orange,
          () => _showCBTDialog(context),
        ),
        const SizedBox(height: 12),
        _buildResourceCard(
          'Sleep Resources',
          'Tips and tools for better sleep hygiene',
          Icons.bedtime,
          Colors.indigo,
          () => _showSleepDialog(context),
        ),
      ],
    );
  }

  Widget _buildSupportGroupCards() {
    return Column(
      children: [
        _buildResourceCard(
          'Local Support Groups',
          'Find in-person support groups in Tanzania',
          Icons.groups,
          Colors.pink,
          () => _showLocalGroupsDialog(context),
        ),
        const SizedBox(height: 12),
        _buildResourceCard(
          'Online Communities',
          'Connect with others experiencing similar challenges',
          Icons.forum,
          Colors.cyan,
          () => _showOnlineCommunitiesDialog(context),
        ),
      ],
    );
  }

  Widget _buildAppCards() {
    return Column(
      children: [
        _buildResourceCard(
          'Calm',
          'Meditation and sleep app',
          Icons.spa,
          Colors.green,
          () => _showAppInfo(context, 'Calm'),
        ),
        const SizedBox(height: 12),
        _buildResourceCard(
          'Headspace',
          'Guided meditation and mindfulness',
          Icons.bubble_chart,
          Colors.blue,
          () => _showAppInfo(context, 'Headspace'),
        ),
        const SizedBox(height: 12),
        _buildResourceCard(
          'Moodpath',
          'Mood tracking and mental health journal',
          Icons.mood,
          Colors.orange,
          () => _showAppInfo(context, 'Moodpath'),
        ),
      ],
    );
  }

  Widget _buildEducationCards() {
    return Column(
      children: [
        _buildResourceCard(
          'Mental Health 101',
          'Learn the basics of mental health and psychology',
          Icons.school,
          Colors.purple,
          () => _showEducationDialog(context),
        ),
        const SizedBox(height: 12),
        _buildResourceCard(
          'Understanding Depression',
          'Comprehensive guide to depression and treatment',
          Icons.psychology,
          Colors.blue,
          () => _showDepressionDialog(context),
        ),
        const SizedBox(height: 12),
        _buildResourceCard(
          'Anxiety Management',
          'Tools and techniques for managing anxiety',
          Icons.healing,
          Colors.green,
          () => _showAnxietyDialog(context),
        ),
      ],
    );
  }

  Widget _buildResourceCard(String title, String description, IconData icon, 
      Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF667EEA),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(String icon, String title, String contact) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  contact,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showTherapistDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Find a Therapist'),
        content: const Text(
          'To find a licensed therapist in Tanzania:\n\n'
          '1. Contact Muhimbili National Hospital\n'
          '2. Reach out to local mental health clinics\n'
          '3. Ask your primary care physician for referrals\n'
          '4. Check with university counseling centers\n\n'
          'You can also search online directories or contact the '
          'Tanzania Mental Health Association for recommendations.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showOnlineCounselingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Online Counseling'),
        content: const Text(
          'Popular online counseling platforms:\n\n'
          '• BetterHelp - Online therapy with licensed professionals\n'
          '• Talkspace - Text and video therapy sessions\n'
          '• 7 Cups - Free emotional support and counseling\n'
          '• iCounseling - Mental health support platform\n\n'
          'Many offer sliding scale fees or accept insurance.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showPsychiatricDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Psychiatric Services'),
        content: const Text(
          'For psychiatric medication management:\n\n'
          '• Muhimbili National Hospital - Psychiatry Department\n'
          '• Kilimanjaro Christian Medical Centre\n'
          '• Bugando Medical Centre\n'
          '• Regional hospitals across Tanzania\n\n'
          'Consultation required for prescription medications.\n'
          'Always seek professional medical advice.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showMeditationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Meditation Resources'),
        content: const Text(
          'Free meditation resources:\n\n'
          '• YouTube channels: Great Meditation, The Mindful Movement\n'
          '• Apps: Insight Timer (free version), Medito\n'
          '• Websites: UCLA Mindful Awareness Research Center\n'
          '• Podcasts: 10% Happier, Daily Calm\n\n'
          'Start with 5-10 minutes daily and gradually increase.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showCBTDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('CBT Exercises'),
        content: const Text(
          'Cognitive Behavioral Therapy techniques:\n\n'
          '• Thought records - Track negative thoughts\n'
          '• Behavioral activation - Schedule positive activities\n'
          '• Exposure therapy - Gradually face fears\n'
          '• Relaxation techniques - Progressive muscle relaxation\n'
          '• Problem-solving skills - Break down challenges\n\n'
          'Consider working with a therapist for best results.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSleepDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sleep Hygiene'),
        content: const Text(
          'Better sleep tips:\n\n'
          '• Maintain consistent sleep schedule\n'
          '• Create relaxing bedtime routine\n'
          '• Keep bedroom cool, dark, and quiet\n'
          '• Avoid screens 1 hour before bed\n'
          '• Limit caffeine after 2 PM\n'
          '• Exercise regularly but not close to bedtime\n'
          '• Avoid large meals before sleep',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLocalGroupsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Local Support Groups'),
        content: const Text(
          'Support groups in Tanzania:\n\n'
          '• Tanzania Mental Health Association\n'
          '• NAFG (National Association of the Families of the Mentally Ill)\n'
          '• Church and faith-based support groups\n'
          '• University counseling centers\n'
          '• Community health centers\n\n'
          'Contact local hospitals or mental health organizations '
          'for specific meeting times and locations.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showOnlineCommunitiesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Online Communities'),
        content: const Text(
          'Online mental health communities:\n\n'
          '• Reddit: r/mentalhealth, r/depression, r/anxiety\n'
          '• Facebook: Mental health support groups\n'
          '• 7 Cups: Free emotional support platform\n'
          '• HealthfulChats: Peer support network\n'
          '• Support Groups Central: Online meetings\n\n'
          'Remember: These are peer support, not professional help.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAppInfo(BuildContext context, String appName) {
    final Map<String, String> appInfo = {
      'Calm': 'Meditation, sleep stories, and relaxation exercises. Free trial available.',
      'Headspace': 'Guided meditation and mindfulness exercises. Free content available.',
      'Moodpath': 'Mood tracking with CBT-based exercises. 14-day free trial.',
    };

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(appName),
        content: Text(appInfo[appName] ?? 'Information about this app.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showEducationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mental Health 101'),
        content: const Text(
          'Key mental health concepts:\n\n'
          '• Mental health exists on a spectrum\n'
          '• 1 in 4 people experience mental health issues\n'
          '• Recovery is possible with proper treatment\n'
          '• Mental health affects physical health\n'
          '• Stigma prevents many from seeking help\n'
          '• Early intervention leads to better outcomes\n\n'
          'Learning about mental health helps you and others.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showDepressionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Understanding Depression'),
        content: const Text(
          'About depression:\n\n'
          '• More than just sadness - persistent low mood\n'
          '• Affects thoughts, feelings, and behaviors\n'
          '• Can be caused by biological, psychological, and social factors\n'
          '• Treatable with therapy, medication, or both\n'
          '• Warning signs: loss of interest, sleep changes, appetite changes\n'
          '• If symptoms last >2 weeks, seek professional help\n\n'
          'You\'re not alone - help is available.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAnxietyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Anxiety Management'),
        content: const Text(
          'Managing anxiety:\n\n'
          '• Deep breathing exercises\n'
          '• Progressive muscle relaxation\n'
          '• Mindfulness and meditation\n'
          '• Regular physical exercise\n'
          '• Limit caffeine and alcohol\n'
          '• Establish consistent sleep routine\n'
          '• Challenge negative thoughts\n'
          '• Practice self-compassion\n\n'
          'If anxiety interferes with daily life, seek professional help.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
