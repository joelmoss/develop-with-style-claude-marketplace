#!/bin/bash
set -e

# Read JSON input from stdin
input=$(cat)
worktree_path=$(echo "$input" | jq -r '.worktree_path')
cwd=$(echo "$input" | jq -r '.cwd')

# Run project-specific teardown script if present
if [ -x "$cwd/.claude/worktree-teardown" ]; then
  cd "$worktree_path" && "$cwd/.claude/worktree-teardown" >&2 || true
fi

if [ -d "$cwd/.jj" ]; then
  # JJ workspace - forget the workspace and remove the directory
  name=$(basename "$worktree_path")
  jj --repository "$cwd" workspace forget "$name" >&2 2>/dev/null || true
  rm -rf "$worktree_path"
else
  # Git worktree
  git -C "$cwd" worktree remove "$worktree_path" --force >&2 2>/dev/null || true
fi

# Clean up empty worktrees directory
rmdir "$cwd/.claude/worktrees" 2>/dev/null || true

exit 0
