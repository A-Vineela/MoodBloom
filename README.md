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


