#!/bin/bash

######
使用步骤：
1. 运行脚本
2. 在mac中使用网易云音乐，并听歌，将自动下载歌曲

原理是通过解析云音乐的日志文件，其中暴露了歌曲的url及歌名，从而提供条件下载
#######

LOG_FILE="/Users/tim/Library/Containers/com.netease.163music/Data/Documents/storage/Logs/music.163.log"


tail -f $LOG_FILE | awk -F: 'function getValue(f){ split(f,arr,"\"");return arr[2]} /playid/ && /songName/ && /artistName/ && /musicurl/ {songName=getValue($6);artiseName=getValue($8);url=getValue($21":"$22);file=songName"-"artiseName".mp3";gsub(/[\/\(\) ]/,"",file);system("axel -o ~/Music/网易云音乐/"file" "url);}'




