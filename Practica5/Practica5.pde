import queasycam.*;
import processing.sound.*;

PShape room, floor, flashlight, child;
SoundFile leftFootEffect, rightFootEffect, sinisterChildLaughingEffect, scarySoundEffect, electricityEffect;
Controller controller;
boolean isMenu = true;
boolean increase = true;
float blink = 0.0;
PFont font;

void setup(){
  fullScreen(P3D, 1);
  noCursor();
  noStroke();
  leftFootEffect = new SoundFile(this, "soundeffects/steps/left-foot.wav");
  rightFootEffect = new SoundFile(this, "soundeffects/steps/right-foot.wav");
  sinisterChildLaughingEffect = new SoundFile(this, "soundeffects/scary/sinister-child-laughing.wav");
  scarySoundEffect = new SoundFile(this, "soundeffects/scary/scary-sound.wav");
  electricityEffect = new SoundFile(this, "soundeffects/flashlight/electricity.wav");
  font = loadFont("ArialNarrow-48.vlw");
  controller = new Controller(this);
  setRoom();
  setFlashlight();
  setChild();
}

void draw(){
  background(5);
  translate(0,0,0);
  controller.updateLights();
  drawRoom();
  if (isMenu) drawMenu();
  else{
    drawFlashlight();
    if(controller.footPressed) controller.updateFootSound();
    controller.generateScarySounds();
    if(controller.childModel < 500) drawChild();
    controller.updateCamera(false);
    controller.wallsConstraints();
  }
}

void drawMenu(){
  controller.updateCamera(true);
  pushMatrix();
  translate(width/2, -height/2, -225);
  rotateY(PI);
  fill(255, 125, 125, blink());
  textAlign(CENTER);
  textFont(font, 35);
  text("Escenario de Terror", 0.5*width, 0.1*height);
  fill(255, 125, 125);
  textFont(font, 15);
  text("Pulse ENTER para vivir una experiencia de terror", 0.5*width, 0.12*height);
  text("Tenga cuidado con la niña y con las pilas de su linterna", 0.5*width, 0.14*height);
  fill(255, 255, 0);
  textFont(font, 25);
  text("CONTROLES", 0.5*width, 0.18*height);
  textFont(font, 20);
  text("Girar cámara: movimiento de ratón", 0.5*width, 0.2*height);
  text("Caminar (tras pulsar ENTER): A/W/S/D", 0.5*width, 0.22*height);
  text("Volver a este menú: ENTER", 0.5*width, 0.24*height);
  popMatrix();
}

float blink() {
  if (increase) blink += 5;
  else blink -= 5 ;
  if (blink >= 500) increase = false;
  if (blink <= 0) increase = true;
  return blink;
}


void setRoom(){
  room = loadShape("models/room/abandoned_cottage.obj");
  floor = loadShape("models/floor/CobbleStones2.obj");
  room.scale(1);
  floor.scale(125);
}

void setFlashlight(){
  flashlight = loadShape("models/flashlight/Linterna.obj");
  flashlight.scale(1);
}

void setChild(){
  child = loadShape("models/girl/girl_s.obj");
  child.scale(60);
}

void drawRoom(){
  pushMatrix();
  translate(0,100);
  rotateX(radians(180));
  shape(room);
  popMatrix();
  
  pushMatrix();
  translate(-100, 50);
  shape(floor);
  popMatrix();
}

void drawFlashlight(){
  pushMatrix();
  PVector cameraPos = controller.getCamera().position;
  PVector cameraDir = controller.getCamera().getForward();
  translate(cameraPos.x+(10*cameraDir.x), cameraPos.y+3, cameraPos.z+(6*cameraDir.z));
  if (cameraDir.z < 0) rotateX(HALF_PI + cameraDir.y*HALF_PI);
  if (cameraDir.z >= 0) rotateX(HALF_PI - cameraDir.y*HALF_PI);
  if (cameraDir.x < 0) rotateZ(HALF_PI + atan(cameraDir.z/(cameraDir.x+0.00000001)));
  if (cameraDir.x >= 0) rotateZ(-HALF_PI + atan(cameraDir.z/(cameraDir.x+0.00000001)));
  shape(flashlight);
  popMatrix();
}

void drawChild(){
  pushMatrix();
  translate(controller.childModelTranslateX, 100, controller.childModelTranslateZ);
  rotateX(PI);
  rotateY(controller.childModelRotateY);
  shape(child);
  controller.childModel++;
  popMatrix();
}

void keyPressed(){
  if (key == 'w' || key == 'W' || key == 'a' || key == 'A' || key == 's' || key == 'S' || key == 'd' || key == 'D'){
    controller.footPressed = true;
  }
}

void keyReleased(){
  if (key == 'w' || key == 'W' || key == 'a' || key == 'A' || key == 's' || key == 'S' || key == 'd' || key == 'D'){
    controller.footPressed = false;
  }else if (key == ENTER || key == RETURN){
    isMenu = !isMenu;
    if (!isMenu) loop();
  }
}

void leftFootEffect(){
  leftFootEffect.play();
}

void rightFootEffect(){
  rightFootEffect.play();
}

void sinisterChildLaughingEffect(){
  sinisterChildLaughingEffect.play();  
}

void scarySoundEffect(){
  scarySoundEffect.play();  
}

void electricityEffect(){
  electricityEffect.play();
}
