#define BLYNK_TEMPLATE_ID "TMPL2mAfrolfS"
#define BLYNK_TEMPLATE_NAME "Smart Plant"
#define BLYNK_AUTH_TOKEN "RIuNykrmbipMV5nt16W5E0dH59tq7Oki"

//Include the library files
#define BLYNK_PRINT Serial
#include <ESP8266WiFi.h>
#include <BlynkSimpleEsp8266.h>
#include <DHT.h>

char ssid[] = "hdjdjjs";  //Enter your WIFI SSID
char pass[] = "tarek12301";  //Enter your WIFI Password

DHT dht(5, DHT11);//(DHT sensor pin,sensor type)  D1 DHT11 Temperature Sensor
BlynkTimer timer;

//Define component pins
#define soil A0     //A0 Soil Moisture Sensor
#define LDR 16      //D0 LDR Motion Sensor

void setup() {
  Serial.begin(9600);
  Blynk.begin(BLYNK_AUTH_TOKEN, ssid, pass, "blynk.cloud", 80);
  dht.begin();
  //Call the function
  timer.setInterval(500L, soilMoistureSensor);
  timer.setInterval(500L, DHT11sensor);
  timer.setInterval(500L, LDRsensor);
}


//Get the DHT11 sensor values
void DHT11sensor() {
  float h = dht.readHumidity();
  float t = dht.readTemperature();

  if (isnan(h) || isnan(t)) {
    Serial.println("Failed to read from DHT sensor!");
    return;
  }

  Serial.print("Temperature: ");
  Serial.println(t);

  Serial.print("Humidity: ");
  Serial.println(h);

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
    int value = digitalRead(LDR);
    Blynk.virtualWrite(V6, !value);

  }



void loop() {
      
  Blynk.run();//Run the Blynk library
  timer.run();//Run the Blynk timer

  }
