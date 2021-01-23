public abstract class View{

  protected PImage minusSymbol;
  protected PImage plusSymbol;
  protected PImage playSymbol;
  protected PImage pauseSymbol;
  protected PImage volumeSymbol;
  protected PImage skipSymbol;
  protected PImage backSymbol;
  protected PImage forwardSymbol;
  protected PImage goBackSymbol;
  
  protected float boxWidth;
  protected float boxHeight;
  protected Controller controller;
  
  public View(Controller controller){
    this.minusSymbol = loadImage("minus.png");
    this.plusSymbol = loadImage("plus.png");
    this.playSymbol = loadImage("play.png");
    this.pauseSymbol = loadImage("pause.png");
    this.volumeSymbol = loadImage("volume.png");
    this.skipSymbol = loadImage("skip.png");
    this.backSymbol = loadImage("back.png");
    this.forwardSymbol = loadImage("forward.png");
    this.goBackSymbol = loadImage("goback.png");
    
    this.boxHeight = this.boxWidth = height/2.7;
    this.controller = controller;
  }
  
  public abstract void display(float yaw);
  
  protected void showTitle(){
   if(this.controller.isPlaying()) fill(255);
   else fill(50);
   String title = this.controller.getTitle();
   textSize(50);
   text(title, width/3, height/7);
  }
  /**
  Update Background.
  */
  protected void updateBackground(int timer){
    background(51, 65, 80);
    noStroke();
    fill(71, 85, 100); 
    rect(0, height, width, -timer);
  }
  
  /**
  Draw line between boxes.
  */
  protected void headLine() {
    stroke(255);
    strokeWeight(10);
    strokeCap(SQUARE);
    line(width/2-width/4+this.boxWidth/2, height/2, width/2+width/4-this.boxWidth/2, height/2);
  }
  
  /**
  Draw circle representing head.
  */
  protected void headVisual(float yaw) {
    strokeWeight(15);
    stroke(242, 101, 34);
    fill(239, 65, 54);
    ellipse(width/2+yaw*(width/4)/40, height/2, abs(yaw*2)-height/5, abs(yaw*2)-height/5);
  }
  
  /**
  Draw left box and fill with corresponding symbol.
  */
  protected void leftBox(String symbol, boolean leftPressed) {
    if (leftPressed) fill(191, 231, 164);
    else noFill();
    strokeWeight(2);
    stroke(255);
    rect(width/2-width/4-this.boxWidth/2, height/2-this.boxHeight/2, this.boxWidth, this.boxHeight);
    switch(symbol) {
      case "-":
        image(this.minusSymbol, width/2-width/4-this.boxWidth/4, height/2-this.boxHeight/20, this.boxWidth/2, this.boxHeight/10);
        break;
      case "play":
        image(this.playSymbol, width/2-width/4-this.boxWidth/40*8.5, height/2-this.boxHeight/16*4, this.boxWidth/20*8.5, this.boxHeight/8*4);
        break;
      case "pause":
        image(this.pauseSymbol, width/2-width/4-this.boxWidth/16*3, height/2-this.boxHeight/16*4, this.boxWidth/8*3, this.boxHeight/8*4);
        break;
      case "back":
        image(this.backSymbol, width/2-width/4-this.boxWidth/4, height/2-this.boxHeight/80*11, boxWidth/2, boxHeight/40*11);
        break;
      case "menu":
        image(this.goBackSymbol, width/2-width/4-this.boxWidth/4, height/2-this.boxHeight/80*9, boxWidth/2, boxHeight/40*9);
        break;
    }    
  }
  
  /**
  Draw right box and fill with corresponding symbol.
  */
  protected void rightBox(String symbol, boolean rightPressed) {
    if (rightPressed) fill(191, 231, 164);
    else noFill();
    strokeWeight(2);
    stroke(255);
    rect(width/2+width/4-this.boxWidth/2, height/2-this.boxHeight/2, this.boxWidth, this.boxHeight);
    switch(symbol) {
      case "+":
        image(this.plusSymbol, width/2+width/4-this.boxWidth/4, height/2-this.boxHeight/4, this.boxWidth/2, this.boxHeight/2);
        break;
      case "volume":
        image(this.volumeSymbol, width/2+width/4-this.boxWidth/4, height/2-this.boxHeight/16*3, this.boxWidth/2, this.boxHeight/8*3);
        break;
      case "skip":
        image(this.skipSymbol, width/2+width/4-this.boxWidth/16*5, height/2-this.boxHeight/32*3, this.boxWidth/8*5, this.boxHeight/16*3);
        break;
      case "forward":
        image(this.forwardSymbol, width/2+width/4-this.boxWidth/4, height/2-this.boxHeight/80*11, boxWidth/2, this.boxHeight/40*11);
        break;
    }
  }
  
}
