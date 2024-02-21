#!/bin/bash

filepath="./server.c"
if [ ! -f "$filepath" ];then
    touch $filepath
    echo "AAAA" >> $filepath
    echo "BBBB" >> $filepath
    chmod 777 "$filepath"
else
    echo "file server.c has be exists.."
fi

filepath="./client.c"
if [ ! -f "$filepath" ];then
    touch $filepath
    echo "XXXX" >> $filepath
    echo "YYYY" >> $filepath
    chmod 777 "$filepath"
else
    echo "file client.c has be exists."
fi
