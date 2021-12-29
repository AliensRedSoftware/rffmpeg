#!/bin/bash

# VIDEO
PFMT='yuvj420p' # (https://github.com/libav/libav/blob/master/libavutil/pixfmt.h || https://github.com/FFmpeg/FFmpeg/blob/master/libavutil/pixfmt.h)
FORMAT='x11grab' # use grabber video (x11grab, dshow, gdigrab, video4linux2)
VCODER='libx264' # use video codex
FPS='25' # default FPS
FPSMAX='60' # i-frame interval, should be double of FPS, 
THREADS='2' # max 6
CBR='2000k' # constant bitrate (should be between 1000k - 3000k)
CBRMIN='1000k' # constant bitrate (should be between 1000k - 3000k)
QUALITY='ultrafast'  # one of the many FFMPEG preset

# AUDIO
ACODER='libmp3lame'
ACHANNELS='2' # 1 for mono output, 2 for stereo
ARATE='48000' # use (44100, 48000)
ABITRATE='128k' # common bit rates (96k, 128k = default, 192k, 256k, 320k)

# OTHER
INRES=$(xdpyinfo | awk '/dimensions/{print $2}') # input resolution
DISPLAY=$(echo $DISPLAY) # target display name

#TWEAKS
CURSOR=0 # video cursor (default offline cursor)

echo \
	-window_id $WINDOW_ID -f $FORMAT -draw_mouse $CURSOR -r $FPS -i $DISPLAY \
	-i ./list/$NAME/extensions/overlays/qr.gif -i ./list/$NAME/extensions/overlays/nya.jpg -filter_complex "overlay=x=main_w-overlay_w-10:y=main_h-overlay_h-10,overlay=x=10:y=H-h-10" \
	-f pulse -name $NAME -i default -f flv -acodec $ACODER -ac $ACHANNELS -ar $ARATE -ab $ABITRATE -af aresample=async=1 \
	-aspect 5:3 -vcodec $VCODER -g $FPSMAX -keyint_min $FPS -b:v $CBR -minrate $CBRMIN -maxrate $CBR -pix_fmt $PFMT -preset $QUALITY \
	-tune zerolatency -threads $THREADS -strict normal \
	-t $STOP_TIMEOUT 
