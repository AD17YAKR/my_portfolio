import 'package:flutter/material.dart';

class Config {
  static CrazySectionConfig crazySection = CrazySectionConfig(
    profileImagePath: 'assets/profile.jpg',
    expandedBio: """
🚀 Full-stack developer with expertise in Spring Boot and Flutter
📱 1.5+ years experience building scalable mobile & web applications
💡 Passionate about clean architecture and efficient state management
🔧 Technical lead for multiple enterprise-level projects
🎯 Open source contributor & tech community mentor
    """,
    specialSkills: {
      "Spring Boot Architecture": Colors.teal,
      "Flutter Development": Colors.amber,
      "Cloud Integration": Colors.purple,
      "CI/CD Pipelines": Colors.blue,
    },
    socialButtons: [
      SocialButtonConfig(
        icon: Icons.code,
        label: "GitHub",
        url: links['GitHub']!,
      ),
      SocialButtonConfig(
        icon: Icons.work,
        label: "LinkedIn",
        url: links['LinkedIn']!,
      ),
      SocialButtonConfig(
        icon: Icons.article,
        label: "LeetCode",
        url: links['LeetCode']!,
      ),
    ],
  );
  // Personal Information
  static const String name = "Aditya Kumar Singh";
  static const String title = "Software Engineer";
  static const String contact = "+91 6290949425 | adityasingh.110601@gmail.com";
  static const String location = "Kolkata, India";

  // Profile Summary
  static const String summary = """
Experienced Software Engineer with expertise in developing large-scale systems using Spring Boot.
Skilled in resolving complex issues, integrating user feedback, and enhancing application performance.
Committed to delivering high-quality, well-documented systems with proven leadership in managing
project deliverables and technology implementations.
  """;
  static const String aboutMe = """
Experienced Software Engineer with expertise in developing large-scale systems using Spring Boot.
Skilled in resolving complex issues, integrating user feedback, and enhancing application performance.
Committed to delivering high-quality, well-documented systems with proven leadership in managing
project deliverables and technology implementations.
  """;

  // Professional Links
  static const Map<String, String> links = {
    "LinkedIn": "https://linkedin.com/in/...",
    "GitHub": "https://github.com/...",
    "LeetCode": "https://leetcode.com/..."
  };

  // Professional Experience
  static const List<Experience> experiences = [
    Experience(
        company: "Accenture",
        role: "Associate Software Engineer",
        duration: "Apr '24 — Present",
        location: "Kolkata, India",
        achievements: [
          "Automated Salesforce data migration, reducing time by 75%",
          "Developed in-house CRM email solution with Spring Boot/SendGrid",
          "Created RESTful APIs/microservices saving \$45k annually",
          "Implemented CI/CD pipelines and database migrations"
        ],
        techStack: {
          "Spring Boot",
          "Salesforce",
          "ORM",
          "CI/CD"
        }),
    Experience(
        company: "EzeRx (Sun Pharma Affiliated)",
        role: "Mobile App Developer",
        duration: "Sep '23 — Mar '24",
        location: "Kolkata, India",
        achievements: [
          "Reduced server costs by 70% through Python integration",
          "Improved app performance by 30% via optimization",
          "Awarded Employee of the Month (Dec '23)",
          "Pioneered iOS development with cross-platform sync"
        ],
        techStack: {
          "Flutter",
          "Python",
          "iOS",
          "Cross-Platform"
        }),
    Experience(
        company: "Locofast",
        role: "Software Engineering Intern",
        duration: "Sep '22 — Dec '22",
        location: "New Delhi, India",
        achievements: [
          "Built email auth system with AWS SES/NestJS/Redis",
          "Enhanced cloud-based eCommerce supply chain system",
          "Implemented RDBMS solutions for scalability"
        ],
        techStack: {
          "AWS",
          "NestJS",
          "Redis",
          "RDBMS"
        })
  ];

  // Education
  static const Education education = Education(
      degree: "B.Tech in Computer Science and Engineering",
      institution: "Purulia Government Engineering College",
      duration: "Aug '19 — Jun '23",
      gpa: 9.18,
      location: "India");

  // Technical Skills
  static const Map<String, List<String>> skills = {
    "Programming Languages": ["C++", "Java", "Python", "Dart"],
    "Frameworks": ["Spring Boot", "Flutter", "Hibernate", "Spring Security"],
    "Databases": ["MySQL", "MongoDB", "PostgreSQL"],
    "Tools & Cloud": ["AWS", "Docker", "Git", "CI/CD"],
    "Coursework": [
      "Data Structures & Algorithms",
      "DBMS",
      "Computer Networks",
      "Operating Systems"
    ]
  };

  static const List<Project> projects = [
    Project(
        name: "PaperFlow",
        description: "Full Stack PDF Management Collaboration System",
        techStack: {"Nest.js", "MongoDB", "Flutter", "AWS S3"},
        achievements: [
          "Built mobile app with OAuth integration",
          "Implemented PDF storage using S3 buckets",
          "Developed REST APIs for document management"
        ],
        link: "https://paperflow.example.com"),
    Project(
        name: "Bengali Sign Language Recognition",
        description: "ML model for BSL gesture recognition",
        techStack: {
          "Python",
          "TensorFlow",
          "OpenCV"
        },
        achievements: [
          "Developed custom CNN architecture",
          "Achieved 95% recognition accuracy",
          "Optimized for real-time performance"
        ])
  ];

  // Achievements
  static const List<String> achievements = [
    "Ranked 91st in GeeksforGeeks Weekly Coding Contest 98",
    "LeetCode Highest Rating: 1768 (Top 10%)",
    "Solved 600+ coding problems across platforms",
    "Employee of the Month (EzeRx, Dec '23)"
  ];
}

// Data Models
class Experience {
  final String company;
  final String role;
  final String duration;
  final String location;
  final List<String> achievements;
  final Set<String> techStack;

  const Experience(
      {required this.company,
      required this.role,
      required this.duration,
      required this.location,
      required this.achievements,
      required this.techStack});
}

class Project {
  final String name;
  final String description;
  final Set<String> techStack;
  final List<String> achievements;
  final String? link;

  const Project(
      {required this.name,
      required this.description,
      required this.techStack,
      required this.achievements,
      this.link});
}

class Education {
  final String degree;
  final String institution;
  final String duration;
  final double gpa;
  final String location;

  const Education(
      {required this.degree,
      required this.institution,
      required this.duration,
      required this.gpa,
      required this.location});
}

// Add these new data models at the bottom of config.dart
class CrazySectionConfig {
  final String profileImagePath;
  final String expandedBio;
  final Map<String, Color> specialSkills;
  final List<SocialButtonConfig> socialButtons;

  const CrazySectionConfig({
    required this.profileImagePath,
    required this.expandedBio,
    required this.specialSkills,
    required this.socialButtons,
  });
}

class SocialButtonConfig {
  final IconData icon;
  final String label;
  final String url;

  const SocialButtonConfig({
    required this.icon,
    required this.label,
    required this.url,
  });
}
