#!/bin/bash

#streaming() {
clear

	# SERVICE ;)
	PROTOCOL='rtmp' # use protocol
	SERVER=$(cat SERVER) # twitch server in frankfurt, see http://bashtech.net/twitch/ingest.php for list
	STREAM_KEY=$(cat STREAM_KEY) # use the terminal command Streaming streamkeyhere to stream your

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
	WINDOW_ID=0x5200008 # захват главного окна

	ffmpeg \
	-window_id $WINDOW_ID -f $FORMAT -draw_mouse $CURSOR -r $FPS -i $DISPLAY -f pulse -i default -f flv -acodec $ACODER -ac $ACHANNELS -ar $ARATE -ab $ABITRATE -af aresample=async=1 \
	-aspect 5:3 -vcodec $VCODER -g $FPSMAX -keyint_min $FPS -b:v $CBR -minrate $CBRMIN -maxrate $CBR -pix_fmt $PFMT \
	-preset $QUALITY \
	-vf "movie=lg.png [watermark]; [in][watermark] overlay=0:main_h-overlay_h-0 [out]" \
	-tune film -threads $THREADS -strict normal \
	-bufsize $CBR "$PROTOCOL://$SERVER/$STREAM_KEY"
./rffmpeg.sh
#}
