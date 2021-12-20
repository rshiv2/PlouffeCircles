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
  
  Chord(PVector s, PVector d, float sn, float tn) {
    src = s;
    dst = d;
    srcNum = sn;
    dstNum = tn;
  }
  
  // Renders chord with a color gradient
  void display(int maxNum) {
    
    colorMode(HSB, 360, 100, 100);
    
    // Modify these two variables to change the chord colors:
    float hSrc = lerp(220, 359, (float)srcNum / maxNum);    
    float hDst = lerp(220, 359, (float)(dstNum % maxNum) / maxNum);
    
    // Uncomment this section to have chord endpoint be different colors
    // -----------------------------------------------------------------
    color srcColor = color(hSrc, 99, 99);
    color dstColor = color(hDst, 99, 99);
    
    int steps = 20;    // gradient is discretized into "steps" segments of different colors
    for (int i = 0; i < steps; i++) {
      stroke(lerpColor(srcColor, dstColor, i / (float)steps));
      PVector segSrc = PVector.lerp(src, dst, i / (float)steps);
      PVector segDst = PVector.lerp(src, dst, (i + 1) / (float)steps);
      line(segSrc.x, segSrc.y, segDst.x, segDst.y);
    }
    
    // Uncomment this section to have chord endpoints be same color, but midpoint be different color
    // ----------------------------------------------------------------------------------------------
    /* 
    color endColor = color(srcNum % 360, 100, 100);
    color midColor = color(dstNum % 360, 100, 100);
    
    PVector midpoint = PVector.div(PVector.add(src, dst), 2);
    
    // First set color gradient from src endpoint to midpoint
    for (int i = 0; i < 50; i++) {
      stroke(lerpColor(endColor, midColor, i / 50.0));
      PVector segSrc = PVector.lerp(src, midpoint, i / 50.0);
      PVector segMid = PVector.lerp(src, midpoint, (i + 1) / 50.0);
      line(segSrc.x, segSrc.y, segMid.x, segMid.y);
    }
    
    // Next, set color gradient from midpoint to dst endpoint
    for (int i = 0; i < 50; i++) {
      stroke(lerpColor(midColor, endColor, i / 50.0));
      PVector segMid = PVector.lerp(midpoint, dst, i / 50.0);
      PVector segDst = PVector.lerp(midpoint, dst, (i + 1) / 50.0);
      line(segMid.x, segMid.y, segDst.x, segDst.y);
    }
    */
    
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
