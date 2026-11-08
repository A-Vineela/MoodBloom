# 🌸 MoodBloom – Daily Motivation & Mood-Tracking Application

<p align="center">
  <strong>Small steps. Meaningful growth. A happier you.</strong>
</p>

<p align="center">
  A mood-aware self-care application that transforms everyday emotions into small, meaningful actions.
</p>

<p align="center">
  <a href="https://a-vineela.github.io/MoodBloom/">🌐 Live Demo</a> •
  <a href="https://github.com/A-Vineela/MoodBloom">📂 GitHub Repository</a>
</p>

---

## 🌱 About the Project

**MoodBloom** is a daily motivation and mood-tracking application built using Flutter and Dart. It goes beyond traditional motivational applications that provide generic quotes.

Instead of offering random words of encouragement, MoodBloom first asks how you are feeling and then suggests small, meaningful activities based on your emotional state.

Whether it is taking a short walk, practising gratitude, drinking water, getting some fresh air, or simply taking a break, these little things we often overlook can make the biggest difference over time.

With personalized self-care activities, daily reflections, mood insights, and an interactive virtual garden, MoodBloom encourages users to nurture themselves one small step at a time.

> Every feeling deserves space. Every small step deserves recognition. 🌷

---
## 🎯 Project Objectives

MoodBloom was developed with the following objectives:

- Encourage daily emotional awareness.
- Promote positive and achievable self-care habits.
- Provide mood-based rather than generic motivational suggestions.
- Help users reflect on their emotional experiences.
- Make personal progress visible through an interactive garden.
- Encourage consistency through small daily actions.
  
---
## ✨ Key Features

### 1. 😊 Daily Mood Check-in
- Record your emotional state through daily check-ins.
- Choose from five mood categories:
  - 😄 Amazing
  - 🙂 Good
  - 😐 Okay
  - 😔 Low
  - 😣 Stressed
- Add an optional personal reflection of up to 180 characters.
- Maintain multiple mood entries instead of replacing previous check-ins.

### 2. 🌼 Personalized Self-Care Activities
MoodBloom provides three mood-sensitive care suggestions for each plant.

Activities include:
- Taking a few slow, deep breaths.
- Drinking a glass of water.
- Getting fresh air or sunlight.
- Practising gratitude.
- Stretching or walking for five minutes.
- Sharing a kind word with someone.
- Writing down your thoughts.

The aim is to make self-care achievable through small, manageable actions.

### 3. 🌷 Interactive Virtual Garden
Every mood check-in creates a new plant in your personal garden.

Plants begin at different stages depending on the recorded mood. As users complete their suggested care activities, their plants gradually grow.

**Plant Growth Stages:**

| Completed Tasks | Growth Stage | Representation |
|---|---|---|
| 0 | Starting stage | 🌰 / 🥀 |
| 1 | Small sprout | 🌱 |
| 2 | Growing plant | 🌿 |
| 3 | Blooming flower | 🌸 |

Each plant represents a moment in your emotional journey and the effort you put into taking care of yourself.

### 4. 📖 Daily Reflections
- Write short personal reflections during mood check-ins.
- Revisit recent reflections from the dashboard.
- Express emotions and track experiences over time.

### 5. 📊 Mood Insights
The insights dashboard provides an overview of your emotional patterns.

It displays:
- Total number of mood check-ins.
- Most frequently recorded mood.
- Distribution of all five mood categories.
- Visual representation of mood frequency.

### 6. 💾 Persistent Local Storage
- Mood entries are stored locally using `shared_preferences`.
- Completed garden-care tasks are saved.
- JSON encoding and decoding are used to manage application data.
- Data persists across normal browser refreshes within the same browser profile.

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform UI development |
| Dart | Application logic and functionality |
| Material 3 | UI components and design system |
| shared_preferences | Local data persistence |
| JSON | Data serialization and storage |
| Visual Studio Code | Development environment |
| Git | Version control |
| GitHub | Source-code hosting |
| GitHub Actions | Automated web build and deployment |
| GitHub Pages | Application hosting |

---



## ⚙️ How It Works

The application follows a simple user journey:

1. **Check in:** Select your current mood.
2. **Reflect:** Optionally write a short note about how you feel.
3. **Create a plant:** A new plant is added to your virtual garden.
4. **Receive suggestions:** Get three self-care activities based on your mood.
5. **Take action:** Complete the suggested activities.
6. **Grow:** Watch your plant progress through different growth stages.
7. **Reflect on progress:** Explore your mood history and insights.

---

## 🚀 Getting Started

Follow these instructions to run MoodBloom locally.

### Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Visual Studio Code](https://code.visualstudio.com/)
- Git

### 1. Clone the Repository

```bash
git clone https://github.com/A-Vineela/MoodBloom.git
```

### 2. Navigate to the Project Directory

```bash
cd MoodBloom
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the Application

To run the application in Chrome:

```bash
flutter run -d chrome
```

To generate a production web build:

```bash
flutter build web --release
```

---

## 🌐 Deployment

MoodBloom is deployed as a Flutter Web application using **GitHub Pages**.

The deployment process is automated using GitHub Actions.

### Deployment Workflow

1. Push changes to the `main` branch.
2. GitHub Actions automatically triggers the deployment workflow.
3. Flutter dependencies are installed.
4. A release web build is generated.
5. The generated `build/web` directory is uploaded as a GitHub Pages artifact.
6. GitHub Pages publishes the application.

### Deployment Configuration

Workflow file:

```text
.github/workflows/deploy.yml
```

Build command:

```bash
flutter build web --release --base-href "/MoodBloom/"
```

**Live Application:**  
https://a-vineela.github.io/MoodBloom/

---

## 🔒 Data Storage and Privacy

MoodBloom uses local browser storage through Flutter's `shared_preferences` package.

- Mood entries are stored locally.
- Garden-care progress is saved locally.
- Data persists across normal refreshes in the same browser profile.
- No cloud account synchronization or cross-device synchronization is implemented.

---

## 🔮 Future Enhancements

Potential improvements for future versions include:

- User authentication and cloud-based data synchronization.
- Cross-device mood history synchronization.
- Advanced mood analytics and visualizations.
- Weekly and monthly progress reports.
- Customizable garden themes and plant collections.
- Reminders for daily check-ins and self-care activities.
- More personalized activity recommendations.

---

<p align="center">
  🌸 <strong>MoodBloom</strong> 🌸
  <br>
  <em>You don't have to bloom every day. Just keep growing.</em>
</p>
