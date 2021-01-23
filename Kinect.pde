import KinectPV2.*;

public class Kinect{
  
  private Controller controller;
  private KinectPV2 kinect;
  
  private float Q = 0.000001;
  private float R = 0.0001;
  private float P = 1, X = 0, K;
  
  private MedianFilter medFilter;
  
  public Kinect(Controller controller){
    this.controller = controller;
    this.kinect = new KinectPV2(this.controller.getParent());
    this.kinect.enableFaceDetection(true);
    this.kinect.init();
    this.medFilter = new MedianFilter(15);
  }
  
  /**
  */
  public float getYaw3(){
    float rand = random(-5,5);
    return (mouseX-width/2)/10+rand;
  }
  
  public float getYaw(){
    float rand = random(-5,5);
    float yaw = (mouseX-width/2)/10+rand;
    //yaw = update(yaw);
    yaw = this.medFilter.update(yaw);
    //println(yaw);
    return yaw; 
  }
  
  /**
  */
  public float getYaw2(){
    this.kinect.generateFaceData();
    ArrayList<FaceData> faceData = this.kinect.getFaceData();
    for (int i = 0; i < faceData.size(); i++) {
      FaceData faceD = faceData.get(i);
      if (faceD.isFaceTracked()) {
        float yaw = faceD.getYaw();
        return medFilter.update(-yaw);
      }
    }
    return 0;
  }

  private void measurementUpdate()
  {
      this.K = (this.P + this.Q) / (this.P + this.Q + this.R);
      this.P = this.R * (this.P + this.Q) / (this.R + this.P + this.Q);
  }

  public float update(float measurement)
  {
      measurementUpdate();
      float result = this.X + (measurement - this.X) * this.K;
      this.X = result;
      return result;
  }
}