import com.processinghacks.arcball.*;

GUI gui;

ArrayList pointData;
float rho = 28;
float sigma = 5;
float beta = 8/3;
float dt = 0.005;
PVector startPoint = new PVector(0,1,1);
int count = 0;
float mscale = 5;
ArcBall arcball;
PFont font;

void setup() {
  size(600,400,P3D);
  gui = new GUI();
  arcball = new ArcBall(this,gui);
  pointData = new ArrayList();
  pointData.add(startPoint);
 font = loadFont("Garuda-20.vlw");
 gui.graphics.textFont(font);
}
 

 
void draw() {
  
  rho = gui.rhoControl.getValue();
  beta = gui.betaControl.getValue();
  sigma = gui.sigmaControl.getValue();
  
  int pointscount = pointData.size()-1;
  
  while(pointData.size() > 1)
    pointData.remove(pointData.size()-1);
  
  for(int i = 0; i < pointscount; i++)
  {
    pointData.add(iterate((PVector)(pointData.get(i))));
  }
  
  
  //print(newPoint.x + " " + newPoint.y + " " + newPoint.z + "\n");
  if(pointData.size() < 30000)
  {
    pointData.add(iterate((PVector)pointData.get(pointData.size()-1)));
    pointData.add(iterate((PVector)pointData.get(pointData.size()-1)));
    pointData.add(iterate((PVector)pointData.get(pointData.size()-1)));
    pointData.add(iterate((PVector)pointData.get(pointData.size()-1)));
    pointData.add(iterate((PVector)pointData.get(pointData.size()-1)));
    pointData.add(iterate((PVector)pointData.get(pointData.size()-1)));
  }
  
  
  background(200);
  translate(width/2-width/5,height/3*2,-height/2);
  scale(mscale,mscale,mscale);
  stroke(0,0,0);
  line(0,0,-100,0,0,100);
  line(0,-100,0,0,100,0);
  line(-100,0,0,100,0,0);

  smooth();
  for(int i = 0; i < pointData.size(); i++)
  {
      PVector p = (PVector)pointData.get(i);
    if(abs(p.x) < 1000 && abs(p.y) < 1000 && abs(p.z) < 1000)
    {
      if(i > 0)
      {
        PVector p2 = (PVector)pointData.get(i-1);
        if(abs(p2.x) < 1000 && abs(p2.y) < 1000 && abs(p2.z) < 1000)
        {
          PVector pdiff = new PVector(p.x,p.y,p.z);
          pdiff.sub(p2);
          stroke(255,0,0);
          line(p2.x,p2.y,p2.z,p.x,p.y,p.z);
        }
      }
    }
  }
  
      PVector p = (PVector)pointData.get(pointData.size()-1);
      pushMatrix();
      translate(p.x,p.y,p.z);
      box(9/mscale);
      popMatrix();
  
 gui.graphics.beginDraw();
 gui.graphics.background( 129 );
 
 gui.draw();
 gui.graphics.text(pointData.size(),10,390);
  
 gui.graphics.endDraw();

 gui.graphics.loadPixels();
 loadPixels();
 for(int i=0;i<pixels.length;i++)
   if( gui.graphics.pixels[i]!=color(129) ) pixels[i] = gui.graphics.pixels[i];
 updatePixels();
 gui.graphics.updatePixels();
  
  count++;
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      mscale += .25;
    } else if (keyCode == DOWN && mscale > 0) {
      mscale -= .25;
    }
  }
  
  if(key == 'r')
  {
    while(pointData.size() > 1)
      pointData.remove(pointData.size()-1);
  }
}




PVector iterate(PVector lastPoint)
{
  
  PVector newPoint = new PVector();  
  newPoint.x = lastPoint.x + (sigma*(lastPoint.y - lastPoint.x))*dt;
  newPoint.y = lastPoint.y + (lastPoint.x*(rho - lastPoint.z) - lastPoint.y)*dt;
  newPoint.z = lastPoint.z + (lastPoint.x*lastPoint.y - beta*lastPoint.z)*dt;
  return newPoint;
}







  static class Vec3 {

    float x, y, z;



    Vec3() {}



    Vec3(float x, float y, float z) {

      this.x = x;

      this.y = y;

      this.z = z;

    }



    void normalize() {

      float length = length();

      x /= length;

      y /= length;

      z /= length;

    }



    float length() {

      return PApplet.mag(x,y,z);

    }



    static Vec3 cross(Vec3 v1, Vec3 v2) {

      Vec3 res = new Vec3();

      res.x = v1.y * v2.z - v1.z * v2.y;

      res.y = v1.z * v2.x - v1.x * v2.z;

      res.z = v1.x * v2.y - v1.y * v2.x;

      return res;

    }



    static float dot(Vec3 v1, Vec3 v2) {

      return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;

    }



    static Vec3 mul(Vec3 v, float d) {

      Vec3 res = new Vec3();

      res.x = v.x * d;

      res.y = v.y * d;

      res.z = v.z * d;

      return res;

    }



    void sub(Vec3 v1, Vec3 v2) {

      x = v1.x - v2.x;

      y = v1.y - v2.y;

      z = v1.z - v2.z;

    }

    

  } // Vec3



  static class Quat {

        

    float w, x, y, z;



    Quat() {

      reset();

    }



    Quat(float w, float x, float y, float z) {

      this.w = w;

      this.x = x;

      this.y = y;

      this.z = z;

    }



    void reset() {

      w = 1.0f;

      x = 0.0f;

      y = 0.0f;

      z = 0.0f;

    }



    void set(float w, Vec3 v) {

      this.w = w;

      x = v.x;

      y = v.y;

      z = v.z;

    }



    void set(Quat q) {

      w = q.w;

      x = q.x;

      y = q.y;

      z = q.z;

    }



    static Quat mul(Quat q1, Quat q2) {

      Quat res = new Quat();

      res.w = q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z;

      res.x = q1.w * q2.x + q1.x * q2.w + q1.y * q2.z - q1.z * q2.y;

      res.y = q1.w * q2.y + q1.y * q2.w + q1.z * q2.x - q1.x * q2.z;

      res.z = q1.w * q2.z + q1.z * q2.w + q1.x * q2.y - q1.y * q2.x;

      return res;

    }



    float[] getValue() {

      // transforming this quat into an angle and an axis vector...



      float[] res = new float[4];



      float sa = (float) Math.sqrt(1.0f - w * w);

      if (sa < PApplet.EPSILON) {

        sa = 1.0f;

      }



      res[0] = (float) Math.acos(w) * 2.0f;

      res[1] = x / sa;

      res[2] = y / sa;

      res[3] = z / sa;



      return res;

    }

    

  } // Quat

