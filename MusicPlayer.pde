import java.util.LinkedList;
//import ddf.minim.*;

public class MusicPlayer{
  
  //private Minim minim; 
  //private LinkedList<AudioPlayer> library;
  private LinkedList<SoundFile> library;
  private Controller controller;
  
  private int volume;
  private int currentSong;
  private boolean playing;
  
  public MusicPlayer(Controller controller){
    this.controller = controller;
    this.volume = 5;
    this.currentSong = 0;
    
    //this.minim = new Minim(controller.getParent());
    
    //this.library = new LinkedList<AudioPlayer>();
    //this.library.add(minim.loadFile("AltJ_Taro.mp3"));
    //this.library.add(minim.loadFile("AltJ_Matilda.mp3"));
    
    this.library = new LinkedList<SoundFile>();
    this.library.add(new Song(this.controller.getParent(), "AltJ_Taro.mp3",this.volume));
    this.library.add(new Song(this.controller.getParent(), "AltJ_Matilda.mp3",this.volume));
    this.library.add(new Song(this.controller.getParent(), "AltJ_Fitzpleasure.mp3",this.volume));
  }
  
  public void playPause(){
    if(playing) this.pauseSong();
    else this.playSong();
  }
  
  private void playSong(){
    //AudioPlayer song = this.library.get(currentSong);
    SoundFile song = this.library.get(currentSong);
    song.play();
    this.playing = true;
  }
  
  private void pauseSong(){
    //AudioPlayer song = this.library.get(currentSong);
    //song.pause(); 
    SoundFile song = this.library.get(this.currentSong);
    song.stop();
    this.playing = false;
  }
  
  public void nextSong(){
    //AudioPlayer song = this.library.get(currentSong);
    //song.pause();
    SoundFile song = this.library.get(this.currentSong);
    song.stop();
    this.playing = false;
    if(currentSong+1 < this.library.size()){
      this.currentSong++;
      this.playSong();
    }
  }
  
  public void previousSong(){
    //AudioPlayer song = this.library.get(currentSong);
    SoundFile song = this.library.get(this.currentSong);
    song.stop();
    this.playing = false;
    if(currentSong-1 >= 0){
      this.currentSong--;
      this.playSong();
    }
  }
  
  public void increaseVolume(){
    if(this.volume < 10) this.volume++;
    this.updateVolume();
  }
  
  public void decreaseVolume(){
    if(this.volume > 0) this.volume--;
    this.updateVolume();
  }
  
   public void setVolume(int volume){
    this.volume = volume;
    this.updateVolume();
  }
  
  public int getVolume(){
    return this.volume; 
  }
  
  private void updateVolume(){
    //AudioPlayer song = this.library.get(currentSong);
    SoundFile song = this.library.get(this.currentSong);
    float volume = this.volume/10.0;
    song.amp(volume);
  }
  
  public boolean isPlaying(){
    return this.playing;
  }
  
  public String getTitle(){
    return ((Song)this.library.get(this.currentSong)).getTitle(); 
  }
 
}

import processing.sound.*;
public class Song extends SoundFile{
  
  String title;
  
  public Song(PApplet parent, String path, int volume){
    super(parent, path);
    this.amp(volume/10.0);
    this.title = path.replaceAll("\\..*","");
    this.title = path.replaceAll("_"," - ");
  }
  
  public String getTitle(){
    return this.title;
  }
}
