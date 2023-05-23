#ifdef __cplusplus
#import "react-native-passport-id-nfc-reader.h"
#endif

#ifdef RCT_NEW_ARCH_ENABLED
#import "RNPassportIdNfcReaderSpec.h"

@interface PassportIdNfcReader : NSObject <NativePassportIdNfcReaderSpec>
#else
#import <React/RCTBridgeModule.h>

@interface PassportIdNfcReader : NSObject <RCTBridgeModule>
#endif

@end
