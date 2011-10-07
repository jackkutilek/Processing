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

boolean fastSimulate = true;

PFont font;

Person[] group = new Person[4];
int groupCount;

DNA[] population;;
int populationIndex = 0;

int generation = 0;

void setup()
{
  size(1600,600,OPENGL);
  frameRate(60);
  background(230,230,230);
  smooth();
  font = loadFont("ArialMT-48.vlw");
  textFont(font);
  textSize(24);
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
  
  pos = physics.screenToWorld(800,200);
  bd.position.set(pos);
  Body b2 = world.createBody(bd);
  b2.createShape(s);
  
  pos = physics.screenToWorld(1200,200);
  bd.position.set(pos);
  Body b3 = world.createBody(bd);
  b3.createShape(s);
  
  population = new DNA[50];
  for(int i = 0; i < 50; i++)
  {
    population[i] = (new DNA());
  }
  
  group[0] = new Person(200,500,population[0]);
  group[1] = new Person(600,500,population[1]);
  group[2] = new Person(1000,500,population[2]);
  group[3] = new Person(1400,500,population[3]);
  populationIndex = 4;
  groupCount = 4;
}

void draw()
{
  update();
  render();
}

void update()
{
  if(count > 300)
  {
    if(populationIndex == population.length)
    {
      population = getNextGeneration();
      populationIndex = 0;
    }
    groupCount = 0;
    for(int i = 0; i < group.length; i++)
    {
      if(group[i] != null)
      {
      group[i].Remove();
      group[i] = null;
      }
      if(populationIndex < population.length)
      {
        groupCount++;
        group[i] = new Person(200+400*(i),500,population[populationIndex++]);
      }
    }
    count = 0;
    
  }
  
  for(int j = 0; j < (fastSimulate?5:1); j++)
  {
    if(j != 0)
      world.step((1/60.f),8);
    for(int i = 0; i < group.length; i++)
    {
      if(group[i] != null)
        group[i].update();
    }
    count++;
  }
}

void render()
{
  background(230,230,230);
  
  text("generation: " + generation,50,50);
  
  for(int i = 0; i < groupCount; i++)
  {
    float r = group[i].dna.rating;
    text("person " + (populationIndex-groupCount+i) + "\n",50 + 400*i,160);
    text(r, 150 + 400*i - textWidth("" + floor(r)) - ((r < 0)?textWidth("-"):0),200);
    text("genecount: " + group[i].dna.genes.length,50+400*i,220);
  }
  
  
  if(mousePressed)
  {
    Person p = group[0];
    Vec2 pos = physics.worldToScreen(p.biped.Chest.getPosition());
    line(mouseX,mouseY,pos.x,pos.y);
  }
}

void keyPressed()
{
  if(key == 's')
    fastSimulate = !fastSimulate;
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

DNA[] getNextGeneration()
{
  PopulationSort(population);
  
  int index = 10;
  while(index < population.length && population[index].rating < 400)
    index++;
  index += population.length/5;
  if(index > population.length)
    index = population.length;
  int newCount = population.length/5;
  if(population.length < 30)
    newCount += 10;
  DNA[] newGen = new DNA[index + newCount];
  println("newGen.length: " + newGen.length);
  for(int i = 0; i < index; i++)
  {
    newGen[i] = new DNA(population[i],population[(int)random(index)]);
    if(newGen[i] != null)
      println(i);
  }
  
  for(int i = 0; i < newCount; i++)
  {
    newGen[index+i] = new DNA();
    if(newGen[index+i] != null)
      println(index+i);
  }
  
  
  return newGen;
}

void PopulationSort(DNA[] pop)
{
  quicksort(pop,0,pop.length-1);
  println("sort results:");
  for(int i = 0; i < pop.length; i++)
  {
    println(pop[i].rating);
  }
}

void quicksort(DNA[] pop, int left, int right)
{
  int index = partition(pop,left,right);
  if(left < index-1)
    quicksort(pop,left,index-1);
  if(index < right)
    quicksort(pop,index,right);
}

int partition(DNA[] pop, int left, int right)
{
  int pivot = (left+right)/2;
  DNA tmp;
  while(left <= right)
  {
    while(left < pop.length && pop[left].rating < pop[pivot].rating)
      left++;
    while(right >= 0 && pop[right].rating < pop[pivot].rating)
      right--;
    if(left <= right)
    {
      tmp = pop[left];
      pop[left] = pop[right];
      pop[right] = tmp;
      left++;
      right--;
    }
  }
  return left;
}
