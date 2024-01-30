#include <ESP8266MQTTClient.h>
#include <ESP8266WiFi.h>
#include <SPI.h>
#include <MFRC522.h>

#define SS_PIN 15
#define RST_PIN 0
MFRC522 mfrc522(SS_PIN, RST_PIN);
MQTTClient mqtt;
 
#define SSID "AP-BKTM"
#define Hostname "ESP_SSK"

void setup() {
  Serial.begin(115200); //Setzt die Boutrate

  SPI.begin();        //RFID-Initialisierung
  mfrc522.PCD_Init(); // ^ ^ ^ ^ ^ ^ ^ ^ ^
 
  // set hostname
  WiFi.hostname(Hostname);
 
  // connect to WiFi
  WiFi.mode(WIFI_STA);
  WiFi.begin(SSID);
  // check if connection is successfull
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(1000);
  }

  Serial.println("WiFi: Verbindung erfolgreich");
 
  mqtt.onData([](String topic, String data, bool cont) {
    Serial.println("MQTT: Data received");
    Serial.printf("%s: %s\n", topic.c_str(), data.c_str());   //Gibt das Topic mit dem Value einmal aus.
  });
 
  mqtt.onSubscribe([](int sub_id) {
    Serial.println("MQTT: Subscribed");
    mqtt.publish("RFID_SSK", "Test" , 0, 0);     //Erstellt ein Topic mit einem Value
  });
 
  mqtt.onConnect([]() {
    Serial.println("MQTT: Connected");
    mqtt.subscribe("RFID_SSK", 0);         //Subscribed das Topic welches gebraucht wird
  });
 
  mqtt.onDisconnect([]() {
    Serial.println("MQTT: Disconnected");
  });
 
  mqtt.begin("mqtt://mqtt-dashboard.com:1883");
}

void loop() {
  mqtt.handle();

   if (!mfrc522.PICC_IsNewCardPresent())
    return;

  if (!mfrc522.PICC_ReadCardSerial())
    return;

  String uid = getCardId();

mqtt.publish("RFID_SSK", uid , 0, 0);

delay(1000);
}

String getCardId() {
  String uid = "";
  for (byte i = 0; i < mfrc522.uid.size; i++)
  {
    uid.concat(String(mfrc522.uid.uidByte[i], HEX));
    if (i < mfrc522.uid.size - 1)
      uid.concat(" ");
  }
  uid.toUpperCase();
  return uid;
}