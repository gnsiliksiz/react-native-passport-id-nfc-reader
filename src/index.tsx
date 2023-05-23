import { NativeModules, Platform } from 'react-native';
import type { PassportOptions } from './Interfaces/PassportOptions';
import type { NFCPassportModel } from './Interfaces/NFCPassportModel';

const LINKING_ERROR =
  `The package 'react-native-passport-id-nfc-reader' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const PassportIdNfcReader = NativeModules.PassportIdNfcReader
  ? NativeModules.PassportIdNfcReader
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function scanPassport(
  options: PassportOptions
): Promise<NFCPassportModel | { error: string }> {
  return PassportIdNfcReader.scanPassport(options);
}
export * from './Interfaces';
