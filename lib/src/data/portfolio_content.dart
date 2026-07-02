import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../domain/portfolio_models.dart';

const List<Skill> skills = [
  Skill('Flutter', .96, AppTheme.mint),
  Skill('Dart', .94, AppTheme.sky),
  Skill('Firebase', .90, AppTheme.coral),
  Skill('REST APIs', .92, Color(0xFFF59E0B)),
  Skill('AI APIs', .88, AppTheme.violet),
  Skill('Clean Architecture', .95, Color(0xFF22C55E)),
];

const List<Project> projects = [
  Project(
    title: 'AI Resume Analyzer',
    description:
        'Recruiter-grade resume intelligence with scoring, gap analysis, keyword mapping, and role-fit suggestions powered by AI workflows.',
    stack: ['Flutter Web', 'Dart', 'AI APIs', 'Firebase'],
    accent: AppTheme.mint,
    metrics: ['92% match scoring', 'Realtime insights'],
    githubUrl: 'https://github.com/your-name/ai-resume-analyzer',
    demoUrl: 'https://your-name.dev/resume-analyzer',
  ),
  Project(
    title: 'Dealer AI App',
    description:
        'AI-assisted property discovery platform with smart listing enrichment, lead qualification, map-led search, and dealer dashboards.',
    stack: ['Flutter', 'Maps', 'REST APIs', 'Cloud Firestore'],
    accent: AppTheme.coral,
    metrics: ['Dealer CRM', 'AI listing copy'],
    githubUrl: 'https://github.com/your-name/property-dealer-ai',
    demoUrl: 'https://your-name.dev/property-ai',
  ),
  Project(
    title: 'Local Services Marketplace',
    description:
        'A scalable marketplace for nearby professionals with bookings, chat, provider onboarding, payments, and review workflows.',
    stack: ['Flutter', 'Firebase', 'Payments', 'Push'],
    accent: AppTheme.sky,
    metrics: ['Multi-vendor', 'Booking engine'],
    githubUrl: 'https://github.com/your-name/local-services-marketplace',
    demoUrl: 'https://your-name.dev/services',
  ),
  Project(
    title: 'AI Chatbot App',
    description:
        'Conversational mobile assistant with streaming responses, context memory, prompt presets, moderation, and clean state management.',
    stack: ['Flutter', 'Dart', 'LLM APIs', 'Riverpod'],
    accent: AppTheme.violet,
    metrics: ['Streaming chat', 'Prompt library'],
    githubUrl: 'https://github.com/your-name/ai-chatbot-app',
    demoUrl: 'https://your-name.dev/chatbot',
  ),
];

const List<TimelineEntry> timeline = [
  TimelineEntry(
    period: '2015 - 2018',
    title: 'Android Developer',
    description: 'Built production Android and cross-platform apps with strong release discipline and product intuition.',
  ),
  TimelineEntry(
    period: '2018 - 2021',
    title: 'Flutter Specialist',
    description: 'Led Flutter adoption, shipped complex app experiences, and shaped reusable UI and data layers.',
  ),
  TimelineEntry(
    period: '2021 - 2024',
    title: 'Senior Flutter Developer',
    description: 'Designed scalable architectures for marketplace, fintech, chat, and AI-assisted mobile products.',
  ),
  TimelineEntry(
    period: '2024 - Present',
    title: 'AI Product Engineer',
    description: 'Combines Flutter craft with AI APIs, automation, and analytics to deliver practical intelligent apps.',
  ),
];
