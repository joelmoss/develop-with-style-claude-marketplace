#!/bin/bash
set -e

# Read JSON input from stdin
input=$(cat)
name=$(echo "$input" | jq -r '.name')
cwd=$(echo "$input" | jq -r '.cwd')

worktree_dir="$cwd/.claude/worktrees"
worktree_path="$worktree_dir/$name"

mkdir -p "$worktree_dir"

if [ -d "$cwd/.jj" ]; then
  # JJ workspace
  jj --repository "$cwd" workspace add --name "$name" "$worktree_path" >&2
else
  # Git worktree (default behavior)
  git -C "$cwd" worktree add "$worktree_path" -b "claude/$name" >&2
fi

# Run project-specific setup script if present
if [ -x "$cwd/.claude/worktree-setup" ]; then
  cd "$worktree_path" && "$cwd/.claude/worktree-setup" >&2
fi

# Only the path goes to stdout
echo "$worktree_path"
