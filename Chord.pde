// Chord class

class Chord {
  private PVector src, dst;          // pixel coordinates of chord's endpoints
  private float srcNum, dstNum;      // numbers pointed to by src and dst
  color endColor, midColor;          // end- and midpoint colors for chord
  
  Chord(PVector s, PVector d, float sn, float tn) {
    src = s;
    dst = d;
    srcNum = sn;
    dstNum = tn;
    endColor = color(255, 0, 0);
    midColor = color(255, 0, 255);
  }
  
  void display() {
    PVector midpoint = PVector.div(PVector.add(src, dst), 2);
    
    for (int i = 0; i < 50; i++) {
      stroke(lerpColor(endColor, midColor, i / 50.0));
      PVector segSrc = PVector.lerp(src, midpoint, i / 50.0);
      PVector segMid = PVector.lerp(src, midpoint, (i + 1) / 50.0);
      line(segSrc.x, segSrc.y, segMid.x, segMid.y);
    }
    
    for (int i = 0; i < 50; i++) {
      stroke(lerpColor(midColor, endColor, i / 50.0));
      PVector segMid = PVector.lerp(midpoint, dst, i / 50.0);
      PVector segDst = PVector.lerp(midpoint, dst, (i + 1) / 50.0);
      line(segMid.x, segMid.y, segDst.x, segDst.y);
    }
  }
  
  /*** Setters ***/
  float setDst(PVector target) {
    float diff = PVector.dist(dst, target);
    dst = target;
    return diff;
  }
  
  void setDstNum(float newNum) {
    dstNum = newNum;  
  }
  /***************/
  
  /*** Getters ***/
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
  /****************/
}
