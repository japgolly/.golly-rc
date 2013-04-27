#!/bin/bash

f="$(
  egrep '(public|private|protected) ' \
  | egrep -v 'static|(public|protected|private) \S+\(' \
  | grep -vP '^\t\t' \
  | grep -vP '^\t.* class .*' \
  | perl -pe '
      s/ ?=.+//;
      s/(final|synchronized) //g;
      s/( \{|;)$//;
      s/^\tpublic /  +/;
      s/^\tprotected /  #/;
      s/^\tprivate /  -/;
      s/^((public|protected|private) )//;
      s/^([a-z].+)/}\n\1 {/;
      s/\@\S+\s//g;
      s/ throws .+//;
    '
  )"

echo "$f" \
  | sed '1{/\}/D}' \
  | perl -pe '
      s/ (implements|extends).+/ {/;
      s/}$/}\n/;
    '
echo "}"

echo

echo "$f" \
  | egrep ' (implements|extends)' \
  | perl -pe '
      s/abstract //;
      s!^\S+ (\S+) (implements|extends) (.+) \{!\1 --|> \3!;
      s/<.+?>//g;
    '
