

class DNA
{
  Gene[] genes;
  
  DNA()
  {
    genes = new Gene[10];
    for(int i = 0; i < genes.length; i++)
    genes[i] = new Gene();
  }
  
  DNA(DNA parentA, DNA parentB)
  {
    int aSplit = (int)random(parentA.genes.length);
    int bSplit = (int)random(parentB.genes.length);
    genes = new Gene[aSplit + bSplit];
    for(int i = 0; i < aSplit; i++)
      genes[i] = parentA.genes[i].Mutate();
    for(int i = 0; i < bSplit; i++)
      genes[i] = parentB.genes[i].Mutate();
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
  Modifier m;
  
  Gene()
  {
    m = new Modifier();
    m.jointIndex = (int)random(20);
    m.inputIndex = (int)random(20);
    m.amount = random(100);
  }
  
  Gene Mutate()
  {
      if((int)random(1000) == 1)
      {
        m.jointIndex = (int)random(20);
      }
      if((int)random(1000) == 1)
      {
        m.inputIndex = (int)random(20);
      }
      if((int)random(1000) == 1)
      {
        m.amount = (int)random(100);
      }
    return this;
  }
  
  void express(DNA dna, Biped b)
  {
      float input;
      switch(m.inputIndex)
      {
        case 0:
          input = b.RFoot.getLinearVelocity().x;
          break;
        case 1:
          input = b.RFoot.getLinearVelocity().y;
          break;
        case 2:
          input = b.LFoot.getLinearVelocity().x;
          break;
        case 3:
          input = b.LFoot.getLinearVelocity().y;
          break;
        case 4:
          input = b.RHand.getLinearVelocity().x;
          break;
        case 5:
          input = b.RHand.getLinearVelocity().y;
          break;
        case 6:
          input = b.LHand.getLinearVelocity().x;
          break;
        case 7:
          input = b.LHand.getLinearVelocity().y;
          break;
        case 8:
          input = b.RCalf.getLinearVelocity().x;
          break;
        case 9:
          input = b.RCalf.getLinearVelocity().y;
          break;
        case 10:
          input = b.LCalf.getLinearVelocity().x;
          break;
        case 11:
          input = b.LCalf.getLinearVelocity().y;
          break;
        case 12:
          input = b.RThigh.getLinearVelocity().x;
          break;
        case 13:
          input = b.RThigh.getLinearVelocity().y;
          break;
        case 14:
          input = b.LThigh.getLinearVelocity().x;
          break;
        case 15:
          input = b.LThigh.getLinearVelocity().y;
          break;
        case 16:
          input = b.Pelvis.getLinearVelocity().x;
          break;
        case 17:
          input = b.Pelvis.getLinearVelocity().y;
          break;
        case 18:
          input = b.Stomach.getLinearVelocity().x;
          break;
        case 19:
          input = b.Stomach.getLinearVelocity().y;
          break;
        default:
          input = b.Chest.getLinearVelocity().x;
          break;
      }
      
      switch(m.jointIndex)
      {
        case 0:
          b.RHip.setMotorSpeed(b.RHip.getJointSpeed() + input*m.amount);
          break;
        case 1:
          b.LHip.setMotorSpeed(b.LHip.getJointSpeed() + input*m.amount);
          break;
        case 2:
          b.RKnee.setMotorSpeed(b.RKnee.getJointSpeed() + input*m.amount);
          break;
        case 3:
          b.LKnee.setMotorSpeed(b.LKnee.getJointSpeed() + input*m.amount);
          break;
        case 4:
          b.RShoulder.setMotorSpeed(b.RShoulder.getJointSpeed() + input*m.amount);
          break;
        case 5:
          b.LShoulder.setMotorSpeed(b.LShoulder.getJointSpeed() + input*m.amount);
          break;
        case 6:
          b.RElbow.setMotorSpeed(b.RElbow.getJointSpeed() + input*m.amount);
          break;
        case 7:
          b.LElbow.setMotorSpeed(b.LElbow.getJointSpeed() + input*m.amount);
          break;
        case 8:
          b.LowerAbs.setMotorSpeed(b.LowerAbs.getJointSpeed() + input*m.amount);
          break;
        case 9:
          b.UpperAbs.setMotorSpeed(b.UpperAbs.getJointSpeed() + input*m.amount);
          break;
        case 10:
          b.LAnkle.setMotorSpeed(b.LAnkle.getJointSpeed() + input*m.amount);
          break;
        case 11:
          b.RAnkle.setMotorSpeed(b.RAnkle.getJointSpeed() + input*m.amount);
          break;
        default:
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
  
  Person(float px, float py, Person parentA, Person parentB)
  {
    dna = new DNA(parentA.dna,parentB.dna);
    biped = new Biped(world,physics.screenToWorld(new Vec2(px,py)));
  }
  
  void Remove()
  {
    biped.Remove();
  }
  
  void update()
  {
    dna.update(biped);
  }
}
