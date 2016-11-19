#!/bin/sh

cd `dirname $0`
DIR_TO_SEARCH=tmp
[ -e $DIR_TO_SEARCH ] && rm -rf $DIR_TO_SEARCH
mkdir $DIR_TO_SEARCH

for i in `seq 1 100`
do
  echo "Creating file ($i/100)"
  for j in `seq 1 5000`
  do
    echo "I am a cat." >> $DIR_TO_SEARCH/$i.txt
  done
done

echo "Starting elixir script..."
elixir working_with_multiple_processes_9.exs
rm -rf $DIR_TO_SEARCH
