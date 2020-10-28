// Adicionando a biblioteca e Servo
#include <Servo.h>
Servo meuServo;

// Adicionando variaveis do Ultrassonico
const int trigPin = 2;
const int echoPin = 3;
long tempoDuracao;
int distancia;

void setup(){
  // Servo
  meuServo.attach(9);
  // Ultra
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  
  Serial.begin(9600);
}

void loop(){
  // Rotacionando o servo (10 a 160):
  for (int r = 10; r <= 160; r++){
    meuServo.write(r);
    delay(35);
    
    distancia = calcularDistancia();

    Serial.print(r);
    Serial.print(",");
    Serial.print(distancia);
    Serial.print("!");
  }

  // Rotacionando ao contrario
  for (int r = 160; r > 10; r--){
    meuServo.write(r);
    delay(35);
    
    distancia = calcularDistancia();
    
    Serial.print(r);
    Serial.print(",");
    Serial.print(distancia);
    Serial.print("!");
  }

  
}


// Funcao para retornar a distancia em interio
int calcularDistancia(){
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(2);

  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(2);
  digitalWrite(trigPin, LOW);

  tempoDuracao  = pulseIn(echoPin, HIGH);
  distancia     = tempoDuracao * 0.034/2;

  return distancia;
}
