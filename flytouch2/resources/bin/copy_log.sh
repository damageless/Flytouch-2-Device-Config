#!/system/bin/busybox ash

PANIC_PROC_PATH=/proc/kpanic
PANIC_LOG_PATH=/data/local/panic
TMP_FILE=/sqlite_stmt_journals/panic.txt
TIMESTEMP=`date +%Y_%m_%d_%H_%M_%S`


if [ ! -d ${PANIC_LOG_PATH} ];
then
	mkdir ${PANIC_LOG_PATH}
fi

cat ${PANIC_PROC_PATH} > ${TMP_FILE}
if [ -s ${TMP_FILE} ];
then
	cat ${TMP_FILE} > ${PANIC_LOG_PATH}/kpanic_${TIMESTEMP}.txt 
	echo "--clean" > ${PANIC_PROC_PATH}
fi
rm ${TMP_FILE}
