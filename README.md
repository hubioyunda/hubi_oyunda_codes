<div align="center">

# 🛡️ HUBİ OYUN
### Interactive Cybersecurity & Computing Education Platform

**Computer Networks Course — Group 6**

---

**Group Members:** Gülsena TOPUZ · Fatmanur YENİ · Fatıma Zehra UYANIK · Eda YILMAZ

</div>

---

## 📖 Project Overview

**HUBİ OYUNDA** is an innovative mobile education (EdTech) platform designed to help children build a safe, conscious, and early connection with the digital world. Rather than replacing traditional computing education, it acts as a **complementary classroom technology** — giving teachers an interactive tool they can use alongside their lessons. The app transforms abstract computer science concepts into an enjoyable learning ecosystem through gamification.

The core vision of the application is to move children beyond being passive "content consumers" in the digital world, turning them into **"Cyber Heroes"** and **"Cyber Detectives"** who understand the logical architecture behind technology, recognize cyber threats, and have internalized digital hygiene habits.

---

## 🎯 Target Audience: Why Ages 10–12?

Choosing the 10–12 age group (grades 5 and 6) as the target audience is grounded in deep pedagogical reasoning.

**Cognitive Transition Period:** According to Jean Piaget's Theory of Cognitive Development, this age group represents the critical threshold where children transition from the *Concrete Operational Stage* to the *Formal Operational Stage*. Terms like "IP Address", "RAM", "Cloud Storage", or "Port" are entirely abstract. For this reason, the project architecture is built on an **analogy bridge** that maps these concepts to everyday objects children can already touch and understand (suitcases, trash cans, secret tunnels, castles).

**Start of Independent Digital Identity:** Ages 10–12 is the period when children first take their own usernames, start choosing avatars, and open their first personal accounts. Cybersecurity education given at this stage directly shapes all digital behavioral patterns in later life.

**Learning in the Comfort Zone:** The app does not require children to sit at a desk. It is designed to be used on the go, standing up, with a single hand. The card-flipping mechanism works with a light tap — no two hands required — integrating learning into daily life rather than confining it to a study session.

---

## 🧠 Pedagogical Approach

### Microlearning
The sustained attention span of Generation Z and Alpha children on static content averages 10–15 minutes. This constraint was turned into an advantage: topic explanations are structured as 10 dynamic **Topic Cards** per module rather than long text blocks. The front/back card logic keeps curiosity alive throughout.

### Concretizing Abstract Concepts
Technical terms that have no foothold in a child's mind were mapped to everyday objects:

| Technical Concept | Child's Analogy |
|:---|:---|
| Port 80 (HTTP) | Door number in an apartment building |
| RAM | A desk that gets wiped clean when the power goes out |
| Cloud Storage | A giant shared digital box in the sky |
| Recycle Bin | A trash can that keeps filling until you empty it |
| Zip/Rar Compression | Squeezing clothes tightly into a suitcase |
| IP Address | A digital ID number |
| Server | A powerful computer that never shuts down, 24/7 |

### AI-Powered Scaffolding
The central AI assistant "Hubi" is designed in full alignment with Vygotsky's *Zone of Proximal Development* and *Scaffolding* theory. The strictest rule given to Hubi: **never tell the child the correct answer directly.** Instead, it produces analogies and hints that guide the child to think independently.

### Speed and Focus Analysis Engine
The `AnalizManager` class monitors whether children are swiping through cards quickly "just to get through them." If a child completes a test in under 15 seconds, points are deducted from their score — **pedagogically forcing them to slow down and read carefully.**

```dart
// AnalizManager — Comprehension Level Calculation Engine
if (karttaGecirilenSaniye < 15) basariYuzdesi -= 10; // Speed penalty
if (nihaiSkor >= 85) return "% nihaiSkor (Cyber Detective)";
if (nihaiSkor >= 60) return "% nihaiSkor (Developing)";
return "% nihaiSkor (Needs Support)";
```

---

