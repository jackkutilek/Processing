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

int count = 0;
int totalcount = 0;

Person[] group = new Person[2];

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
  
  
  Vec2 pos = physics.screenToWorld(400,200);
  bd.position.set(pos);
  PolygonDef s = new PolygonDef();
  s.setAsBox(.2,500);
  
  Body b = world.createBody(bd);
  b.createShape(s);
  
  group[0] = new Person(200,500);
  group[1] = new Person(600,500);
}

void draw()
{
  update();
  render();
}

void update()
{
  if(count == 500)
  {
    for(int i = 0; i < group.length; i++)
    {
      group[i].Remove();
      group[i] = new Person(200+400*(i),500);
    }
    count = 0;
    totalcount++;
  }
  
  
  
  for(int i = 0; i < group.length; i++)
  {
    Person p = group[i];
    p.update();
  }
  
  count++;
}

MouseJoint mouseJoint;

void mousePressed()
{
   Person p = group[0];
   MouseJointDef mjd = new MouseJointDef();
   Vec2 target = physics.screenToWorld(mouseX,mouseY);
   mjd.target = target;
   mjd.maxForce = 1000*p.biped.Chest.m_mass;
   mjd.dampingRatio = .5;
   mjd.body1 = groundBody;
   mjd.body2 = p.biped.Chest;
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
    Person p = group[0];
    Vec2 pos = physics.worldToScreen(p.biped.Chest.getPosition());
    line(mouseX,mouseY,pos.x,pos.y);
  }
}

