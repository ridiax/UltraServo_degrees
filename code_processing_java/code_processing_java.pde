// Importando
import processing.serial.*;      // Biblioteca de comunicacao Serial.
import java.awt.event.KeyEvent;  // Biblioteca apra ler porta serial. 
import java.io.IOException;      // Biblioteca Input/Output exceptions.

Serial minhaPorta; // Definindo minha porta serial em uma variavel.

String angulo    = "";
String distancia = "";
String data      = "";
int index1       = 0;
int index2       = 0;
int xAngulo, xDistancia;

String naoObjeto;
float pixsDitancia;

PFont orcFont;

void setup(){
 size (1280, 720); // Resolucao da Tela. 
 smooth();         // Arestas suaves nos desenhos.
 minhaPorta  =  new  Serial(this,"COM3", 9600); // Inicia a comunicacao Serial.
 minhaPorta.bufferUntil('!');  // Le a Porta Serial ate aparecer (!), no caso angulo, distanca (!).
}

void serialEvent(Serial minhaPorta){

  // Leitura dos dados até (!) e coloca na variavel DATA.
  data = minhaPorta.readStringUntil('!');
  data = data.substring(0, data.length()-1);
  
  index1   = data.indexOf(","); // Procura por ',' e coloca dentro da variavel Index1
  angulo   = data.substring(0, index1); // Le os dados enviados para index1 e coloca no angulo. 
  distancia= data.substring(index1+1, data.length()); // Leia os dados da index2, use eles para distancia.

  // Convertendo a String em Inteiro.
  xAngulo       =  int(angulo);
  xDistancia    =  int(distancia);

}
