# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

FINI Clock is a mobile clock application built with Godot 4.5. The project targets mobile and open platforms, implementing a simple digital clock interface with real-time updates.

## Development Workflow

This repo inherits the standard `just` command runner workflow from the template-repo. The workflow is entirely command-line based using `just` and the GitHub CLI (`gh`).

### Standard development cycle

1. `just devsetup` - Configure git diff settings for GDScript (one-time setup)
2. `just branch <name>` - Create a new feature branch (format: `$USER/YYYY-MM-DD-<name>`)
3. Make changes and commit (last commit message becomes PR title)
4. `just pr` - Create PR, push changes, and watch checks (waits 8s for GitHub API)
5. `just merge` - Squash merge PR, delete branch, return to main, and pull latest
6. `just sync` - Return to main branch and pull latest (escape hatch)

### Additional commands

- `just` or `just list` - Show all available recipes
- `just prweb` - Open current PR in browser
- `just release <version>` - Create a GitHub release with auto-generated notes
- `just compliance_check` - Run custom repo compliance checks
- `just shellcheck` - Run shellcheck on all bash scripts in just recipes

## Godot Development

### Engine version and configuration

- **Engine**: Godot 4.5
- **Target platforms**: Mobile (using mobile rendering method)
- **Main scene**: `res://scenes/main.tscn`
- **Project configuration**: `project.godot`

### Code quality checks

The GitHub Actions workflow `godot-checks.yml` runs on all pushes and PRs that affect `addons/**` or `scripts/**`:

- **gdformat** - GDScript formatting checks (`gdformat --diff .`)
- **gdlint** - GDScript linting checks (`gdlint .`)
- **codespell** - Spell checking (skips `./addons` and `*.po` files)

Run these locally before creating a PR to catch issues early.

### Git configuration

The `just devsetup` recipe configures git to properly diff GDScript files:

```bash
git config diff.gdscript.xfuncname '^[\t ]*(class|func|signal)[\t ].*$'
```

This shows function/class/signal names in diff headers for better context.

## Architecture

### Project structure

- `scripts/` - GDScript files (game logic)
- `scenes/` - Godot scene files (.tscn)
- `addons/` - Third-party Godot plugins (currently empty)
- `.godot/` - Godot editor cache and metadata (not committed)

### Current implementation

The application consists of a single main scene (`scenes/main.tscn`) controlled by `scripts/main.gd`:

- **Main node** (`Node2D`) - Root node for the scene
- **CenterContainer** - Centers the time display in the window (1152x648 default)
- **time_label** (`Label`) - Displays the current time with 80pt font

The `main.gd` script:
- Uses `@onready` to reference the time label node
- Creates a Timer node in `_ready()` that fires every 1.0 seconds
- Connects the timer's `timeout` signal to `update_time()` function
- Fetches system time using `Time.get_time_dict_from_system(true)` for UTC
- Formats time as HH:MM:SS with zero-padding

### Godot scene format notes

Scene files (`.tscn`) use Godot's text-based scene format:
- `[gd_scene]` header defines the format version and dependencies
- `[ext_resource]` sections link to scripts and assets via UIDs
- `[node]` sections define the scene tree hierarchy
- Properties use `key = value` syntax (e.g., `text = "--:--:--"`)

## Important implementation notes

- GDScript uses snake_case for variables and functions
- Node references use `$NodePath` syntax or `@onready` variables
- Signal connections use the `.connect()` method (Godot 4.x style)
- The project uses UTC time via `Time.get_time_dict_from_system(true)`
- All Godot resource paths use `res://` protocol

## Modular justfile structure

The main `justfile` imports four modules from `.just/`:

- `compliance.just` - Custom compliance checks for repo health
- `gh-process.just` - Git/GitHub workflow automation (core PR lifecycle)
- `pr-hook.just` - Optional pre-PR hooks (currently placeholder)
- `shellcheck.just` - Shellcheck linting for bash scripts in just recipes
