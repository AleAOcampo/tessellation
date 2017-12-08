import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.*;

PImage copo;
PImage arriba;
PImage letras;

Box2DProcessing box2d;

ArrayList<Particle> particles;

ArrayList <Figura> figuras;
float lado = 25;
float altura = sqrt(sq(lado) - sq(lado/2f));
float apotema = lado/ 2*tan(PI/6f);
float radio = altura - apotema;
float delta = 0;
void setup()
{
size(600,600,P3D);

copo = loadImage("flake.png");
arriba = loadImage("frame.png");
letras = loadImage("navidarks.png");

 box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -20);

 particles = new ArrayList<Particle>();

figuras = new ArrayList<Figura>();
for (float j = radio; j<=height; j+= altura){
int paso = (round((j - radio)/altura));
float offset =0;
if (paso%2 == 0){
offset = lado/2f;
}
for (float i =-offset; i<=width; i+= lado){
figuras.add(new Triangulo(i,j,lado,0,color(10,20,255)));
}
for (float i =lado/2f-offset; i<=width; i+= lado){
figuras.add(new Triangulo(i,j-apotema,lado,PI,color(10,200,100)));
}
}

}
void draw()
{
//delta += 0.01; 
background(255,0,0);
noStroke();
for (Figura f: figuras){
f.display();
}

image(arriba,0,-7);
arriba.resize(0,450);
image(letras, 55,100);

if (mousePressed) {
    float sz = random(2,6);
    particles.add(new Particle(mouseX,mouseY,sz));
  }

  box2d.step();
  
   for (Particle p: particles) {
    p.display();
  }

  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    if (p.done()) {
      particles.remove(i);
    }
  }

textSize(30);
fill(0);
stroke(#FFF700);
text("Make it snow!", 200,550);
textSize(20);
fill(0);
stroke(#FFF700);
text("click and drag the mouse", 180,580);
}

interface Figura
{
float perimetro ();
float area ();
void display();
}
class Triangulo implements Figura
{
float x,y,l,rc,ri,a,a1,deltax,deltay,h,b,rota;
color c;
Triangulo (float x_,float y_,float l_, float rota_, color c_)
{
x=x_;
y=y_;
l=l_;
c=c_;
rc=(l*sqrt(3))/6f;
b=l;
a1=TWO_PI/6;
rota = rota_;
}
float perimetro ()
{
return l*6;
}
float area ()
{
return ((l*l)*(sqrt(3)))/4;
}
void display()
{
fill (random(255));
pushMatrix();
translate(x,y);
rotate(HALF_PI - PI/3 + rota);
beginShape();
for(float a = 0;a<TWO_PI;a+=a1)
{
deltax=cos(a)*rc;
deltay=sin(a)*rc;
vertex(deltax,deltay);
}
endShape(CLOSE);
popMatrix();
}
}