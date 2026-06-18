// lib/utils/constants.dart
import 'package:flutter/material.dart';

// ── FlowForge palette: forge dark + molten orange path ──────────────────
const Color kBg          = Color(0xFF14110E);
const Color kSurface     = Color(0xFF221C16);
const Color kBorder      = Color(0xFF3E342A);
const Color kAccent      = Color(0xFFFF9D3D); // molten orange
const Color kCell        = Color(0xFF1E1812);
const Color kCellEdge    = Color(0xFF3A2F24);
const Color kPath        = Color(0xFFFFB454);
const Color kPathGlow    = Color(0xFFFF7A1A);
const Color kStart       = Color(0xFF4ECDC4);
const Color kEnd         = Color(0xFFFF5C8A);
const Color kTextPrimary = Color(0xFFF6EEE4);
const Color kTextDim     = Color(0xFFA8967E);

const Color kStarOn  = Color(0xFFFFD54F);
const Color kStarOff = Color(0xFF332A20);

const Color kEasyColor   = Color(0xFF4ECDC4);
const Color kMediumColor = Color(0xFFFFB454);
const Color kHardColor   = Color(0xFFFF7043);

const int kTotalLevels = 150;

TextStyle techno(double size,
        {Color color = kTextPrimary,
        FontWeight weight = FontWeight.bold,
        double letterSpacing = 1.5}) =>
    TextStyle(
        fontSize: size, color: color, fontWeight: weight,
        letterSpacing: letterSpacing);
