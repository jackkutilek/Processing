import org.jbox2d.util.nonconvex.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.testbed.*;
import org.jbox2d.collision.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.p5.*;
import org.jbox2d.dynamics.*;

import processing.opengl.*;

Physics physics;
World world;
Body groundBody;

ArrayList group = new ArrayList();

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
  world = physics.getWorld();
  physics.setDensity(1);
  
  BodyDef bd = new BodyDef();
  groundBody = world.createBody(bd);
  
  group.add(new Person(100,100));
}

void draw()
{
  update();
  render();
}

void update()
{
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

MouseJoint mouseJoint;

void mousePressed()
{
   MouseJointDef mjd = new MouseJointDef();
   Vec2 target = physics.screenToWorld(mouseX,mouseY);
   mjd.target = target;
   mjd.maxForce = 1000;
   mjd.dampingRatio = .5;
   Person p = (Person)group.get(0);
   mjd.body1 = groundBody;
   mjd.body2 = p.torso;
   mouseJoint = (MouseJoint)physics.getWorld().createJoint(mjd);
}

void mouseDragged()
{
  mouseJoint.setTarget(physics.screenToWorld(mouseX,mouseY));
}

void mouseReleased()
{
  physics.removeJoint(mouseJoint);
}

void render()
{
  background(230,230,230);
  if(mousePressed)
  {
    Person p = (Person)group.get(0);
    Vec2 pos = physics.worldToScreen(p.torso.getPosition());
    line(mouseX,mouseY,pos.x,pos.y);
  }
}
