#!/bin/bash

clear

	#TWEAKS
	START_TIMEOUT=3 # При запуске стрима идет пауза (3 - сек)
	STOP_TIMEOUT=00:10:00 # Завершение записи по определенному времени (00:00:00 - Безограничение)
	WINDOW_ID=0x5400008 # захват главного окна

	# START TIME_OUT...
	for (( i = $START_TIMEOUT ; i > 0 ; i-- )); do echo "Запись видео начнется через $i сек"; sleep 1; done;
	echo "Запись видео успешно идет :)";
	for server in `ls ./list`
	do
		key=$(cat ./list/$server/key)
		chmod +x ./list/$server/exec.sh
		exec="$exec $(NAME=$server STOP_TIMEOUT=$STOP_TIMEOUT WINDOW_ID=$WINDOW_ID ./list/$server/exec.sh) $key"
	done
	ffmpeg \
	$exec
./rffmpeg.sh
