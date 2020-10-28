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

void draw() {
  
  fill(98, 245, 31); // Cor Verde
  
  // Simulando blur e slow fade na movimentacao da linha:
  noStroke();
  fill(0,4); 
  rect(0, 0, width, height-height*0.065); 
  
  fill(98, 245, 31); 
  
  // Funcoes para desenho do radar:
  desenharRadar(); 
  desenharLinha();
  desenharObjeto();
  desenharTexto();
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


// Desenhos do Monitor Radar Ultrassonico:

// == Radar
void desenharRadar(){
  pushMatrix();
  translate(width/2, height-height*0.074); // Movimenta o começando pelas cordenadas da nova localizacao
  
  noFill();
  
  strokeWeight(2);
  stroke(98, 245, 31);
  
  // Desenhando linhas
  arc(0,0,(width-width*0.0625),(width-width*0.0625),PI,TWO_PI);
  arc(0,0,(width-width*0.27),(width-width*0.27),PI,TWO_PI);
  arc(0,0,(width-width*0.479),(width-width*0.479),PI,TWO_PI);
  arc(0,0,(width-width*0.687),(width-width*0.687),PI,TWO_PI);
  // Desenhando o angulo de linhas
  line(-width/2,0,width/2,0);
  line(0,0,(-width/2)*cos(radians(30)),(-width/2)*sin(radians(30)));
  line(0,0,(-width/2)*cos(radians(60)),(-width/2)*sin(radians(60)));
  line(0,0,(-width/2)*cos(radians(90)),(-width/2)*sin(radians(90)));
  line(0,0,(-width/2)*cos(radians(120)),(-width/2)*sin(radians(120)));
  line(0,0,(-width/2)*cos(radians(150)),(-width/2)*sin(radians(150)));
  line((-width/2)*cos(radians(30)),0,width/2,0);
  popMatrix();  
}

// == Objetos
void desenharObjeto(){
  pushMatrix();
  translate(width/2, height-height*0.074); // Movimenta o começando pelas cordenadas da nova localizacao
  
  strokeWeight(9);
  stroke(255, 10, 10); 
  
  pixsDitancia = xDistancia*((height-height*0.1666)*0.025);
  
  // Limitando o range para 40 cms
  if ( xDistance < 40 ) {
  // Desenhando o objeto de acordo com o angulo e distancia. (Em Vermelho 'stroke( 255,10,10 );' 
  line(pixsDitancia*cos(radians(xAngulo)),-pixsDitancia*sin(radians(xAngulo)),(width-width*0.505)*cos(radians(xAngulo)),-(width-width*0.505)*sin(radians(xAngulo)));
  }
  popMatrix();
}

//== Linha

void desenharLinha() {
  pushMatrix();
  strokeWeight(9);
  stroke(30, 250, 60);
  translate(width/2,height-height*0.074);
  
  line(0,0,(height-height*0.12)*cos(radians(xAngulo)),-(height-height*0.12)*sin(radians(xAngulo)));
  popMatrix();
}

//== Textos

void desenharTexto() {
  
  pushMatrix();
  
  // Limite de alcance.
  if( xDistancia > 40 ) {
  naoObjeto = "Sem Alcance";
  }
  else {
  naoObjeto = "Alcancado";
  }
  
  fill(0,0,0);
  noStroke();
  rect(0, height-height*0.0648, width, height);
  fill(98, 245, 31);
  textSize(25);
  
  text("10cm",width-width*0.3854,height-height*0.0833);
  text("20cm",width-width*0.281,height-height*0.0833);
  text("30cm",width-width*0.177,height-height*0.0833);
  text("40cm",width-width*0.0729,height-height*0.0833);
  textSize(40);
  text("HC-SR04: ", width-width*0.875, height-height*0.0277);
  text("Angle: " + xAngulo +" °", width-width*0.48, height-height*0.0277);
  text("Distance: ", width-width*0.26, height-height*0.0277);
  
  // Se a distancia for menor que 40 cms
  if( xDistancia < 40 ) {
  text("        " + xDistancia +" cm", width-width*0.225, height-height*0.0277);
  }
  
  textSize(25);
  fill(98, 245, 60);
  translate((width-width*0.4994)+width/2*cos(radians(30)),(height-height*0.0907)-width/2*sin(radians(30)));
  rotate(-radians(-60));
  text("30°",0,0);
  resetMatrix();
  
  translate((width-width*0.503)+width/2*cos(radians(60)),(height-height*0.0888)-width/2*sin(radians(60)));
  rotate(-radians(-30));
  text("60°",0,0);
  resetMatrix();
  
  translate((width-width*0.507)+width/2*cos(radians(90)),(height-height*0.0833)-width/2*sin(radians(90)));
  rotate(radians(0));
  text("90°",0,0);
  resetMatrix();
  
  translate(width-width*0.513+width/2*cos(radians(120)),(height-height*0.07129)-width/2*sin(radians(120)));
  rotate(radians(-30));
  text("120°",0,0);
  resetMatrix();
  
  translate((width-width*0.5104)+width/2*cos(radians(150)),(height-height*0.0574)-width/2*sin(radians(150)));
  rotate(radians(-60));
  text("150°",0,0);
  popMatrix(); 
  
}
