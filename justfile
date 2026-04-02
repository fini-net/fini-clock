# project justfile

import? '.just/template-sync.just'
import? '.just/repo-toml.just'
import? '.just/cue-verify.just'
import? '.just/copilot.just'
import? '.just/claude.just'
import? '.just/compliance.just'
import? '.just/gh-process.just'
import? '.just/pr-hook.just'
import? '.just/shellcheck.just'

# list recipes (default works without naming it)
[group('example')]
list:
	just --list
	@echo "{{GREEN}}Your justfile is waiting for more scripts and snippets{{NORMAL}}"

# install prerequisites for development
[group('Utility')]
devsetup:
	git config diff.gdscript.xfuncname '^[\t ]*(class|func|signal)[\t ].*$'
