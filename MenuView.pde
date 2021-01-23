
public class MenuView extends View{
  
  private Controller controller;
  private int threshold;
  
  private boolean leftPressed;
  private boolean midPosition;
  private boolean switchedFunction;
  private boolean wentBack;
  private boolean volumeMiddle;
  private boolean skipMiddle; 
  private boolean midBoxPressed;
  private boolean midBoxIsGrowing;
  private boolean midBoxIsStatic;
  private boolean backToMenu;
  
  private int timer;
  private int timerSpeed;
  private int boxTimer;
  private int boxTimerSpeed;
  private int delay;
  
  MenuView(Controller controller){
    super(controller);
    this.controller = controller;
    this.threshold = 20;
    this.timer = 0;
    this.timerSpeed = 1;
    this.boxTimer = 0;
    this.boxTimerSpeed = 2;
    this.midBoxIsStatic = true;
    this.delay = 0;
  }
    
  void display(float yaw) {
    
    //Fill up timer and switch off 
    if (this.midPosition && !this.switchedFunction){
      if (this.timer >= height); //this.controller.switchView("Off");
      if (this.timer < height) this.timer += timerSpeed; 
    } 
    else if (this.timer > 0) this.timer = 0;
    
    if(yaw >= this.threshold){
      if (!this.volumeMiddle && !this.switchedFunction && !this.wentBack) {
        this.switchedFunction = true;
        this.volumeMiddle = true;
        this.skipMiddle = false;
      } 
      if (this.switchedFunction && this.wentBack) {
        if (this.volumeMiddle) {
          this.volumeMiddle = false;
          this.skipMiddle = true;
          this.wentBack = false;
        }
        else if (this.skipMiddle) {
          this.volumeMiddle = true;
          this.skipMiddle = false;
          this.wentBack = false;
        }
      }
      this.midPosition = false;      
    }
    else if(yaw <= -this.threshold){
      
      if(!this.backToMenu) this.leftPressed = true;
      this.midPosition = false;
      
      if(this.switchedFunction) this.reset();
      else if(!this.backToMenu) this.controller.playPauseSong();
    }
    else{
      if(this.backToMenu) this.backToMenu = false;
     
      this.leftPressed = false;
      this.midPosition = true;
      if(switchedFunction) this.wentBack = true;
      this.controller.resetAdjust();
    }
    
    super.updateBackground(this.timer);
    super.headLine();
    super.showTitle();
    
    if (!switchedFunction){
      this.backLayerBox();
      
      if(this.controller.isPlaying()) super.leftBox("pause", leftPressed);
      else super.leftBox("play", leftPressed);
    }
        
    if (volumeMiddle) {
      super.leftBox("menu",leftPressed);
      super.rightBox("skip", false);
      this.middleBox("volume");
      this.backLayerBoxLeft();
    } else super.rightBox("volume", false);
      
    if (skipMiddle) {
      super.leftBox("menu",leftPressed);
      super.rightBox("volume", false);
      this.middleBox("skip");
      this.backLayerBoxLeft();
    }
    
    super.headVisual(yaw);
  }
  
  /**
  */
  private void middleBox(String symbol) {
    
    //Draw box
    fill(51, 65, 80);
    strokeWeight(2);
    stroke(255);
    rect(width/2-boxWidth/2, height/2-boxHeight/2, boxWidth, boxHeight);
    fill(191, 231, 164);
    rect(width/2-boxWidth/2, height/2+boxHeight/2, boxWidth, -this.boxTimer);
    
    //Draw symbol
    switch(symbol) {
      case "volume":
        image(volumeSymbol, width/2-this.boxWidth/4, height/2-this.boxHeight/16*3, this.boxWidth/2, this.boxHeight/8*3);      
        break;
      case "skip":
        image(skipSymbol, width/2-this.boxWidth/16*5, height/2-this.boxHeight/32*3, this.boxWidth/8*5, this.boxHeight/16*3);
        break;
    }
    
    if(this.midPosition && !midBoxPressed) { 
      this.midBoxIsGrowing = true; 
      this.midBoxIsStatic = false; 
    } else this.midBoxIsGrowing = false;
    
    //Fill box timer
    if(this.midBoxIsGrowing && !this.midBoxIsStatic) this.boxTimer += this.boxTimerSpeed;
    if(!this.midBoxIsGrowing && !this.midBoxIsStatic && this.boxTimer > 0) this.boxTimer = 0;
    if(abs(boxTimer) >= boxHeight) { 
      this.midBoxIsGrowing = false; 
      this.midBoxIsStatic = true; 
      this.midBoxPressed = true;
    }
    
    //If selected, reset all parameters
    if(midBoxPressed) { 
      this.switchedFunction = false;
      this.wentBack = false;
      this.midBoxPressed = false;
      this.volumeMiddle = false;
      this.skipMiddle = false;
      this.boxTimer = 0;
      if (symbol == "volume") this.controller.switchView("Volume");
      if (symbol == "skip") this.controller.switchView("SwitchSong");
    }
  }
  
  /**
  Draw Second Box Behind the Right Function Box.
  */  
  private void backLayerBox() {
    fill(51, 65, 80);
    strokeWeight(2);
    stroke(255);
    line(width/2+width/4-boxWidth/2+boxWidth/8, height/2+boxHeight/2, width/2+width/4-boxWidth/2+boxWidth/8, height/2+boxHeight/2+boxHeight/8);
    line(width/2+width/4-boxWidth/2+boxWidth/8, height/2+boxHeight/2+boxHeight/8, width/2+width/4+boxWidth/2+boxWidth/8, height/2+boxHeight/2+boxHeight/8);
    line(width/2+width/4+boxWidth/2+boxWidth/8, height/2+boxHeight/2+boxHeight/8, width/2+width/4+boxWidth/2+boxWidth/8, height/2-boxHeight/2+boxHeight/8);
    line(width/2+width/4+boxWidth/2+boxWidth/8, height/2-boxHeight/2+boxHeight/8, width/2+width/4+boxWidth/2, height/2-boxHeight/2+boxHeight/8);
  }
  
  private void backLayerBoxLeft() {
    fill(51, 65, 80);
    strokeWeight(2);
    stroke(255);
    line(width/2-width/4-boxWidth/2, height/2-boxHeight/2+boxHeight/8, width/2-width/4-boxWidth/2-boxWidth/8, height/2-boxHeight/2+boxHeight/8);
    line(width/2-width/4-boxWidth/2-boxWidth/8, height/2-boxHeight/2+boxHeight/8, width/2-width/4-boxWidth/2-boxWidth/8, height/2+boxHeight/2+boxHeight/8);
    line(width/2-width/4-boxWidth/2-boxWidth/8, height/2+boxHeight/2+boxHeight/8, width/2-width/4+boxWidth/2-boxWidth/8, height/2+boxHeight/2+boxHeight/8);
    line(width/2-width/4+boxWidth/2-boxWidth/8, height/2+boxHeight/2+boxHeight/8, width/2-width/4+boxWidth/2-boxWidth/8, height/2+boxHeight/2);
  }
  
  private void reset(){
    this.switchedFunction = false;
    this.wentBack = false;
    this.midBoxPressed = false;
    this.volumeMiddle = false;
    this.skipMiddle = false;
    this.boxTimer = 0;
    this.midPosition = false;
    this.leftPressed = false;
    this.backToMenu = true;
  }
  
}
