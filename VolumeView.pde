
class VolumeView extends View{
  
  private int threshold;
  private int timer;
  private int delay;
  private int timerSpeed;
  private int onButton;
  private int adjustSpeed;
  private int buttonDelay;
  private int bd;
  
  private Controller controller;
  
  private boolean leftPressed;
  private boolean rightPressed;
  private boolean midPosition;
  
  public VolumeView(Controller controller){
    super(controller);
    this.threshold = 20;
    this.controller = controller;
    this.timer = 0;
    this.timerSpeed = 2;
    this.delay = 100;
    this.onButton = 0;
    this.adjustSpeed = 25;
    this.bd = 50;
    this.buttonDelay = this.bd;
  }
  
  /**
  Draw all elements of the view.
  */
  public void display(float yaw){
    
    if(this.delay > 0) this.delay--;
    else{
      //Fill up timer and switch back to menu 
      if (this.midPosition){
        if (this.timer >= height) {
          this.timer = 0;
          this.delay = 100;
          this.controller.switchView("Menu");
        }
        if (this.timer < height) this.timer += this.timerSpeed; 
      } 
      else if (this.timer > 0) this.timer = 0;//this.timer - 15;
      
    //Adjust Volume if above threshold
    if(yaw >= this.threshold){
      this.rightPressed = true;
      this.midPosition = false;
      if(this.buttonDelay == this.bd){
        this.controller.adjustVolume(1);
        this.controller.resetAdjust();
      }
      if(this.buttonDelay > 0) this.buttonDelay--;
      if(this.onButton % this.adjustSpeed == 0 && this.buttonDelay == 0){
        this.controller.adjustVolume(1);
        this.controller.resetAdjust();
      }
      if(this.buttonDelay == 0){
        this.onButton++;
      }
    }
    else if(yaw <= -this.threshold){
      this.leftPressed = true;
      this.midPosition = false;
       if(this.buttonDelay == this.bd){
        this.controller.adjustVolume(-1);
        this.controller.resetAdjust();
      }
      if(this.buttonDelay > 0) this.buttonDelay--;
      if(this.onButton % this.adjustSpeed == 0 && this.buttonDelay == 0){
        this.controller.adjustVolume(-1);
        this.controller.resetAdjust();
      }
      if(this.buttonDelay == 0){
        this.onButton++;
      }
    }
    else{
      this.leftPressed = rightPressed = false;
      this.midPosition = true;
      this.onButton = 0;
      this.buttonDelay = this.bd;
      this.controller.resetAdjust();
    }
    }
    
    //Draw elements
    super.updateBackground(this.timer);    
    super.headLine();
    super.showTitle();
    super.leftBox("-", this.leftPressed);
    super.rightBox("+", this.rightPressed);
    super.headVisual(yaw);
    this.volumeVisual(this.controller.getVolume());
  }

  /**
  Draw Volume Bar.
  */
  private void volumeVisual(int volume){
    pushMatrix();
    image(super.volumeSymbol, width/2-75, height/5*4-75, this.boxWidth/8*3, this.boxHeight/10*3);
    translate(width/2-145, height/5*4+100);
    noFill();
    strokeWeight(2);
    stroke(255);
    rectMode(CORNER);
    
    for (int x = 0; x < 300; x += 30) {
      rect(x, 0, 20, 10);
    }
    for (int y = 0; y < volume; y++) {
      fill(255);
      rect(30*y, 0, 20, 10);
    }
    popMatrix();
  }
}
