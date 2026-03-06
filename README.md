# jj-worktrees

A Claude Code plugin that uses [Jujutsu](https://github.com/jj-vcs/jj) workspaces instead of git worktrees for Claude Code's worktree isolation feature. Falls back to git worktrees for non-jj repos.

## Installation

```sh
claude plugin add /path/to/jj-worktrees
```

## How it works

The plugin provides `WorktreeCreate` and `WorktreeRemove` hooks that Claude Code calls when creating and removing worktrees.

**Creating a worktree:**

- If the repo has a `.jj` directory, creates a jj workspace via `jj workspace add`
- Otherwise, creates a standard git worktree via `git worktree add`
- Runs `.claude/worktree-setup` if present

**Removing a worktree:**

- Runs `.claude/worktree-teardown` if present
- If jj, forgets the workspace via `jj workspace forget` and removes the directory
- Otherwise, removes the git worktree via `git worktree remove`

## Requirements

- [jq](https://jqlang.github.io/jq/) (for parsing hook input)
- [jj](https://github.com/jj-vcs/jj) (for jj repos)

## License

MIT
