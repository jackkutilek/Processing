class Gene
{
  int code; 
  
  Gene()
  {
    code = (int)random(10);
  }
}

class Person
{
  Body head;
  Body neck;
  Body torso;
  Body hip;
  Body rthigh;
  Body rshin;
  Body lthigh;
  Body lshin;
  RevoluteJoint rhip;
  RevoluteJoint rknee;
  RevoluteJoint lhip;
  RevoluteJoint lknee;
  
  Gene gene;
  
  Person(float px, float py)
  {
    gene = new Gene();
    
    BodyDef bd = new BodyDef();
    torso = physics.createRect(px-10,py-20,px+10,py+20);
    
    rthigh = physics.createRect(px-5,py+18,px+5,py+58);
    rhip = physics.createRevoluteJoint(torso,rthigh,px,py+20);
    
    rshin = physics.createRect(px-5,py+55,px+5,py+95);
    rknee = physics.createRevoluteJoint(rthigh,rshin,px,py+56);
    
    lthigh = physics.createRect(px-5,py+18,px+5,py+58);
    lhip = physics.createRevoluteJoint(torso,lthigh,px,py+20);
    
    lshin = physics.createRect(px-5,py+55,px+5,py+95);
    lknee = physics.createRevoluteJoint(lthigh,lshin,px,py+56);
  }
}
