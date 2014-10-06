class Particle {
  PVector position;
  PVector target;
  PVector originalTarget;
  PVector acceleration;
  PVector velocity;
  PVector impactedForce;
  float maxspeed;
  float maxforce;
  float backToOriginForce;
  float r; //radius

  Particle(PVector _position) {
    position = _position;
    target = new PVector(position.x, height, position.z);
    originalTarget = new PVector(position.x, height, position.z);
    velocity = new PVector(0, random(0.1, 0.7), 0);
    acceleration = new PVector(0, 0, 0);
    maxspeed = 0.5;
    backToOriginForce = 2;
    r = 6;
    maxforce = 1;
  }

  void update(PVector mouseAcceleration) {
    PVector md = mouseAcceleration;
    md.normalize();
    md.mult(10);
    target.add(md);
  }

  void calculate() {
    PVector desired = PVector.sub(target, position);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    acceleration.add(steer);
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void render() {
    noStroke();
    fill(255);
    pushMatrix();
    translate(position.x, position.y, position.z);
    sphereDetail(3);
    sphere(r);
    popMatrix();
  }
  
  void backToOriginalPath(){
     if(target != originalTarget){
       PVector desired = PVector.sub(originalTarget,target);
       desired.normalize();
       desired.mult(backToOriginForce);
       target.add(desired);
     }
  }

  void showTarget() {
   // println("Original: "+originalTarget + "target: "+target);
    strokeWeight(1);
    stroke(255,0,0);
    point(target.x, target.y, target.z);
    stroke(255);
    strokeWeight(2);
    point(originalTarget.x, originalTarget.y, originalTarget.z);
  }
}

