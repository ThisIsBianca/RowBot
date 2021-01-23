
class OffView extends View{
  
  private Controller controller;
  
  
  public OffView(Controller controller){
    super(controller);
    this.controller = controller;
  }
  
  /**
  Draw all elements of the view.
  */
  public void display(float yaw){
    background(0,0,0);
  }
}
