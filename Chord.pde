// Chord class


/**
* A Chord instance is just a wrapper for a Processing line segment.
* Instances sit on the circumference of Circle instances. Their
* endpoints are vertices that are equally spaced along the Circle's
* circumference. The endpoints are referred to as src and dst.
* These vertices are numbered in clockwise order.
*/
class Chord {

  private PVector src, dst;          // pixel coordinates of chord's endpoints
  private float srcNum, dstNum;      // numbers pointed to by src and dst
  
  private float hInit;               // lowest H value to use for color (HSB-formatted)
  private float hRange;              // range of H values o use for color (HSB-formatted)
    
  Chord(PVector s, PVector d, float sn, float tn) {
    src = s;
    dst = d;
    srcNum = sn;
    dstNum = tn;
    
    hInit = 0;
    hRange = 80;
  }
  
  // Renders chord with a color gradient
  void display(int maxNum) {
    
    colorMode(HSB, 360, 100, 100);
    hInit = (hInit + 0.5) % 360;
    
    // These two variables set the chord colors:
    float hSrc = lerp(hInit, hInit + hRange, (float)srcNum / maxNum);    
    float hDst = lerp(hInit, hInit + hRange, (float)(dstNum % maxNum) / maxNum);
    
    int steps = 20;    // gradient is discretized into "steps" segments of different colors
    for (int i = 0; i < steps; i++) {
      
      // Determine appropriate color for segment i
      float hLerp = lerp(hSrc, hDst, i / (float) steps) % 360;
      stroke(hLerp, 99, 99);
      
      // Determine coordinates of segment i then draw
      PVector segSrc = PVector.lerp(src, dst, i / (float)steps);
      PVector segDst = PVector.lerp(src, dst, (i + 1) / (float)steps);
      line(segSrc.x, segSrc.y, segDst.x, segDst.y);
    }
    
    colorMode(RGB, 255, 255, 255);
  }
  
  // Setters
  // ---------------
  float setDst(PVector target) {
    float diff = PVector.dist(dst, target);
    dst = target;
    return diff;
  }
  
  void setDstNum(float newNum) {
    dstNum = newNum;  
  }
  
  // Getters
  // ----------------
  PVector getSrc() {
    return src;  
  }
  
  PVector getDst() {
    return dst; 
  }
  
  float getSrcNum() {
    return srcNum;
  }
  
  float getDstNum() {
    return dstNum; 
  }

}
