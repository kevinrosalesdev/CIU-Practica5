import queasycam.*;

class Controller{
  
  QueasyCam cam;
  boolean footPressed = false;
  boolean footSound = true;
  int flashlight = 500;
  int childModel = 500;
  float childModelTranslateX = 0;
  float childModelTranslateZ = 0;
  float childModelRotateY = 0;
  int footSoundCounter = 0;
  
  Controller(Practica5 gui){
    cam = new QueasyCam(gui);
    cam.sensitivity = 0.4;
    cam.speed = 0.75;
    cam.pan = 1.56;
    cam.tilt = -0.52;
  }
  
  void updateCamera(boolean isMenu){
    if (isMenu){
      cam.speed = 0;
      cam.position.x = 0;
      cam.position.y = -100;
      cam.position.z = -600;
      PVector cameraPos = cam.position;
      PVector cameraDir = cam.getForward();
      spotLight(255, 255, 255, cameraPos.x, cameraPos.y, cameraPos.z, cameraDir.x, cameraDir.y, cameraDir.z, TWO_PI, 10000);
      if (cam.pan >= 2.62) cam.pan = 2.62;
      else if (cam.pan <= 0.65) cam.pan = 0.65;
      if (cam.tilt >= 0.48) cam.tilt = 0.48;
      else if (cam.tilt <= -0.71) cam.tilt = -0.71;
    }else{
      cam.speed = 0.75;
      cam.velocity.y = 0;
      cam.position.y = 0;
      if (cam.tilt >= 0.65) cam.tilt = 0.65;
      else if (cam.tilt <= -0.87) cam.tilt = -0.87;
    }
  }
  
  void updateLights(){
    PVector cameraPos = cam.position;
    PVector cameraDir = cam.getForward();
    if (flashlight >= 500 || (int)random(0,10) == 0) spotLight(255, 255, 255, cameraPos.x, cameraPos.y, cameraPos.z, cameraDir.x, cameraDir.y, cameraDir.z, PI/2, 500);
    pointLight(20, 20, 20, cameraPos.x, cameraPos.y, cameraPos.z);
    flashlight++;
  }
  
  void wallsConstraints(){
    if(cam.position.x >= 467) cam.position.x = 467;
    if(cam.position.x <= -480) cam.position.x = -480;
    if(cam.position.z >= 326) cam.position.z = 326;
    if(cam.position.z <= -60) cam.position.z = -60;
  }
  
  QueasyCam getCamera(){
    return cam;
  }
  
  boolean footSound(){
    footSound = !this.footSound;
    return footSound;
  }
  
  boolean playSound(){
    footSoundCounter++;
    if (footSoundCounter >= 40){
     footSoundCounter = 0;
     return true;
    }
    return false;
  }
  
  void updateFootSound(){
    if (playSound()){
      if(footSound()) thread("leftFootEffect");
      else thread("rightFootEffect");
    }
  }
  
  void generateScarySounds(){
    if((int)random(0,1000) == 0){
      thread("sinisterChildLaughingEffect");
      childModelTranslateX = random(-480,467);
      childModelTranslateZ = random(-60,326);
      childModelRotateY = random(0,PI);
      childModel = 0;
    }else if ((int)random(0,3000) == 0){
      thread("scarySoundEffect");
    }else if ((int)random(0,1500) == 0){
      thread("electricityEffect");
      flashlight = 0;
    }  
  }
}
