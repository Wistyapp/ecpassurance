# AGENTS.md

## Build/Lint/Test Commands

### Project Setup
- `flutter pub get`: Install project dependencies.
- `flutter run`: Launch app on connected device/emulator.

### Build Commands
- Android: `flutter build apk --release`
- iOS: `flutter build ios --release`
- Web: `flutter build web --release`
- Desktop: `flutter build windows --release`

### Linting
- Manual: `dart analyze`
- Watch mode: `dart analyze --watch`
- Fix issues: `dart fix --apply`
- Custom rules: Check `analysis_options.yaml`

### Testing
- Run all tests: `flutter test`
- Watch tests: `flutter test --watch-plugins`
- Single test: `flutter test test/specific_test.dart`
- Specific test by name: `flutter test --name=testMyTest`
- Code coverage: `flutter test --coverage`
- Run specific test: `flutter test --match-snapshot-name=testName`

## Code Style Guidelines

### Imports
- Use absolute imports (e.g., `import 'package:app/api.dart';`).
- Sort imports lexicographically.
- Group imports by type (core, package, local).
- Avoid relative imports.

### Formatting
- Always run `dart format .` before committing.
- Use `dart fix` for linting fixes.
- Keep line length under 100 characters.
- Use consistent spacing (2 spaces for indentation).

### Types
- Use explicit types (e.g., `String`, `int`, `bool`).
- Prefer nullable types (e.g., `String?`).
- Avoid `dynamic`; use type annotations.
- Use `final` for immutable variables.

### Naming Conventions
- Variables/functions: camelCase (e.g., `userName`)
- Classes: PascalCase (e.g., `UserModel`)
- Methods: camelCase (e.g., `calculateTotal`)
- Constants: UPPER_SNAKE_CASE (e.g., `MAX_USERS`)
- Files: kebab-case (e.g., `user-profile.dart`)

### Error Handling
- Use `try/catch` for exceptions.
- Avoid `print()` in production.
- Validate inputs and throw descriptive errors.
- Use `assert()` for internal checks.

### Additional Style Points
- Avoid magic numbers; use constants.
- Keep methods under 30 lines.
- Write descriptive comments.
- Use `final` and `const` appropriately.
- Prefer `null` over `undefined`.
- Handle null cases explicitly.

## Configuration Files
- `analysis_options.yaml`: Linting configuration.
- `pubspec.yaml`: Dependencies and metadata.
- `.flutter-plugins-dependencies`: Plugin dependencies.

## CI/CD Best Practices
- Run `flutter test` before merging.
- Use `--no-pub` with `flutter pub get`.
- Maintain code coverage.
- Use `--release` for production builds.

## Notes for Agents
- Always format code before committing.
- Never commit unverified changes.
- Test changes thoroughly.
- Follow existing code patterns.
- Use `grep` to search for related code.
- If unsure, ask for clarification.
- Use `pubspec.yaml` to manage dependencies.
- Check `analysis_options.yaml` for linting rules.
- Use `flutter test` for testing.
- Use `dart analyze` for linting.
- Use `--no-pub` with `flutter pub get`.
- Use `flutter pub upgrade` to upgrade dependencies.
- Use `--release` for production builds.
- Use `--target` with `flutter run` for specific files.
- Use `--dart-define` for environment variables.
- Use `--no-select-cocoon` for Flutter web.
- Use `--no-enable-internal-tracing` for performance.
- Use `--verbose` for debugging.
- Use `--trace-uri` for performance tracing.
- Use `--profile` for profiling.
- Use `--split-debug-info` for debugging symbols.
- Use `--build-number` for versioning.
- Use `--version-code` for Android versioning.
- Use `--build-name` for version name.
- Use `--flutter-version` to check Flutter version.
- Use `--version` to check Flutter version.
- Use `--help` for command help.

## Extended CI/CD Practices
- Run `flutter pub upgrade` regularly to keep dependencies updated.
- Enforce a minimum test coverage of 80%.
- Use semantic versioning for releases.
- Automate deployments with CI.

## Documentation Standards
- Write comprehensive README sections.
- Keep Dartdoc annotations up-to-date.
- Generate API docs with `dart doc`.
- Include architecture diagrams.

## Pre‑Commit Hooks
- Lint and format code before each commit.
- Run `dart analyze` and `dart format --set-exit-if-changed .` in pre‑commit hooks.
- Disallow console logs and TODO comments in commits.

## Agent Usage Tips
- Begin each task with a TODO comment describing the objective.
- Keep tasks focused and avoid large monolithic changes.
- Test at each step to isolate regressions quickly.
- Use feature branches and peer‑review pull requests.
- Document design decisions in DESIGN.md files.
- Prefer immutable data structures and pure functions.
- Audit dependencies for security vulnerabilities.
- Leverage static analysis to catch common pitfalls early.
- Write comprehensive unit and integration tests.
- Optimize performance only after profiling.
- Deploy to staging environments before production releases.
- Monitor production logs for errors and anomalies.
- Provide constructive feedback in code reviews.
- Celebrate milestones and recognize team contributions.
- Maintain consistent coding standards across the codebase.
- Share knowledge through internal docs and tech talks.