## 🎮 Application Flow & Screens

### Stage 1 — Launch Screen
A holographic pink-yellow-green gradient background displays the robot Hubi mascot and the "HUBİ OYUNDA" logo. The **"START THE ADVENTURE 🚀"** purple button checks the username stored in `SharedPreferences`: if a profile exists it navigates directly to the Mission Center; otherwise it routes to the Profile Creation screen. The use of `pushReplacement` clears the entry screen from memory, making it architecturally impossible for the child to go back to an empty state.

### Stage 2 — Cyber Profile Creation
The child sets two things: a **Cyber Code Name (Nickname)** and a **Character Selection.** The choice is permanently saved to `SharedPreferences`. Four character options are available — each with an analogical counterpart in the cybersecurity world (see the Character System section).

### Stage 3 — Mission Center
The top bar shows the child's selected avatar, cyber code name, and live **XP score.** With `FutureBuilder` architecture, a cyber-themed loading spinner appears while data loads asynchronously from disk; the UI updates synchronously the moment data is ready.

Modules are presented as colored cards:

| Module | Color | Topics |
|:---|:---|:---|
| 🛡️ Cyber Hero | Purple | Cybersecurity, ports, network layers |
| 🔍 Network Detective | Green | Internet, modem, IP, server, IoT |
| 💾 Files & Memory | Blue | RAM, SSD, folders, zip, cloud storage |
| 🖥️ Operating Systems | Orange | OS basics, file management, shortcuts |

### Stage 4 — Topic Selection Screen
A child entering a module chooses between two paths: **"Study Topic Cards"** (learn first) or **"Go to Question Map"** (take the quiz directly). `KonuSecimEkrani` is designed polymorphically — regardless of which topic is entered, the title, color codes, and target screens are received as external parameters (Constructor Injection), keeping inter-module coupling loose.

### Stage 5 — 3D Card Deck (Flip Card System)
The 10-card deck is shown as a slightly tilted stack on screen. When the child taps the deck, the game begins and the card expands.

```
+-------------------------+      Tap       +-------------------------+
|  [FRONT FACE]           |  ──────────►  |  [BACK FACE]            |
|                         |  Matrix4      |                         |
|  What is the name of    |  rotateY(pi)  |  Answer: The Internet!  |
|  the giant network      |               |                         |
|  connecting all the     |               |  [ ASK HUBİ ]           |
|  computers in the world?|               |                         |
+-------------------------+               +-------------------------+
```

**3D Animation Architecture:** `TweenAnimationBuilder` computes a radian animation from 0 to `math.pi` (180°). Depth (perspective) is created by assigning `0.001` to cell `[3][2]` of `Matrix4`. When the angle exceeds 90°, the `arkasiGozukuyorMu` flag becomes `true`; since the back-face text would appear mirrored, `Matrix4.identity()..rotateY(math.pi)` is applied to the back-face components to correct it, making the text read normally.

**The "Ask Hubi" button** only becomes visible when the card is flipped (`arkasiGozukuyorMu == true`). This prevents the child from asking the AI before seeing the question and bypassing the challenge.

### Stage 6 — Question Map (Locked Level System)
Each module contains a **10-level** list map. Completed levels are colored with a gradient in the module's theme color; incomplete levels are grayed out with `Colors.grey[400]` and locked with an `Icons.lock` icon. The lock check reads `SharedPrefsHelper.getLevel(category)` from disk: if `i > currentLevel - 1`, the level cannot be tapped.

**Forward Progress Protection:** The `if (yeniSeviye > mevcut)` check in the `setLevel` method ensures that even if a child re-solves older levels, their current progress never regresses.

### Stage 7 — Question Detail
4-option multiple-choice questions. Each level starts with a question score of **15 XP.**

---

## 💰 XP Scoring System

