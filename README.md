# MoodBloom 🌷

**Grow a garden, one feeling at a time.**

MoodBloom is a gentle mood-tracking and self-reflection web app built with Flutter and Dart. Each check-in adds a plant to a personal virtual garden. Plants respond to the mood recorded and can be nurtured by completing small, optional self-care tasks.

The project is designed to run in **Google Chrome** and can be deployed as a static Flutter web app using **GitHub Pages**.

## Features

### Mood check-ins
- Choose from five moods: Amazing, Good, Okay, Low, and Stressed.
- Add an optional reflection of up to 180 characters.
- Add multiple check-ins, including multiple check-ins on the same day.
- View recent reflections on the dashboard.

### Personal garden
- Every check-in creates its own plant.
- The plant's starting appearance reflects the mood recorded.
- Each plant has three gentle, mood-sensitive care suggestions.
- Completing care tasks grows the plant through stages: seed / droopy seedling → sprout → leafy plant → flower.
- A sunshine panel reflects the overall balance of positive check-ins.
- Difficult moods do not remove progress. Care tasks are optional and plants do not die.

### Insights and dashboard
- Dashboard with check-in count, day streak, garden plant count, and recent reflections.
- Insights screen summarizes mood frequency.
- Responsive layout with a pastel sidebar on wider screens and a drawer on smaller screens.

### Local persistence
- Mood check-ins and completed garden tasks are saved with `shared_preferences`.
- Data remains after normal browser refreshes and reopening the app in the same browser profile.
- Data is stored locally in the browser; there is no account, cloud sync, or backend.
- Clearing browser site data, using a different browser/profile, or switching devices will not carry the data over.

## Tech stack

| Technology | Purpose |
|---|---|
| Flutter | UI framework |
| Dart | Application language |
| Material 3 | UI components and styling |
| `shared_preferences` | Local persistence in browser storage |
| GitHub Actions | Automated web build and deployment |
| GitHub Pages | Static web hosting |

## Run locally in Chrome

Requirements: Flutter SDK (stable channel), Google Chrome, and Git (recommended).

From the project root:

```bash
flutter doctor
flutter pub get
flutter run -d chrome
```

To create a production web build:

```bash
flutter build web --release
```

The generated website is placed in `build/web/`. The `build/` directory is generated output and should not be committed.

## Deploy to GitHub Pages

This repository includes `.github/workflows/deploy.yml`.

1. Push the project to a GitHub repository. The workflow uses the `main` branch.
2. Open **Settings → Pages**.
3. Under **Build and deployment**, choose **GitHub Actions** as the source.
4. Push a commit to `main`, or manually run the workflow from the **Actions** tab.
5. Open `https://YOUR_GITHUB_USERNAME.github.io/YOUR_REPOSITORY_NAME/`.

The workflow automatically sets Flutter's web base path to the repository name.

## Project structure

```text
moodbloom_flutter/
├── .github/workflows/deploy.yml
├── docs/
│   ├── PROJECT_DOCUMENTATION.md
│   └── screenshots/                 # Illustrative previews; replace with live captures
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── models/mood_entry.dart
│   ├── screens/
│   │   ├── main_shell.dart
│   │   ├── home_screen.dart
│   │   ├── check_in_screen.dart
│   │   ├── insights_screen.dart
│   │   └── garden_screen.dart
│   └── widgets/
│       ├── section_title.dart
│       └── stat_card.dart
├── test/widget_test.dart
├── web/
├── analysis_options.yaml
├── pubspec.lock
└── pubspec.yaml
```

## Data model and application flow

- `Mood` is an enum containing the five supported moods and their display properties.
- `MoodEntry` stores the check-in timestamp, selected mood, and optional note.
- `MainShell` owns the check-in list, restores and saves it using `shared_preferences`, and passes it to the dashboard, insights, and garden screens.
- `GardenScreen` creates a plant card for every `MoodEntry`. It stores completed care-task indexes separately for each plant.

## Notes and current limitations

- This is a local-first prototype, not a medical or mental-health treatment tool.
- Care suggestions are general wellness prompts, not clinical advice.
- Data is not encrypted, backed up, or synchronized to a server.
- The sunshine is a simple visual indicator based on the proportion of Amazing and Good check-ins; it is not a scientific measure of wellbeing.
- The screenshots in `docs/screenshots/` are illustrative previews, not screenshots captured from a running browser build. Replace them with current screenshots before a formal presentation or submission.
- This cleaned package is web-first / Chrome-focused. Native Android and iOS platform folders are not included, but can be regenerated if required.

## Useful maintenance commands

```bash
flutter pub get
flutter analyze
flutter test
flutter build web --release
```

## License

No open-source license has been added yet. Add a `LICENSE` file if you intend to publish the project for reuse by others.
