import processing.opengl.*;

import org.jbox2d.util.nonconvex.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.testbed.*;
import org.jbox2d.collision.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.p5.*;
import org.jbox2d.dynamics.*;

Physics physics;

void setup()
{
  size(800,600,OPENGL);
  frameRate(60);
  background(230,230,230);
  smooth();
  initScene();
}

void initScene()
{
  physics = new Physics(this, width, height, 0, -9.8,2*width,2*height, width, height, 30);
  physics.setDensity(1);
}

void draw()
{
  update();
  render();
}

void update()
{
  
}

void render()
{
  background(230,230,230);
  if (keyPressed) {
    if (key == '1') {
      physics.createCircle(mouseX, mouseY, random(5,10));
    } 
    else if (key == '2') {
      float sz = random(5,10);
      physics.createRect(mouseX - sz, mouseY - sz, mouseX + sz, mouseY + sz);
    }
    else if (key == '3') {
      float sz = random(10,20);
      physics.createPolygon(mouseX,      mouseY, 
                            mouseX+sz,   mouseY, 
                            mouseX+sz*.5,mouseY-sz);
    }
    else if (key == '4') {
      int nVerts = floor(random(4,8));
      float rad = random(5,10);
      float[] vertices = new float[nVerts*2];
      for (int i=0; i < nVerts; ++i) {
        vertices[2*i] = mouseX + rad*sin(TWO_PI*i/nVerts);
        vertices[2*i+1] = mouseY + rad*cos(TWO_PI*i/nVerts);
      }
      physics.createPolygon(vertices);
    }
      else {
      //Reset everything
      physics.destroy();
      initScene();
    }
  }
}