```
Correct Answer (1st Attempt)  →  +15 XP  (Maximum)
Wrong Answer   (1st Mistake)  →  Question Score: 10 XP
Wrong Answer   (2nd Mistake)  →  Question Score:  5 XP  (Minimum Floor)
Wrong Answer   (3rd+ Mistake) →  Question Score:  5 XP  +  -1 XP from Total Pool (Anti-Spam)
```

Mathematical rule: `if (puan > 5) puan -= 5; else SharedPrefsHelper.puanDegistir(-1);`

This mechanism prevents random answer-spamming and encourages the child to answer slowly and thoughtfully.

---

## 🔥 Cyber Fire (Streak) System

A timestamp-based background engine that makes the habit of **regular platform use** sustainable. Children can compare their streak counts with each other — this competitive element boosts continuity motivation.

```dart
// siberAtesKontrolEt — ISO 8601 Date Parsing
String today = DateTime.now().toIso8601String().substring(0, 10);
int diff = now.difference(last).inDays;

if (diff == 1) siber_ates++;    // Consecutive login  → fire grows
if (diff > 1)  siber_ates = 1;  // Missed a day       → fire resets to 1
```

The algorithm works purely on a **calendar-day** basis, independent of hour/minute differences. A child who uses the app every day sees their Cyber Fire grow; missing a day resets it to the starting value of **1.**

---

## 🏆 Congratulations & Graduation Screen

When a child successfully completes all modules, they are greeted with the Graduation screen — the peak of the gamification loop. The screen dynamically displays the child's selected avatar, cyber code name, Cyber Fire streak count, and total XP score. The "Complete the Adventure" button commits all final game states to `SharedPreferences` and seals the journey.

---

## 🤖 AI Assistant (Hubi) Integration

### Why Gemini 1.5 Flash?
The application connects to Google's **Gemini 1.5 Flash** model via the `google_generative_ai: ^0.4.7` package. Low latency and mobile device compatibility are the primary reasons for this choice. A type-safe, asynchronous model-calling mechanism was built directly on Flutter without needing complex REST API plumbing.

### System Instruction — 4 Core Rules

Four non-negotiable behavioral rules were defined inside `_systemInstruction` to prevent the AI from producing uncontrolled or age-inappropriate outputs:

| # | Rule | Purpose |
|:---:|:---|:---|
| 1 | Never give the answer directly | Preserve the game's competitive nature |
| 2 | Produce analogies and hints | Concretize abstract concepts |
| 3 | Friendly, cheerful, emoji-rich language | Break the "cold chatbot" perception |
| 4 | Short sentences | Avoid scattering the child's focus |

### Fallback Mechanism
When the API connection fails (the `catch (e)` block is triggered), instead of crashing the app, the system automatically displays the pre-written static `hubi` hint text for the current card. This ensures the application runs smoothly even without an active AI connection.

### Pedagogical Basis for Not Giving Direct Answers
Hubi's refusal to state the correct answer is an **intentional design decision.** In conventional apps where the correct answer is handed to the child, cognitive laziness sets in (*Learned Helplessness*). Hubi's analogy activates existing schemas in the child's mind; when the child reaches the correct answer **on their own** by connecting the hints, the concept becomes permanently encoded in memory.

---

## 🦊 Character (Avatar) System

The four avatars carry powerful metaphorical meanings in cybersecurity literature, beyond just being visually appealing:

| Avatar | Analogy | Represents |
|:---:|:---|:---|
| 🦊 **Fox** | Mozilla Firefox, agile development | Dynamic cyber hero who thinks fast and escapes algorithmic traps |
| 🐧 **Penguin** | Linux Tux mascot, open-source philosophy | Free-software spirit who loves customizing systems and technical infrastructure |
| 🦉 **Owl** | Blue Team (Defense) | The vigilant analyst watching the network 24/7, spotting threats from a distance |
| 🦝 **Raccoon** | Red Team (Penetration Testing) | The investigative detective who hunts system vulnerabilities and follows digital trails |

While the child believes they are simply picking an animal they find cute, they are **unknowingly stepping into a cybersecurity role.** This forms the foundation of the pedagogical role-playing process.

