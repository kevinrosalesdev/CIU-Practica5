Controller controller;

void setup(){
  fullScreen(P3D, SPAN);
  noCursor();
  controller = new Controller(this);
}

void draw(){
  background(0);
  sphere(75);
  controller.updateCamera();
}
