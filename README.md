✨ Auto Shimmer

A lightweight, theme-aware shimmer wrapper for any widget.
Smooth loading animations with directional control and optional diagonal tilt.

Perfect for skeleton loaders, grids, lists, cards, and text placeholders.

🚀 Features

✅ Wrap any widget
🎨 Theme-aware (iOS + Android)
↔ Supports LTR / RTL / TTB / BTT directions
✨ Optional diagonal tilt for premium feel
⚡ Lightweight & no external dependencies
♿ Accessibility-friendly (excluded semantics during loading)

📸 Preview

Replace this with your GIF inside /assets/demo.gif

![Demo](https://raw.githubusercontent.com/ObidjonJoraboyev/auto_shimmer/main/gif/example.gif)

📦 Installation

Add this to your pubspec.yaml:

dependencies:
auto_shimmer: ^0.1.0


Then run:

flutter pub get

📖 Basic Usage
```dart
AutoShimmer(
    isLoading: true,
    child: Container(
        height: 80,
        width: double.infinity,
        color: Colors.grey,
    ),
)
```

🎯 Direction & Tilt

Control shimmer movement direction and angle:
```dart
AutoShimmer(
    isLoading: true,
    direction: ShimmerDirection.rtl,
    tilt: -0.25,
    child: Text("Loading..."),
)
```

Available Directions
```dart
ShimmerDirection.ltr
ShimmerDirection.rtl
ShimmerDirection.ttb
ShimmerDirection.btt
```
Vertical directions automatically disable tilt.

🧱 Grid Example (2 items per row)
```dart
GridView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: 8,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
      return AutoShimmer(
        isLoading: true,
        child: Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
  );
```
🌙 Theme Awareness

AutoShimmer automatically adapts to:

iOS (CupertinoTheme)

Android (Material Theme)

You can override colors manually:
```dart
    AutoShimmer(
    isLoading: true,
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.white,
    child: ...
)
```

⏱ Custom Duration

```dart
AutoShimmer(
    isLoading: true,
    duration: const Duration(milliseconds: 1800),
    child: ...
)
```
♿ Accessibility

When loading, semantics are excluded to avoid screen reader noise.

🛠 Example App

See the full example inside the /example folder for:

Text shimmer

Grid shimmer

Horizontal list shimmer

Dark mode preview

📜 License

MIT License — free to use in personal and commercial projects.

If this package helps you, consider ⭐ starring the repository.