---

## 🎨 Color Psychology & Meanings

The color palette across the interface was selected not only for aesthetic reasons, but for the psychological meanings that trigger specific emotional states in children:

| Color | Hex Code | Used In | Pedagogical Meaning |
|:---|:---|:---|:---|
| 🟣 Cyber Purple | `#8B5CF6` | Main action buttons, accents | Curiosity, mystery, creativity, courage to explore |
| 🩵 Neon Green | `#00FFCC` | XP box, avatar frame | Matrix/cyber aesthetic, "system is active and safe" |
| 🌑 Midnight Blue | `#0F172A` | Main background | High contrast, focus, "command center" atmosphere |
| 🔵 Light Blue | `#A0C4FF` | Files & Memory module | Cold, analytical, memory and data theme |
| 🟢 Light Green | `#B9FBC0` | Network Detective module | Connection, network, "running smoothly" signal |
| 🔴 Red | `Colors.red` | Wrong answer alert | Danger and error signal |
| ⬛ Dark Gray | `#2A2D34` | Card borders, text | Simplicity, reliability, readability |

---

## 💻 Technologies Used

| Technology | Version | Purpose |
|:---|:---|:---|
| **Flutter** | SDK ≥3.0 | Cross-platform (Android/iOS) mobile app |
| **Dart** | ≥3.0 | Business logic and all UI code |
| **shared_preferences** | ^2.2.3 | Persistent storage for username, avatar, XP, level, streak |
| **google_generative_ai** | ^0.4.7 | Gemini 1.5 Flash AI hint system |
| **http** | ^1.2.0 | HTTP request infrastructure |
| **TweenAnimationBuilder** | Flutter core | 3D card-flip animation (Y-axis rotation) |
| **Matrix4 / Transform** | Flutter core | 3D perspective transforms, depth perception |
| **AnimatedPositioned** | Flutter core | Card deck opening animation |
| **AnimatedOpacity** | Flutter core | Card stack fade-out effect |
| **LinearGradient** | Flutter core | Background color transitions per module theme |
| **FutureBuilder** | Flutter core | Async data loading and UI synchronization |

---

## 📂 Project Structure

```
hubi_oyunda/
├── assets/
│   ├── audio/                          # Sound effects folder (prepared for future release)
│   └── images/
│       ├── giris_arka_plan.jpg         # Holographic launch screen background
│       ├── avatar1.jpg                 # Fox character
│       ├── avatar2.jpg                 # Penguin character
│       ├── avatar3.jpg                 # Owl character
│       └── avatar4.jpg                 # Raccoon character
│
├── lib/
│   ├── core/
│   │   ├── ai_service.dart             # Gemini 1.5 Flash integration layer (AIServisi)
│   │   └── shared_prefs_helper.dart    # Local storage manager (SharedPrefsHelper)
│   │
│   ├── screens/
│   │   ├── siber_kahraman_ekrani.dart  # GirisEkrani: Logo and "START THE ADVENTURE" button
│   │   ├── giris_ekrani.dart           # GorevMerkezi: Main panel, XP bar, avatar display
│   │   ├── profil_ekrani.dart          # DosyaVeHafizaDesteEkrani + SoruHaritasiDosya
│   │   └── ag_dedektifi_ekrani.dart    # AgDedektifiDesteEkrani + SoruHaritasiAg + main()
│   │
│   ├── models/
│   │   └── gorev_model.dart            # Level, question, and score data models
│   │
│   └── main.dart                       # App entry point and AnalizManager
│
├── test/
│   └── widget_test.dart                # Basic UI loading test
│
└── pubspec.yaml                        # Package, SDK, and asset configuration
```

---

## 📚 Module Contents

### 🛡️ Cyber Hero Module
Ports (door-number analogy), Port 80 HTTP, SSH Port 22, network layers (hamburger analogy), firewall fundamentals.

