// Chord class


/**
* A Chord instance is just a wrapper for a Processing line segment.
* Instances sit on the circumference of Circle instances. Their
* endpoints are vertices that are equally spaced along the Circle's
* circumference. The endpoints are referred to as src and dst.
* These vertices are numbered in clockwise order.
*/
class Chord {

  private PVector src, currPos;      // pixel coordinates of chord's endpoints
  private float srcNum;              // numbers pointed to by src and dst
  private float prevNum, targetNum, currNum;
  
  private PVector circleOrg;         // origin of Circle that Chord belongs to
  private float circleRad;           // radius of Circle that Chord belongs to
  
  private int numChords;             // number of Chords in Circle that this belongs to
  
  private float hMin;               // lowest H value to use for color (HSB-formatted)
  private float hRange;              // range of H values o use for color (HSB-formatted)
    
  Chord(float srcNum, float dstNum, PVector circleOrg, float circleRad, int numChords) {
    
    // meta-info about the Circle that 'this' belongs to
    this.circleOrg = circleOrg;
    this.circleRad = circleRad;
    this.numChords = numChords;
    
    // determine which vertex on the Circle 'this' chord  is attached to
    this.srcNum = srcNum;
    this.src = this.numToPoint(srcNum);  // srcNum never changes, so we only do this calculation once
    
    // set prev, curr, and target values of Chord's free endpoint, dst
    this.prevNum = dstNum;
    this.targetNum = dstNum;
    this.currNum = prevNum;
    
    // set color variables
    this.hMin = 0;
    this.hRange = 80;
  }
  
  // Chords dst endpoint steps closer to targetNum
  // Returns the distance traversed along circle during this step
  float step() {
    
    // If there is no need to step, don't do it, avoid the computations
    if (currNum == targetNum || prevNum == targetNum) {
      this.setCurrPos(numToPoint(targetNum));
      return 0.0;  
    }
    
    // Determine distance of currNum to targetNum, relative to prevNum
    float t = abs(currNum - prevNum) / abs(targetNum - prevNum);

    // compute step size as function of 't'
    float a = 0.01;
    float b = 1e-4;
    float dt = - a * t * (t - 1) + b;
    
    // Set new currNum and return diff
    currNum = lerp(prevNum, targetNum, min(t + dt, 1.0));
    this.setCurrPos(numToPoint(currNum));
    return abs(dt);
  }
  
  // Renders chord with a color gradient
  // maxNum: largest positive number that can be represented on the circle without wrap-around
  void display(int maxNum) {
    
    colorMode(HSB, 360, 100, 100);
    hMin = (hMin + 0.5) % 360;    // we want to colors displayed to change ever so slightly on each frame
    
    // These two variables set the chord colors:
    float hSrc = lerp(hMin, hMin + hRange, (float)srcNum / maxNum);    
    float hDst = lerp(hMin, hMin + hRange, (float)(currNum % maxNum) / maxNum);
    
    int steps = 20;    // gradient is discretized into "steps" segments of different colors
    for (int i = 0; i < steps; i++) {
      
      // Determine appropriate color for segment i
      float hLerp = lerp(hSrc, hDst, i / (float) steps) % 360;
      float b = 99.0 * 2 * abs(i - steps/2) / steps;
      stroke(hLerp, 99, b);
      
      
      // Determine coordinates of segment i then draw
      PVector segSrc = PVector.lerp(src, currPos, i / (float)steps);
      PVector segDst = PVector.lerp(src, currPos, (i + 1) / (float)steps);
      line(segSrc.x, segSrc.y, segDst.x, segDst.y);
    }
    
    colorMode(RGB, 255, 255, 255);
  }
  
  // Setters
  // ---------------
  private void setCurrPos(PVector newPos) {
    currPos = newPos;
  }
  
  void setDstNum(float newNum) {
    //println("(prevNum, currNum, targetNum) = (" + prevNum + ", " + currNum + ", " + targetNum + ")");
    prevNum = targetNum;
    currNum = prevNum;
    targetNum = newNum;
    //println("(prevNum, currNum, targetNum) = (" + prevNum + ", " + currNum + ", " + targetNum + ")");
    //println();
  }
  
  // Getters
  // ----------------
  PVector getSrc() {
    return src;  
  }
  
  PVector getCurrPos() {
    return currPos; 
  }
  
  float getSrcNum() {
    return srcNum;
  }
  
  float getDstNum() {
    return targetNum; 
  }

// Handy Conversion Functions
  // --------------------------
  
  // Convert real number to angle on circle
  float numToAngle(float num) {
     return num * 360 / numChords; 
  }
  
  // Convert angle on circle to real number
  float angleToNum(float angle) {
    return angle * numChords / 360;
  }
  
  // Convert angle on circle to pixel coordinate
  PVector angleToPoint(float angle) {
    float px = circleRad * cos((float)angle) + circleOrg.x;
    float py = circleRad * sin((float)angle) + circleOrg.y;
    return new PVector(px, py);
  }
  
  // Convert real number to pixel coordinate
  PVector numToPoint(float num) {
    float angle = numToAngle(num);
    return angleToPoint(angle);
  }
}
