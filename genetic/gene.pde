

class DNA
{
  Gene[] genes;
  int code; 
  //todo: ArrayList of values for variable length genes with multiple value options per slot (GTCA instead of just 01)
  DNA()
  {
    code = (int)random(65553);
    genes = new Gene[10];
    for(int i = 0; i < genes.length; i++)
    genes[i] = new Gene();
  }
  
  void update(Biped b)
  {
    
    for(int i = 0; i < genes.length; i++)
      genes[i].express(this,b);
  }
}

class Modifier
{
  int jointIndex;
  float amount;
  int inputIndex;
}

class Gene
{  
  Modifier[] modifiers;
  
  Gene()
  {
    int count = (int)random(10);
    modifiers = new Modifier[count];
    for(int i = 0; i < count; i++)
    {
      Modifier m = new Modifier();
      
      m.jointIndex = (int)random(10);
      m.inputIndex = (int)random(10);
      m.amount = random(100);
      modifiers[i] = m;
    }
  }
  
  void express(DNA dna, Biped b)
  {
    for(int i = 0; i < modifiers.length; i++)
    {
      Modifier m = modifiers[i];
      
      Vec2 input;
      switch(m.inputIndex)
      {
        case 0:
          println("lfoot");
          input = b.LFoot.getPosition();
          break;
        default:
          println("chest");
          input = b.Chest.getPosition();
          break;
      }
      
      switch(m.jointIndex)
      {
        case 0:
          b.RHip.setMotorSpeed(input.y*m.amount);
          break;
        case 1:
          break;
        case 2:
        println("set rkneww " + m.amount);
          b.RKnee.setMotorSpeed(10*m.amount);
          break;
        default:
          println("set lhip " + m.amount);
          b.LHip.setMotorSpeed(10*m.amount);
      }
    }
  }
}

class Person
{
  
  DNA dna;
  Biped biped;
  
  Person(float px, float py)
  {
    dna = new DNA();
    
    biped = new Biped(world,physics.screenToWorld(new Vec2(px,py)));
  }
  
  void update()
  {
    dna.update(biped);
  }
}
