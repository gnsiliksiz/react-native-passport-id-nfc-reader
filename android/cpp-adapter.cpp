#include <jni.h>
#include "react-native-passport-id-nfc-reader.h"

extern "C"
JNIEXPORT jint JNICALL
Java_com_passportidnfcreader_PassportIdNfcReaderModule_nativeMultiply(JNIEnv *env, jclass type, jdouble a, jdouble b) {
    return passportidnfcreader::multiply(a, b);
}
