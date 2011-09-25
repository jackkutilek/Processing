
class slidebar
{
  PVector top;
  PVector bottom;
  float position;
  float boxwidth = 10;
  float boxheight = 10;
  boolean selected = false;
  boolean slide = false;
  float x;
  float y;
  float scaling;
  String name;
  
  slidebar(String pName, float xPos, int pLength, float pscale)
  {
    name = pName;
    x = xPos;
    y = pLength;
    scaling = pscale;
    top = new PVector(x,10);
    bottom = new PVector(x,10+y);
    position = y/3.0*2.0;
  }

  void draw(PGraphics gui)
  {
    if(slide && position < y+ 10)
      position += 0.25;
    else
      slide = false;
      
    gui.stroke(0);
    gui.line(top.x,top.y,bottom.x,bottom.y);
    gui.line(x - 5,10+y/2,x+5,10+y/2);
    if(selected)
      gui.fill(255);
    else if(slide)
      gui.fill(0,255,0);
    else
      gui.fill(100);
      
    gui.rect(x-boxwidth/2.0,position-boxheight/2.0,boxwidth,boxheight);
    gui.fill(0);
    gui.text(name + " " + nf(getValue(),2,1),x-10,30+y);
    //line(mouseX,mouseY,500,position);
    
  }
  
  float getValue()
  {
     return (position-10-y/2.0)/y*scaling;
  }
  
  void mousePressed()
  {
    if((abs(mouseX-x) < boxwidth/2.0) && (abs(mouseY - position) < boxheight/2.0))
    {
      slide = false;
      selected = true;
    } 
    if((abs(mouseX-x) < 15) && (abs(mouseY - y - 20) < 10))
      slide = !slide;
  }
  
  void mouseReleased()
  {
      selected = false;
  }

  void mouseDragged()
  {
    if(selected && mouseY > 10 && mouseY < y + 10)
    {
      position = mouseY;
    }
  }
}
