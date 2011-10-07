

class DNA
{
  Gene[] genes;
  float rating;
  
  DNA()
  {
    genes = new Gene[40];
    for(int i = 0; i < genes.length; i++)
    genes[i] = new Gene();
    rating = 0;
  }
  
  DNA(DNA parentA, DNA parentB)
  {
    int aSplit = (int)random(parentA.genes.length);
    int bSplit = (int)random(parentB.genes.length);
    genes = new Gene[aSplit + parentB.genes.length - bSplit];
    for(int i = 0; i < aSplit; i++)
      genes[i] = parentA.genes[i].Mutate();
      
    for(int i = bSplit; i < parentB.genes.length; i++)
      genes[aSplit + i - bSplit] = parentB.genes[i].Mutate();
      
    rating = 0;
  }
  
  void update(Biped b)
  {
    for(int i = 0; i < genes.length; i++)
    {
      genes[i].express(this,b);
    }
    updateRating(b);
  }
  
  void updateRating(Biped b)
  {
    rating += abs(b.Chest.getAngle());
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
    m.inputIndex = (int)random(68);
    m.amount = random(100)-50;
  }
  
  Gene Mutate()
  {
      if((int)random(1000) == 1)
      {
        m.jointIndex = (int)random(20);
      }
      if((int)random(1000) == 1)
      {
        m.inputIndex = (int)random(68);
      }
      if((int)random(1000) == 1)
      {
        m.amount = (int)random(100)-50;
      }
      if((int)random(1000) == 1)
      {
        m.amount *= random(2)-1;
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
        case 20:
          input = b.Chest.getLinearVelocity().x;
          break;
        case 21:
          input = b.Chest.getLinearVelocity().y;
          break;
        case 22:
          input = b.Neck.getLinearVelocity().x;
          break;
        case 23:
          input = b.Neck.getLinearVelocity().y;
          break;
        case 24:
          input = b.Head.getLinearVelocity().x;
          break;
        case 25:
          input = b.Head.getLinearVelocity().y;
          break;
        case 26:
          input = b.RUpperArm.getLinearVelocity().x;
          break;
        case 27:
          input = b.RUpperArm.getLinearVelocity().y;
          break;
        case 28:
          input = b.LUpperArm.getLinearVelocity().x;
          break;
        case 29:
          input = b.LUpperArm.getLinearVelocity().y;
          break;
        case 30:
          input = b.RForearm.getLinearVelocity().x;
          break;
        case 31:
          input = b.RForearm.getLinearVelocity().y;
          break;
        case 32:
          input = b.LForearm.getLinearVelocity().x;
          break;
        case 33:
          input = b.LForearm.getLinearVelocity().y;
          break;
        case 34:
          input = b.RFoot.getPosition().x;
          break;
        case 35:
          input = b.RFoot.getPosition().y;
          break;
        case 36:
          input = b.LFoot.getPosition().x;
          break;
        case 37:
          input = b.LFoot.getPosition().y;
          break;
        case 38:
          input = b.RHand.getPosition().x;
          break;
        case 39:
          input = b.RHand.getPosition().y;
          break;
        case 40:
          input = b.LHand.getPosition().x;
          break;
        case 41:
          input = b.LHand.getPosition().y;
          break;
        case 42:
          input = b.RCalf.getPosition().x;
          break;
        case 43:
          input = b.RCalf.getPosition().y;
          break;
        case 44:
          input = b.LCalf.getPosition().x;
          break;
        case 45:
          input = b.LCalf.getPosition().y;
          break;
        case 46:
          input = b.RThigh.getPosition().x;
          break;
        case 47:
          input = b.RThigh.getPosition().y;
          break;
        case 48:
          input = b.LThigh.getPosition().x;
          break;
        case 49:
          input = b.LThigh.getPosition().y;
          break;
        case 50:
          input = b.Pelvis.getPosition().x;
          break;
        case 51:
          input = b.Pelvis.getPosition().y;
          break;
        case 52:
          input = b.Stomach.getPosition().x;
          break;
        case 53:
          input = b.Stomach.getPosition().y;
          break;
        case 54:
          input = b.Chest.getPosition().x;
          break;
        case 55:
          input = b.Chest.getPosition().y;
          break;
        case 56:
          input = b.Neck.getPosition().x;
          break;
        case 57:
          input = b.Neck.getPosition().y;
          break;
        case 58:
          input = b.Head.getPosition().x;
          break;
        case 59:
          input = b.Head.getPosition().y;
          break;
        case 60:
          input = b.RUpperArm.getPosition().x;
          break;
        case 61:
          input = b.RUpperArm.getPosition().y;
          break;
        case 62:
          input = b.LUpperArm.getPosition().x;
          break;
        case 63:
          input = b.LUpperArm.getPosition().y;
          break;
        case 64:
          input = b.RForearm.getPosition().x;
          break;
        case 65:
          input = b.RForearm.getPosition().y;
          break;
        case 66:
          input = b.LForearm.getPosition().x;
          break;
        case 67:
          input = b.LForearm.getPosition().y;
          break;
        default:
          input = 0;
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
  
  Person(float px, float py, DNA pdna)
  {
    dna = pdna;
    dna.rating = 0;
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
