# project justfile

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
