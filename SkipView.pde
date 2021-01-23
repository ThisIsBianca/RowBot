
class SkipView extends View{
  
  private int threshold;
  private int timer;
  private int timerSpeed;
  private int delay;
  
  private Controller controller;
  
  private boolean leftPressed;
  private boolean rightPressed;
  private boolean midPosition;
  
  public SkipView(Controller controller){
    super(controller);
    this.threshold = 20;
    this.controller = controller;
    this.timer = 0;
    this.timerSpeed = 2;
    this.delay = 100;
  }
  
  /**
  Draw all elements of the view.
  */
  public void display(float yaw){
    
    if(this.delay > 0) this.delay--;
    else{
      //Fill up timer and switch back to menu 
      if (this.midPosition){
        if (this.timer >= height){
          this.timer = 0;
          this.delay = 100;
          this.controller.switchView("Menu");
        }
        if (this.timer < height) this.timer += this.timerSpeed; 
      } 
      else if (this.timer > 0) this.timer = 0;
     
    //Adjust Volume if above threshold
    if(yaw >= this.threshold){
      this.rightPressed = true;
      this.midPosition = false;
      this.controller.switchSong(1);
    }
    else if(yaw <= -this.threshold){
      this.leftPressed = true;
      this.midPosition = false;
      this.controller.switchSong(-1);
    }
    else{
      this.leftPressed = rightPressed = false;
      this.midPosition = true;
      this.controller.resetAdjust();
    }
  }
    
    //Draw elements
    super.updateBackground(this.timer);    
    super.headLine();
    super.showTitle();
    super.leftBox("back", this.leftPressed);
    super.rightBox("forward", this.rightPressed);
    super.headVisual(yaw);
    
  }

  
}
