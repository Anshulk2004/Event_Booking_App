import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int numberOfTickets = 1;
  final double ticketPrice = 999.0;
  bool showTerms = false;

  final List<Map<String, String>> otherEvents = [
    {'name': 'EDM Night Fever', 'image': 'Images/party.jpg'},
    {'name': 'Bollywood Bash', 'image': 'Images/party.jpg'},
    {'name': 'Jazz Evening', 'image': 'Images/party.jpg'},
    {'name': 'Rock Concert', 'image': 'Images/party.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAboutSection(),
                        const SizedBox(height: 24),
                        _buildFeatureChips(),
                        const SizedBox(height: 20),
                        _buildTermsButton(),
                        const SizedBox(height: 32),
                        _buildTicketSection(),
                        const SizedBox(height: 20),
                        _buildOtherEventsSection(),
                        // const SizedBox(height: 20), 
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showTerms) _buildTermsModal(),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildTermsButton() {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () => setState(() => showTerms = true),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[400],
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        "Terms & Conditions",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

  Widget _buildHeader() {
    return Stack(
      children: [
        Hero(
          tag: 'eventImage',
          child: Container(
            height: MediaQuery.of(context).size.height / 2.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("Images/party.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBackButton(),
              _buildEventTitle(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventTitle() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withOpacity(0.8),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "New Year Party",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildHeaderChip(Icons.calendar_today, "1st January 2025"),
              const SizedBox(width: 12),
              _buildHeaderChip(Icons.location_on, "Pune, Maharashtra"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About Event",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        Text(
          "Join us for an unforgettable New Year's celebration featuring live music, gourmet dining, and spectacular fireworks. Experience the magic of midnight in an elegant setting with premium beverages, international cuisine, and entertainment that will keep you dancing until dawn. Our expert team has curated a perfect blend of sophistication and excitement for this special night.",
          style: TextStyle(
            color: Colors.black87,
            height: 1.6,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChips() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _buildInfoChip(Icons.person_outline, "Age 21+"),
        _buildInfoChip(Icons.access_time, "7 PM Onwards"),
        _buildInfoChip(Icons.location_on, "AK Club, Koregaon Park"),
        _buildInfoChip(Icons.timer, "8 Hours"),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.black87, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Tickets",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Number of Tickets",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  _buildTicketButton(
                    icon: Icons.remove,
                    onTap: () {
                      if (numberOfTickets > 1) {
                        setState(() => numberOfTickets--);
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      numberOfTickets.toString(),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildTicketButton(
                    icon: Icons.add,
                    onTap: () => setState(() => numberOfTickets++),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTicketButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildTermsModal() {
    return Container(

      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          // width: double.infinity,
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.8,),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Terms & Conditions",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => showTerms = false),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
               Expanded(
              child: SingleChildScrollView(
                child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildTermItem(
                        "1",
                        "All tickets are non-refundable and non-transferable once purchased. Please ensure you have selected the correct event and ticket quantity before confirming your booking."
                      ),
                      _buildTermItem(
                        "2",
                        "Entry to the event is restricted to individuals aged 21 and above. Valid government-issued photo identification is required for entry."
                      ),
                      _buildTermItem(
                        "3",
                        "The organizers reserve the right to refuse entry or remove any person from the venue who does not comply with the event rules or exhibits disruptive behavior."
                      ),
                      _buildTermItem(
                        "4",
                        "Photography and videography for personal use are permitted. Commercial photography or recording is strictly prohibited without prior written consent."
                      ),
                      _buildTermItem(
                        "5",
                        "In case of event cancellation due to unforeseen circumstances, ticket holders will be eligible for a full refund of the ticket value within 7 working days."
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTermItem(String number, String content) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$number.",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            content,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              height: 1.5,
              fontSize: 15,
            ),
          ),
        ),
      ],
    ),
  );
}
  

  Widget _buildOtherEventsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Other Events",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          "Happening in Pune",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: otherEvents.length,
            itemBuilder: (context, index) {
              return Container(
                width: 160,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.asset(
                        otherEvents[index]['image']!,
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        otherEvents[index]['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Total Amount",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              Text(
                "₹${(ticketPrice * numberOfTickets).toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: const Text(
                "Book Now",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}