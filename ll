#!/bin/zsh

emulate -L zsh
setopt no_unset

usage() {
  cat <<'USAGE'
usage: ll [option ...] [path ...]

List directories with ls and page files with less.

With no path, ll runs ls with the given options.
With one file, ll runs less with the given options.
With one directory, ll runs ls with the given options.
With multiple paths, ll runs one command when all paths have the same kind.
Mixed file and directory paths are handled one at a time when no options are given.

Use -- before a path that begins with a hyphen.
Set LL_LS or LL_PAGER to choose different commands.
USAGE
}

if (( $# == 1 )) && [[ $1 == -h || $1 == --help ]]; then
  usage
  exit 0
fi

typeset -a ls_cmd pager_cmd operands missing
typeset -i after_dashdash=0 has_options=0 dir_count=0 file_count=0

ls_cmd=(${(z)${LL_LS:-/bin/ls}})
pager_cmd=(${(z)${LL_PAGER:-/usr/bin/less}})

for arg in "$@"; do
  if (( after_dashdash )); then
    operands+=("$arg")
    continue
  fi

  if [[ $arg == -- ]]; then
    after_dashdash=1
    continue
  fi

  if [[ $arg == - ]]; then
    operands+=("$arg")
    continue
  fi

  if [[ $arg == [-+]* ]]; then
    has_options=1
    continue
  fi

  operands+=("$arg")
done

if (( ${#operands} == 0 )); then
  command "${ls_cmd[@]}" "$@"
  exit $?
fi

for operand in "${operands[@]}"; do
  if [[ $operand == - ]]; then
    (( file_count++ ))
  elif [[ -d $operand ]]; then
    (( dir_count++ ))
  elif [[ -e $operand ]]; then
    (( file_count++ ))
  else
    missing+=("$operand")
  fi
done

if (( ${#missing} > 0 )); then
  for operand in "${missing[@]}"; do
    print -ru2 -- "ll: $operand: No such file or directory"
  done
  exit 1
fi

if (( dir_count > 0 && file_count == 0 )); then
  command "${ls_cmd[@]}" "$@"
  exit $?
fi

if (( file_count > 0 && dir_count == 0 )); then
  command "${pager_cmd[@]}" "$@"
  exit $?
fi

if (( has_options )); then
  print -ru2 -- "ll: mixed file and directory operands cannot share options"
  print -ru2 -- "ll: run separate commands, or use ll --help"
  exit 2
fi

typeset -i exit_code=0 command_status=0

for operand in "${operands[@]}"; do
  if [[ -d $operand ]]; then
    command "${ls_cmd[@]}" -- "$operand"
    command_status=$?
  elif [[ $operand == - ]]; then
    command "${pager_cmd[@]}" -
    command_status=$?
  else
    command "${pager_cmd[@]}" -- "$operand"
    command_status=$?
  fi

  if (( command_status != 0 && exit_code == 0 )); then
    exit_code=$command_status
  fi
done

exit $exit_code
