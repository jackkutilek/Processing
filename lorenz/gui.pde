class GUI
{
  PGraphics graphics;
  
  slidebar rhoControl;
  slidebar betaControl;
  slidebar sigmaControl;
  
  GUI()
  {
      graphics = createGraphics(width,height,JAVA2D);
      rhoControl = new slidebar("p",550,350,200);
      betaControl = new slidebar("B",485,350,20);
      sigmaControl = new slidebar("S",420,350,200);
  }
  
  boolean selected()
  {
    return rhoControl.selected || betaControl.selected || sigmaControl.selected;
  }
  
  void draw()
  {
    rhoControl.draw(graphics);
    betaControl.draw(graphics);
    sigmaControl.draw(graphics);
  }
  
  void mousePressed()
  {
    rhoControl.mousePressed();
    betaControl.mousePressed();
    sigmaControl.mousePressed();
  }
  
  void mouseReleased()
  {
    rhoControl.mouseReleased();
    betaControl.mouseReleased();
    sigmaControl.mouseReleased();
  }
  
  void mouseDragged()
  {
    rhoControl.mouseDragged();
    betaControl.mouseDragged();
    sigmaControl.mouseDragged();
  }
}
