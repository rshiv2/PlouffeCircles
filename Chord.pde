// Chord class

class Chord {
  private PVector src, dst;          // pixel coordinates of chord's endpoints
  private float srcNum, dstNum;     // numbers pointed to by src and dst
  
  Chord(PVector s, PVector d, float sn, float tn) {
    src = s;
    dst = d;
    srcNum = sn;
    dstNum = tn;
  }
  
  void display() {
    line(src.x, src.y, dst.x, dst.y);
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
