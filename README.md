# Boylerplate Project Documentation

Welcome to the **Boylarplate** project! This documentation is designed to help new developers understand the project structure, the architectural patterns used, and how to work within our monorepo setup.

---

## 1. Monorepo Structure (Dart Workspaces)

We use a **Monorepo** (Monolithic Repository) structure powered by **Dart Workspaces**. This allows us to manage multiple applications and shared packages in a single repository.

### Why Monorepo?
- **Code Sharing**: We can easily share code (like UI kits, core logic, or API clients) between different apps without publishing them to pub.dev.
- **Unified Dependencies**: We manage dependencies centrally, ensuring all apps use compatible versions of libraries.
- **Simplified Tooling**: You can run commands like `flutter pub get` from the root to install dependencies for *all* projects at once.

### How it Works
The root `pubspec.yaml` defines the workspace:
```yaml
workspace:
  - apps/ocr_app
  # - packages/shared_ui (Example of a future package)
```
Each member (like `apps/ocr_app`) opts into the workspace by adding `resolution: workspace` to its `pubspec.yaml`.

---

## 2. Project Directory Layout

```text
/ (Root)
├── pubspec.yaml          # Workspace definition & shared dependencies
├── apps/                 # Contains all application entry points
│   └── ocr_app/          # The main OCR Flutter application
│       ├── lib/          # App source code
│       └── pubspec.yaml  # App-specific dependencies
└── packages/             # Shared libraries (currently empty, ready for expansion)
```

---

## 3. Application Architecture (Clean Architecture)

The `ocr_app` follows **Clean Architecture** principles to ensure separation of concerns, testability, and maintainability. The code is divided into three main layers:

### 📂 `lib/features/`
Each feature (e.g., `todo`) is self-contained and split into three layers:

#### 1. **Domain Layer** (`features/todo/domain`)
*The "Business Logic" - Pure Dart code, no Flutter dependencies.*
- **Entities**: Simple classes representing data (e.g., `Todo`).
- **Repositories (Interfaces)**: Abstract classes defining *what* operations can be done (e.g., `getTodos()`), but not *how*.
- **Use Cases**: Classes that encapsulate a specific business rule or action (e.g., `AddTodo`, `GetTodos`). This is the entry point for the UI to interact with data.

#### 2. **Data Layer** (`features/todo/data`)
*The "Implementation" - Handles data retrieval and storage.*
- **Models**: Subclasses of Entities with JSON serialization/deserialization logic (e.g., `TodoModel`).
- **Data Sources**: Low-level classes that talk to databases or APIs (e.g., `TodoLocalDataSource` using SQLite).
- **Repositories (Implementation)**: Implements the Domain interfaces. It coordinates data sources to fetch/save data and handles errors.

#### 3. **Presentation Layer** (`features/todo/presentation`)
*The "UI" - Widgets and State Management.*
- **Pages**: Flutter Widgets (Screens) that the user sees (e.g., `TodoPage`).
- **Providers/State Management**: We use `Provider` (specifically `ChangeNotifier`) to manage state. The Provider calls **Use Cases** and updates the UI based on the result.

### 📂 `lib/core/`
Contains shared utilities used across features, such as:
- **`usecase/`**: Base classes for Use Cases.
- **`error/`**: Standardized error handling (Failures, Exceptions).

---

## 4. Key Concepts & Boilerplate

### Dependency Injection (DI)
We use `get_it` to manage dependencies.
- **File**: `lib/injection_container.dart`
- **How it works**: We register all our classes (Data Sources, Repositories, Use Cases, Providers) at startup.
- **Benefit**: The UI doesn't need to know how to create a Repository; it just asks for it.

### State Management
We use the `Provider` package.
- **Pattern**: `ChangeNotifier` holds the state (variables) and business logic.
- **Usage**:
  1. UI triggers an action (e.g., `provider.addTodo(...)`).
  2. Provider calls a Use Case.
  3. Provider updates its state (e.g., `isLoading = false`).
  4. `notifyListeners()` is called to rebuild the UI.

---

## 5. Getting Started

### Prerequisites
- Flutter SDK (3.10.0 or higher)
- VS Code or Android Studio

### Running the App
1. **Install Dependencies**:
   From the **root** of the repository, run:
   ```bash
   flutter pub get
   ```
   *This installs dependencies for the workspace and all apps.*

2. **Run the App**:
   Navigate to the app directory or run directly:
   ```bash
   cd apps/ocr_app
   flutter run
   ```

### Adding a New Feature
1. Create a folder `lib/features/new_feature`.
2. Create `domain`, `data`, and `presentation` subfolders.
3. Define your **Entity** and **Repository Interface** in `domain`.
4. Implement the **Repository** and **Data Source** in `data`.
5. Create **Use Cases** in `domain`.
6. Create your **Provider** and **Page** in `presentation`.
7. Register everything in `injection_container.dart`.

---
*Happy Coding! If you have questions, check the `pubspec.yaml` or ask a senior developer.*
