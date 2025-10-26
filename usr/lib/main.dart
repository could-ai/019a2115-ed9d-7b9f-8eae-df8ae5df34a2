import 'package:flutter/material.dart';
import 'dart:ui';

// Define the colors from the CSS variables for easy access and consistency.
const Color bgColor = Color(0xFF0B0F12);
const Color cardColor = Color(0xFF0F1720);
const Color accent1Color = Color(0xFF2AF598);
const Color accent2Color = Color(0xFF00B09B);
const Color mutedColor = Color(0xFF98A0A6);
const Color glassColor = Color.fromRGBO(255, 255, 255, 0.04);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Fire Panel Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF07121a),
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFFe6eef0)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const GreenFirePanelPage(),
    );
  }
}

class GreenFirePanelPage extends StatelessWidget {
  const GreenFirePanelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF031018), Color(0xFF07121a)],
            stops: [0.0, 0.6],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1 - 200,
              left: MediaQuery.of(context).size.width * 0.1 - 400,
              child: Container(
                width: 800,
                height: 400,
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Color.fromRGBO(42, 245, 152, 0.04),
                      Colors.transparent
                    ],
                    stops: [0.1, 1.0],
                  ),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    bool isWide = constraints.maxWidth > 880;
                    return GlassmorphicPanel(
                      isWide: isWide,
                      child: isWide
                          ? const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 320, child: LeftColumn()),
                                SizedBox(width: 18),
                                Expanded(
                                    flex: 642, child: RightColumn()),
                              ],
                            )
                          : const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                LeftColumn(),
                                SizedBox(height: 18),
                                RightColumn(),
                              ],
                            ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GlassmorphicPanel extends StatelessWidget {
  final Widget child;
  final bool isWide;

  const GlassmorphicPanel({super.key, required this.child, required this.isWide});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          width: 980,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromRGBO(255, 255, 255, 0.02),
                const Color.fromRGBO(255, 255, 255, 0.01),
              ],
            ),
            border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.03)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 40,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class LeftColumn extends StatelessWidget {
  const LeftColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color.fromRGBO(10, 18, 20, 0.6),
            const Color.fromRGBO(8, 12, 14, 0.6),
          ],
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlayerCard(),
          SizedBox(height: 18),
          QuickNotes(),
          SizedBox(height: 12),
          FooterButtons(),
        ],
      ),
    );
  }
}

class PlayerCard extends StatelessWidget {
  const PlayerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: -56,
          top: -56,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.4, -0.5),
                colors: [
                  accent1Color.withOpacity(0.12),
                  Colors.transparent,
                ],
                stops: const [0.1, 1.0],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  center: Alignment.center,
                  startAngle: 2.09, // 120deg
                  colors: [
                    accent2Color.withOpacity(0.15),
                    accent1Color.withOpacity(0.06),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PlayerAvatar(),
                SizedBox(width: 12),
                Expanded(child: PlayerInfo()),
              ],
            ),
            SizedBox(height: 8),
            PlayerStats(),
          ],
        ),
      ],
    );
  }
}

class PlayerAvatar extends StatelessWidget {
  const PlayerAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.04), width: 2),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0b1012), Color(0xFF0b1b1a)],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          'https://i.pravatar.cc/300?img=12',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PlayerInfo extends StatelessWidget {
  const PlayerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Asif Molla',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 0.2),
        ),
        SizedBox(height: 6),
        Text(
          'Level 48 · Diamond · 🇧🇩',
          style: TextStyle(fontSize: 13, color: mutedColor),
        ),
      ],
    );
  }
}

class PlayerStats extends StatelessWidget {
  const PlayerStats({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: StatItem(label: 'K/D', value: '3.2')),
        SizedBox(width: 8),
        Expanded(child: StatItem(label: 'Wins', value: '124')),
        SizedBox(width: 8),
        Expanded(child: StatItem(label: 'Rank', value: '2120')),
      ],
    );
  }
}

class StatItem extends StatelessWidget {
  final String label;
  final String value;

  const StatItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: glassColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: mutedColor)),
        ],
      ),
    );
  }
}

class QuickNotes extends StatelessWidget {
  const QuickNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick notes', style: TextStyle(fontSize: 13, color: mutedColor)),
        SizedBox(height: 8),
        Text(
          'Customize buttons, toggle effects, and connect to backend later. This panel is only UI demo.',
          style: TextStyle(fontSize: 13, color: Color(0xFFDFF6EE), height: 1.35),
        ),
      ],
    );
  }
}

class FooterButtons extends StatelessWidget {
  const FooterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ActionButton(
            label: 'Export Image',
            onPressed: () => _showToast(context, 'Exporting image...'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ActionButton(
            label: 'Download JSON',
            onPressed: () => _showToast(context, 'Downloaded JSON'),
            isPrimary: false,
          ),
        ),
      ],
    );
  }
}

