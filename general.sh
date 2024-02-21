#!/bin/bash

filepath="./server.c"
if [ ! -f "$filepath" ];then
    touch $filepath
    echo "AAAA\n" >> $filepath
    echo "BBBB\n" >> $filepath
else
    echo "file server.c has be exists.."
fi

filepath="./client.c"
if [ ! -f "$filepath" ];then
    touch $filepath
    echo "XXXX\n" >> $filepath
    echo "YYYY\n" >> $filepath
else
    echo "file client.c has be exists."
fi
