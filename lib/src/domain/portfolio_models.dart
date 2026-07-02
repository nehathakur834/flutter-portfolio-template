import 'package:flutter/material.dart';

class Skill {
  const Skill(this.name, this.value, this.color);

  final String name;
  final double value;
  final Color color;
}

class Project {
  const Project({
    required this.title,
    required this.description,
    required this.stack,
    required this.accent,
    required this.metrics,
    required this.githubUrl,
    required this.demoUrl,
  });

  final String title;
  final String description;
  final List<String> stack;
  final Color accent;
  final List<String> metrics;
  final String githubUrl;
  final String demoUrl;
}

class TimelineEntry {
  const TimelineEntry({
    required this.period,
    required this.title,
    required this.description,
  });

  final String period;
  final String title;
  final String description;
}