### 🔍 Network Detective Module — 10 Cards + 10 Questions
What is the Internet, LAN vs. WAN, IoT (Internet of Things), modem, URL, search engines, web browser, fiber internet and 5G, server, IP address. Every card has a static `hubi` hint field that also serves as the AI fallback.

### 💾 Files & Memory Module — 10 Cards + 10 Questions
Folders, file extensions (.mp3/.jpg/.pdf), RAM vs. hard disk, Recycle Bin logic, shortcuts, Zip/Rar compression, backup, SSD, cloud storage, Terabyte. This module makes live Gemini calls via `AIServisi.ipucuAl()`.

### 🖥️ Operating Systems Module — 10 Cards + 10 Questions
What is an operating system, Windows/macOS/Linux differences, file management, desktop and taskbar, installing and uninstalling applications, update mechanisms, user accounts, shortcuts, task manager, safe system usage.

---

## ⚙️ Installation

```bash
# Clone the repository
git clone https://github.com/hubioyunda/codes.git
cd codes

# Install dependencies
flutter pub get

# Run the application
flutter run
```

**Requirements:** Flutter SDK ≥3.0.0 · Dart ≥3.0.0 · Android or iOS emulator / physical device

---

## ⚠️ Challenges Encountered & Solutions

### 1. Background Music Integration Issue
**Problem:** The initial project vision included a cyber-themed background music and sound effects; the `assets/audio/` folder was created for this purpose. However, this feature could not be integrated into the current release.

**Technical Reason:** Because the app's navigation architecture is built on `Navigator.pushReplacement` and multiple page transitions, keeping the music playing seamlessly across screen changes required complex lifecycle management. The risk of audio controllers not being correctly `dispose`d without causing memory leaks led the team to prioritize performance and put the audio module on hold.

### 2. Live AI API Connection
**Problem:** The `google_generative_ai` package was successfully integrated and prompt engineering was completed through `AIServisi`; however, in real-world tests, requests to the API endpoint could not be resolved. The system continuously fell into the `catch` block.

**Solution:** A two-layer error tolerance was designed. When the API fails to respond, instead of crashing, the system automatically displays the pre-written static `hubi` hint text for the current card. The app's flow was preserved this way.

**Likely Cause:** API key configuration issues and `INTERNET` permission restrictions in the Android manifest.

### 3. State Management — Prop-Drilling Problem
**Problem:** When a child correctly answered a question in the bottom-layer `SoruDetayDosya` screen, the score needed to reflect instantly in the top-layer `SoruHaritasiDosya` UI. To solve this, `onBasari: (p) {...}` callback functions were used and parent widgets were force-rebuilt with `setState(() {})`. This led to deeply nested widget trees and unnecessary re-renders.

**Applied Solution:** After calling `SharedPrefsHelper.puanDegistir()` and `SharedPrefsHelper.puanAzalt()`, a manual `setState()` refreshes the `toplamPuan` variable, achieving instant XP updates.

### 4. Asset Path Inconsistency
**Problem:** The background image in `GirisEkrani` was referenced as `'medya/images/giris_arka_plan.jpg'` while `pubspec.yaml` defined it under `assets/images/`.

**Solution:** All asset paths were standardized to `assets/images/`.

### 5. Mirrored Text on Card Flip
**Problem:** During the 3D Y-axis rotation, the text on the card's back face appeared mirrored (reversed).

**Solution:** `Matrix4.identity()..rotateY(math.pi)` was applied to back-face components, correcting the text to read normally.

---

<div align="center">

**🛡️ HUBİ OYUNDA — Group 6**

*"Hubi in the Game: Cyber ​​Mission Begins! 🚀"*

---
 
## 🎬 Demo Video
 
Watch the full application walkthrough to see HUBİ OYUNDA in action:
 
**[▶ Watch Demo — Hubi in the Game](https://drive.google.com/file/d/1JP6mZki5398oPo9uuhdeCvlUnskWBlUS/view?usp=drivesdk)**
 
</div>

</div>
