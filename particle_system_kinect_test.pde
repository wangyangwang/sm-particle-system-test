
ArrayList<Particle> particles;
ArrayList<PVector> mouseTrace;
PVector mouseDirection;
PVector mouseAcceleration = new PVector(0, 0, 0);
int mouseTraceLength = 20;
int particlesAmount = 400;

//---------------------------------------------
//---------------------------------------------

void setup() {

  size(1900, 1000, OPENGL);
  smooth();
  particles = new ArrayList<Particle>();
  mouseTrace = new ArrayList<PVector>();

  for (int i=0; i<particlesAmount; i++) {
    PVector temp = new PVector(random(0, width), random(-height, 0), random(-800, 800));
    particles.add(new Particle(temp));
  }
}

//---------------------------------------------
//---------------------------------------------

void draw() {

  background(#28265F);
  textSize(12);
  text("frame Rate: "+frameRate, 10, 20);
  text("Particle Amount: "+particles.size(), 10, 40);


  //MOUSE EVENT STARTS
  mouseTracing();
  getMouseAcceleration();
//  drawMouseTrace();
  //MOUSE EVENT ENDS



  for (int i=0; i<particles.size (); i++) {
    particles.get(i).update(mouseAcceleration);
    particles.get(i).calculate();
    particles.get(i).backToOriginalPath();
    particles.get(i).render();
    particles.get(i).showTarget();
    if (particles.get(i).position.y > height) {
      particles.remove(i);
    }
  }


  if (particles.size() < particlesAmount) {
    PVector temp = new PVector(random(0, width), random(-height, 0), random(-800, 800));
    particles.add(new Particle(temp));
  }

  mouseAcceleration.mult(0); //clear mouseAcceleration, get ready for the next loop
}

//---------------------------------------------
//---------------------------------------------

void mouseTracing() {
  mouseTrace.add(new PVector(mouseX, mouseY));
  if (mouseTrace.size() > mouseTraceLength) {
    mouseTrace.remove(0);
  }
}

void getMouseAcceleration() {
  for (int i=0; i<mouseTrace.size ()-1; i++) {
    mouseAcceleration.add(PVector.sub(mouseTrace.get(i+1), mouseTrace.get(i)));
  }
  mouseAcceleration.div(mouseTrace.size());
}

void drawMouseTrace() {
  for (PVector i : mouseTrace) {
    stroke(#E2633F);
    strokeWeight(4);
    point(i.x, i.y);
    strokeWeight(1);
  }
}

