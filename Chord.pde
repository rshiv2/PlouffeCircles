// Ray class

class Chord {
  PVector src, dst;
  
  Chord(PVector s, PVector d) {
    src = s;
    dst = d;
  }
  
  void display() {
    line(src.x, src.y, dst.x, dst.y);
  }
}
