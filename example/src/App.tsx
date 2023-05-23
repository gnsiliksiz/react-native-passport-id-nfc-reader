import * as React from 'react';

import {
  NFCPassportModel,
  scanPassport,
} from 'react-native-passport-id-nfc-reader';
import { Alert, Button, StyleSheet, View } from 'react-native';

export default function App() {
  const [_, setResult] = React.useState<NFCPassportModel>();

  const scanDocument = () => {
    scanPassport({
      birthDate: '1994-01-13T00:00:00Z',
      expiryDate: '2030-08-19T00:00:00Z',
      passportNumber: 'A26L66194',
      useNewVerificationMethod: true,
    }).then((res) => {
      if ('error' in res) {
        Alert.alert('NFC failed!', res.error);
        return;
      }
      setResult(res);
    });
  };

  return (
    <View style={styles.container}>
      <Button onPress={scanDocument} title="Start scanning" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'white',
  },
});