class RightColumn extends StatefulWidget {
  const RightColumn({super.key});

  @override
  State<RightColumn> createState() => _RightColumnState();
}

class _RightColumnState extends State<RightColumn> {
  bool _autoAim = false;
  double _sensitivity = 50;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ControlsGrid(),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.01),
                Colors.white.withOpacity(0.02),
              ],
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Auto Aim (Demo)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      SizedBox(height: 2),
                      Text('এইটা শুধু UI দেখায় — চিট নয়', style: TextStyle(fontSize: 12, color: mutedColor)),
                    ],
                  ),
                  CustomSwitch(
                    value: _autoAim,
                    onChanged: (value) {
                      setState(() => _autoAim = value);
                      _showToast(context, 'Auto Aim ${value ? "ON" : "OFF"}');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sensitivity', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  Row(
                    children: [
                      SizedBox(
                        width: 160,
                        child: CustomSlider(
                          value: _sensitivity,
                          onChanged: (value) => setState(() => _sensitivity = value),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 28,
                        child: Text(
                          _sensitivity.round().toString(),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Theme Glow', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  ActionButton(
                    label: 'Toggle',
                    onPressed: () => _showToast(context, 'Toggling theme glow...'),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Demo notes: replace avatar URL, button actions, and wire to backend APIs if you need real functionality.',
          style: TextStyle(fontSize: 13, color: mutedColor),
        ),
      ],
    );
  }
}

class ControlsGrid extends StatelessWidget {
  const ControlsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth < 400 ? 2 : 3;
        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
          children: const [
            ControlItem(icon: '💉', title: 'Heal', desc: 'Auto med-kit', action: 'heal'),
            ControlItem(icon: '🛡️', title: 'Armor', desc: 'Equip vest', action: 'armor'),
            ControlItem(icon: '⚡', title: 'Boost', desc: 'Speed buff', action: 'boost'),
            ControlItem(icon: '🤖', title: 'Bot Assist', desc: 'Toggle AI demo', action: 'bot'),
            ControlItem(icon: '🗺️', title: 'Map', desc: 'Open map', action: 'map'),
            ControlItem(icon: '⚙️', title: 'More', desc: 'Open settings', action: 'settings'),
          ],
        );
      },
    );
  }
}

class ControlItem extends StatelessWidget {
  final String icon;
  final String title;
  final String desc;
  final String action;

  const ControlItem({
    super.key,
    required this.icon,
    required this.title,
    required this.desc,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showToast(context, 'Action: $action'),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.02)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromRGBO(9, 14, 16, 0.6),
              const Color.fromRGBO(12, 18, 20, 0.55),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.02),
                    Colors.white.withOpacity(0.01),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.45),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Center(child: Text(icon, style: const TextStyle(fontSize: 20))),
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(desc, style: const TextStyle(fontSize: 12, color: mutedColor), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 46,
        height: 26,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.02)),
          gradient: value
              ? const LinearGradient(colors: [accent1Color, accent2Color])
              : null,
          color: value ? null : const Color.fromRGBO(255, 255, 255, 0.02),
        ),
        child: Align(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value ? Colors.white : const Color(0xFFCFEEE4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const CustomSlider({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 6.0,
        trackShape: const RoundedRectSliderTrackShape(),
        activeTrackColor: accent2Color,
        inactiveTrackColor: glassColor,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
      ),
      child: Slider(
        value: value,
        min: 0,
        max: 100,
        activeColor: accent1Color,
        onChanged: onChanged,
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
  final EdgeInsets? padding;

  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: isPrimary ? accent1Color : Colors.transparent,
        foregroundColor: isPrimary ? const Color(0xFF021414) : accent1Color,
        shadowColor: isPrimary ? accent2Color.withOpacity(0.12) : Colors.transparent,
        elevation: isPrimary ? 8 : 0,
        side: isPrimary
            ? null
            : BorderSide(color: accent1Color.withOpacity(0.12), width: 1),
        textStyle: const TextStyle(fontWeight: FontWeight.w800),
      ).copyWith(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (!isPrimary) return Colors.transparent;
          // A simple gradient effect can be simulated with state changes,
          // but for a true gradient, a custom button is needed.
          // This setup uses solid colors which is simpler.
          return accent1Color;
        }),
      ),
      child: Text(label),
    );
  }
}

void _showToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, textAlign: TextAlign.center),
      backgroundColor: const Color.fromRGBO(2, 20, 18, 0.85),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
      duration: const Duration(milliseconds: 1600),
    ),
  );
}
