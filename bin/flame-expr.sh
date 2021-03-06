#!/bin/bash

MODULE=${1:-"erlang"}
FUNCTION=${2:-"self"}
ARGS=${3:-"[]"}

TRACE_FILE="$MODULE-$FUNCTION.out"
TRACE_FILE_SORTED="$TRACE_FILE.sorted"
SVG_FILE="$TRACE_FILE_SORTED.svg"

echo "Running eflame..."

PID=`erl -sname eflame-expr -pa _build/*/lib/*/ebin -pa ebin -s clojerl -noshell -eval "eflame:apply(normal_with_children, \"$TRACE_FILE\", '$MODULE', '$FUNCTION', $ARGS), io:format(\"~p~n\", [self()]), erlang:halt(0)."`

echo "PID: $PID"

cat $TRACE_FILE | sort | grep -v "$PID" > "$TRACE_FILE_SORTED"

_build/dev/lib/eflame/stack_to_flame.sh < $TRACE_FILE_SORTED > $SVG_FILE

open -a "Google Chrome" $SVG_FILE
