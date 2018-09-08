#!/bin/bash

SMALL=("Small files:")
MEDIUM=("Medium-sized files:")
LARGE=("Large files:")

for FILE in *; do
    LINES=$(cat "$FILE" | wc -l )

    if [ $LINES -lt 10 ]; then
        SMALL=$SMALL" "$FILE
    elif [ $LINES -lt 100 ]; then
        MEDIUM=$MEDIUM" "$FILE
    else
        LARGE=$LARGE" "$FILE
    fi
done

echo $SMALL
echo $MEDIUM
echo $LARGE
