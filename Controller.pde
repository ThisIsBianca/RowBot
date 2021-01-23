

public class Controller{
   
  private boolean adjust;
  private boolean listening;
  
  private int currentView;
  private View[] view;
  private Kinect kinect;
  private MusicPlayer player;
  private PApplet parent;
  private SpeechThread speechThread;
  
  public Controller(PApplet parent){
    this.parent = parent;
    
    this.view = new View[4];
    this.view[0] = new OffView(this);
    this.view[1] = new MenuView(this);
    this.view[2] = new VolumeView(this);
    this.view[3] = new SkipView(this);
    
    this.speechThread = new SpeechThread();
    
    this.kinect = new Kinect(this);
    this.player = new MusicPlayer(this);
    
    this.currentView = 1;
  }
  
  /**
  Display the view that is currently active
  */
  public void displayCurrentView(){
    float yaw = this.kinect.getYaw2();
    this.view[currentView].display(yaw);
    
    if(this.currentView == 0 & !this.listening){
      //this.speechThread.start();
      this.listening = true;
    }
    
    boolean enter = false;
    if(this.listening){
      //enter = this.speechThread.getSpeechState();
      //println(enter);
    }
    
    if(enter){
      //this.speechThread.interrupt();
      this.listening = false;
      this.switchView("Menu");  //Switch to menu view
    }
  }
  
  /**
  Increases the volume of the song for 1 and decreases for -1.
  */
  public void adjustVolume(int direction){
    if(adjust){
      switch(direction){
        case 1:
          this.player.increaseVolume();
          break;
        case -1: 
          this.player.decreaseVolume();
          break;
      }
      this.adjust = false;
    }
  }
  
  /**
  Plays or pauses current song dependent on its status.
  */
  public void playPauseSong(){
    if(adjust){
      this.player.playPause();
      this.adjust = false;
    }
  }
  
  /**
  Switches to next song for 1 and to previous song for -1
  */
  public void switchSong(int direction){
    if(adjust){
      switch(direction){
        case 1:
          this.player.nextSong();
          break;
        case -1: 
          this.player.previousSong();
          break;
      }
      this.adjust = false;
    }
  }
  
  /**
  Make adjustment available again when returning head to midpoint
  */
  public void resetAdjust(){
    this.adjust = true;
  }
  
  /**
  Switch to a different view indicated by name.
  */
  public void switchView(String view){
     switch(view){
       case "Off": this.currentView = 0; break;
       case "Menu": this.currentView = 1; break;
       case "Volume": this.currentView = 2; break;
       case "SwitchSong": this.currentView = 3; break;
     }
  }
  
  /**
  Returns the volume of music player
  */
  public int getVolume(){
   return this.player.getVolume(); 
  }
  
  public boolean isPlaying(){
   return this.player.isPlaying(); 
  }
  
  public PApplet getParent(){
    return this.parent;
  }
  
  public String getTitle(){
   return this.player.getTitle(); 
  }
}