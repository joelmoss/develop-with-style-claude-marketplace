# Develop With Style Claude Code Marketplace

A Claude Code plugin marketplace by Joel Moss, to help to Develop with Style 😎

## Installation

Add the marketplace:

```sh
/plugin marketplace add joelmoss/develop-with-style-claude-marketplace
```

Then install a plugin:

```sh
/plugin install jj-worktrees@develop-with-style
/plugin install build-macos-apps@develop-with-style
```

## Plugins

### jj-worktrees

Uses [Jujutsu](https://github.com/jj-vcs/jj) workspaces instead of git worktrees for Claude Code's worktree isolation feature. Falls back to git worktrees for non-jj repos.

**Creating a worktree:**

- If the repo has a `.jj` directory, creates a jj workspace via `jj workspace add`
- Otherwise, creates a standard git worktree via `git worktree add`
- Runs `.claude/worktree-setup` if present

**Removing a worktree:**

- Runs `.claude/worktree-teardown` if present
- If jj, forgets the workspace via `jj workspace forget` and removes the directory
- Otherwise, removes the git worktree via `git worktree remove`

**Requirements:**

- [jq](https://jqlang.github.io/jq/) (for parsing hook input)
- [jj](https://github.com/jj-vcs/jj) (for jj repos)

### build-macos-apps

Build, run, test, debug, and implement native macOS apps with shell-first Xcode and Swift workflows. Ported from the OpenAI Codex plugin of the same name, adapted for Claude Code.

**Commands:**

- `/build-and-run-macos-app` — create or update `script/build_and_run.sh` and launch the fresh build
- `/test-macos-app` — run the smallest meaningful macOS test scope and classify failures
- `/fix-codesign-error` — inspect a signing/entitlement failure and explain the minimum fix path

**Skills:**

- `build-run-debug` — shell-first `xcodebuild` / `swift build` run loop with a single `build_and_run.sh` entrypoint
- `test-triage` — classify macOS test failures as compile, assertion, crash, env/setup, or flake
- `signing-entitlements` — inspect signing identities, entitlements, hardened runtime, Gatekeeper
- `packaging-notarization` — prepare distribution packaging and notarization
- `swiftpm-macos` — Swift Package Manager on macOS, including GUI `.app` staging for SwiftUI/AppKit apps
- `swiftui-patterns` — scene models, commands, menus, toolbars, split layouts, settings, multiwindow
- `liquid-glass` — modern macOS design-system surfaces and material treatments
- `window-management` — title/toolbar styling, placement, borderless windows, launch behavior
- `appkit-interop` — representables, responder chain, panels, drag-and-drop pasteboard
- `view-refactor` — splitting large macOS view files toward stable scene/selection/command structure
- `telemetry` — lightweight `Logger` / `os.Logger` instrumentation and `log stream` verification

**Requirements:**

- macOS with Xcode Command Line Tools
- Swift 6 / Xcode 16 or later recommended

## License

MIT
