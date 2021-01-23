import deadpixel.command.*;

public class SpeechThread extends Thread{
  
  boolean enter;
  Command cmd;
  
  public SpeechThread() {
      super("SpeechThread");
      //cmd = new Command("python /Volumes/Macintosh HD/Users/Steffen/Google Drive/DDM130/SpeechRecognition/Example.py");
      println(cmd);
      this.enter = false;
    } 
  
  public void run(){
    println("running");
    
    // run cmd command
    cmd.run();
    println("Success:", cmd);
    // Store output of the python code
    String[] output = cmd.getOutput();
    // Just to check, print all the output received from the python code and the first element 
    printArray(cmd.getOutput());
    println(output[0]);
    
    // Check if any of the output is equal to the control-music-command, if not: something went wrong...
    int i;
    for( i = 0; i< output.length; i++){
      this.enter = output[i].equals("control music");
      if (enter){
        println("Voice Recognition Successful");
        //exit();
       } 
       else if(i == output.length && !output[i].equals("control music")){
         println("Somthing went wrong");
       }  
    }
  }
   
  public boolean getSpeechState(){
    return enter;
  }
}
