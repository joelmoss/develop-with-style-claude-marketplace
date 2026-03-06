# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Claude Code plugin marketplace. It contains plugins that extend Claude Code's functionality, distributed via the marketplace system.

## Repository Structure

```
plugins/
  <plugin-name>/
    .claude-plugin/plugin.json   # Plugin metadata (name, version, description, author, license)
    hooks/hooks.json             # Hook definitions mapping Claude Code events to scripts
    scripts/                     # Shell scripts executed by hooks
```

## Plugin Architecture

Each plugin lives under `plugins/` and follows this structure:
- **plugin.json** declares metadata for the marketplace
- **hooks.json** maps Claude Code lifecycle events (e.g., `WorktreeCreate`, `WorktreeRemove`) to command hooks
- **Scripts** receive JSON input on stdin (parsed with `jq`) and write diagnostic output to stderr; only the final result goes to stdout

Hook scripts reference their plugin root via `${CLAUDE_PLUGIN_ROOT}`.

## Current Plugins

**jj-worktrees** - Replaces git worktrees with jj workspaces for worktree isolation. Falls back to git for non-jj repos. Supports optional `.claude/worktree-setup` and `.claude/worktree-teardown` scripts in the target project.
