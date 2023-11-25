

//Include the library files
#define BLYNK_PRINT Serial
#include <ESP8266WiFi.h>
#include <BlynkSimpleEsp8266.h>
#include <DHT.h>

#define BLYNK_TEMPLATE_ID "TMPL2mAfrolfS"
#define BLYNK_TEMPLATE_NAME "Smart Plant"
#define BLYNK_AUTH_TOKEN "RIuNykrmbipMV5nt16W5E0dH59tq7Oki"

char ssid[] = "ZTE_2.4G_XYN6Ae";  //Enter your WIFI SSID
char pass[] = "46ApX6Yh";  //Enter your WIFI Password

DHT dht(5, DHT11);//(DHT sensor pin,sensor type)  D1 DHT11 Temperature Sensor
BlynkTimer timer;

//Define component pins
#define soil A0     //A0 Soil Moisture Sensor
#define LDR 16      //D0 PIR Motion Sensor

void setup() {
  Serial.begin(9600);
  Blynk.begin(BLYNK_AUTH_TOKEN, ssid, pass, "blynk.cloud", 80);
  dht.begin();
  //Call the function
  timer.setInterval(2000L, soilMoistureSensor);
  timer.setInterval(2000L, DHT11sensor);
  timer.setInterval(2000L, LDRsensor);
}


//Get the DHT11 sensor values
void DHT11sensor() {
  float h = dht.readHumidity();
  float t = dht.readTemperature();

  if (isnan(h) || isnan(t)) {
    Serial.println("Failed to read from DHT sensor!");
    return;
  }
  Blynk.virtualWrite(V0, t);
  Blynk.virtualWrite(V1, h);

}


//Get the soil moisture values
void soilMoistureSensor() {
  int value = analogRead(soil);
  value = map(value, 0, 1024, 0, 100);
  value = (value - 100) * -1;

  Blynk.virtualWrite(V3, value);

}

//Get the LDR sensor values
void LDRsensor() {
    int value = digitalRead(soil);
    Blynk.virtualWrite(V3, value);

  }



void loop() {
      
  Blynk.run();//Run the Blynk library
  timer.run();//Run the Blynk timer

  }
