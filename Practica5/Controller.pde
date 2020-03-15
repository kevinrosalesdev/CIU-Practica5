import queasycam.*;

QueasyCam cam;

class Controller{
  
  Controller(Practica5 gui){
    cam = new QueasyCam(gui);
    cam.sensitivity = 0.4;
    cam.speed = 0.4;
  }
  
  void updateCamera(){
    cam.velocity = new PVector(0,0,0);
    cam.position = new PVector(0,0,0);
  }
}
