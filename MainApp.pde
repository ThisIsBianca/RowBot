Controller controller;

void setup() {
  //size(1280, 800);
  fullScreen();
  controller = new Controller(this);
}

void draw(){
  controller.displayCurrentView();
} //<>//