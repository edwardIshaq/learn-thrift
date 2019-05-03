THRIFT_FILE:=multiplication.thrift
lang=swift

OUTPUT_DIR:=./gen-src
GEN_OUTPUT:=${OUTPUT_DIR}/${lang}

gen:
	mkdir -p ${GEN_OUTPUT}
	./thrift.sh -out ${GEN_OUTPUT} --gen ${lang} ${THRIFT_FILE}

reset:
	rm -rf ${OUTPUT_DIR}
	mkdir ${OUTPUT_DIR}


