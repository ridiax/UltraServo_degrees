// Adicionando a biblioteca e Servo
#include <Servo.h>
Servo meuServo;

void setup(){
  meuServo.attach(9);
  
  Serial.begin(9600);
}

void loop(){
  // Rotacionando o servo (10 a 160):
  for (int r = 10; r <= 160; r++){
    meuServo.write(r);
    delay(35);
  }

  // Rotacionando ao contrario
  for (int r = 160; r > 10; r--){
    meuServo.write(r);
    delay(35);
  }

  
}
