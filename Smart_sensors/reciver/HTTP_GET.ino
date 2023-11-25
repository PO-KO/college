
#include <ESP8266WiFi.h>

/* Fill in information from Blynk Device Info here */
#define BLYNK_TEMPLATE_ID "TMPL2mAfrolfS"
#define BLYNK_TEMPLATE_NAME "Smart Plant"
#define BLYNK_AUTH_TOKEN "RIuNykrmbipMV5nt16W5E0dH59tq7Oki"

// Network settings
char ssid[] = "ZTE_2.4G_XYN6Ae";  //Enter your WIFI SSID
char pass[] = "46ApX6Yh";  //Enter your WIFI Password

// Blynk cloud server
const char* host = "blynk.cloud";
unsigned int port = 80;

WiFiClient client;

// Start the WiFi connection
void connectNetwork()
{
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, pass);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println();
  Serial.println("WiFi connected");
}

bool httpRequest(const String& method,
                 const String& url,
                 const String& request,
                 String&       response)
{
  Serial.print(F("Connecting to "));
  Serial.print(host);
  Serial.print(":");
  Serial.print(port);
  Serial.print("... ");
  if (client.connect(host, port)) {
    Serial.println("OK");
  } else {
    Serial.println("failed");
    return false;
  }

  Serial.print(method); Serial.print(" "); Serial.println(url);

  client.print(method); client.print(" ");
  client.print(url); client.println(F(" HTTP/1.1"));
  client.print(F("Host: ")); client.println(host);
  client.println(F("Connection: close"));
  if (request.length()) {
    client.println(F("Content-Type: application/json"));
    client.print(F("Content-Length: ")); client.println(request.length());
    client.println();
    client.print(request);
  } else {
    client.println();
  }

  //Serial.println("Waiting response");
  int timeout = millis() + 5000;
  while (client.available() == 0) {
    if (timeout - millis() < 0) {
      Serial.println(">>> Client Timeout !");
      client.stop();
      return false;
    }
  }

  //Serial.println("Reading response");
  int contentLength = -1;
  while (client.available()) {
    String line = client.readStringUntil('\n');
    line.trim();
    line.toLowerCase();
    if (line.startsWith("content-length:")) {
      contentLength = line.substring(line.lastIndexOf(':') + 1).toInt();
    } else if (line.length() == 0) {
      break;
    }
  }

  //Serial.println("Reading response body");
  response = "";
  response.reserve(contentLength + 1);
  while (response.length() < contentLength) {
    if (client.available()) {
      char c = client.read();
      response += c;
    } else if (!client.connected()) {
      break;
    }
  }
  client.stop();
  return true;
}

void setup()
{
  Serial.begin(9600);
  delay(10);
  Serial.println();
  Serial.println();

  connectNetwork();
}

void loop() {
  String temp;
  String hum;
  String soilm;
  String light;

  Serial.println("Reading value");

  if (httpRequest("GET", String("/external/api/get?token=") + BLYNK_AUTH_TOKEN + "&pin=V0", "", temp)) {
    Serial.print("Temperature: ");
    Serial.println(temp.);
  }

  if (httpRequest("GET", String("/external/api/get?token=") + BLYNK_AUTH_TOKEN + "&pin=V1", "", hum)) {
    Serial.print("Humidty: ");
    Serial.println(hum);
  }

  if (httpRequest("GET", String("/external/api/get?token=") + BLYNK_AUTH_TOKEN + "&pin=V3", "", soilm)) {
    Serial.print("Soim Moisture: ");
    Serial.println(soilm);
  }

  if (httpRequest("GET", String("/external/api/get?token=") + BLYNK_AUTH_TOKEN + "&pin=V6", "", light)) {
    Serial.print("Light Status : ");
    Serial.println(light);
  }

  // Wait
  delay(30000L);
}
