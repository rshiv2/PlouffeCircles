// Circle class

class Circle {
 
  private int num_vertices;    // number of vertices in our circle
  private float alpha;         // what scale factor will we use for our vertices
  private ArrayList<Chord> chords; // collection of chords in our circle
  private int radius;          // will have to tweak this value
  private PVector center;
  
  Circle(int n_v, float a, PVector c, int rad) {
    
    num_vertices = n_v;;
    alpha = a;
    center = c;
    radius = rad;
    chords = new ArrayList<Chord>(num_vertices);
    
    // Insert chords
    for (int i = 0; i < num_vertices; i++) {
      addChord(i, i * alpha, i);
    }
  }
  
  void printChords() {
    for (int i = 0; i < chords.size(); i++) {
      Chord c = chords.get(i);
      print("Chord " + c + " (srcNum, dstnum) = (");
      println(c.getSrcNum() + ", " + c.getDstNum() + ")");
    }
  }
  
  void addChord(float src, float dst, int i) {
    
    // compute coordinates of Chord's src 
      float thetaSrc = (float)src * 360 / num_vertices;
      float bx = radius * cos(thetaSrc) + center.x;
      float by = radius * sin(thetaSrc) + center.y;
       
      // compute coordinates of Chord's dst 
      float thetaDst = (float)dst * 360 / num_vertices;
      float hx = radius * cos(thetaDst) + center.x;
      float hy = radius * sin(thetaDst) + center.y;
      
      // insert Chord into Chord ArrayList
      chords.add(new Chord(new PVector(bx, by), new PVector(hx, hy), i, i * alpha)); 
    
  }
  
  float getAlpha() {
    return alpha;  
  }
  
  void setAlpha(float new_alpha) {
   alpha = new_alpha; 
  }
  
  // Updates each chord in circle via linear interpolation
  float update() {
    float totalDiff = 0.0;
    
    for (int i = 0; i < chords.size(); i++) {
      
      Chord c = chords.get(i);
      float currDstAngle = numToAngle(c.getDstNum());
      float targetDstAngle = numToAngle(i * alpha); 
      
      float newDstAngle = lerp(currDstAngle, targetDstAngle, 0.075);
      PVector newDst = angleToPoint(newDstAngle);

      totalDiff += c.setDst( newDst );
      c.setDstNum(angleToNum(newDstAngle));
    }
    
    return totalDiff;
  }
  
  void display() {
    for (int id = 0; id < num_vertices; id++) {
      Chord c = chords.get(id);
      c.display(num_vertices); 
    }
  }
  
  /*** Conversion Funcs ***/
  
  // Convert real number to angle on circle
  float numToAngle(float num) {
     return num * 360 / num_vertices; 
  }
  
  // Convert angle on circle to real number
  float angleToNum(float angle) {
    return angle * num_vertices / 360;
  }
  
  // Convert angle on circle to pixel coordinate
  PVector angleToPoint(float angle) {
    float px = radius * cos((float)angle) + center.x;
    float py = radius * sin((float)angle) + center.y;
    return new PVector(px, py);
  }
  
  // Convert real number to pixel coordinate
  PVector numToPoint(float num) {
    float angle = numToAngle(num);
    return angleToPoint(angle);
  }
}
