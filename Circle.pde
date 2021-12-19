// Circle class

class Circle {
 
  int num_vertices;    // number of vertices in our circle
  float alpha;         // what scale factor will we use for our vertices
  ArrayList<Chord> chords; // collection of chords in our circle
  int radius;          // will have to tweak this value
  PVector center;
  
  Circle(int n_v, float a, PVector c, int rad) {
    
    num_vertices = n_v;;
    alpha = a;
    center = c;
    radius = rad;
    chords = new ArrayList<Chord>(num_vertices);
    
    // Insert chords
    for (int i = 0; i < num_vertices; i++) {
      plotChord(i, i * alpha);
    }
  }
  
  void plotChord(float src, float dst) {
    
    // compute coordinates of Chord's src (may have to compute closest pixel??)
      float bx = radius * cos((float)src * 360 / num_vertices) + center.x;
      float by = radius * sin((float)src * 360 / num_vertices) + center.y;
       
      // compute coordinates of Chord's dst (may have to compute closest pixel??)
      float hx = radius * cos((float)dst * 360 / num_vertices) + center.x;
      float hy = radius * sin((float)dst * 360 / num_vertices) + center.y;
      
      // insert Chord into Chord ArrayList
      chords.add(new Chord(new PVector(bx, by), new PVector(hx, hy))); 
    
  }
  
  void display() {
    int i = 0;
    for (int id = 0; id < num_vertices; id++) {
      Chord r = chords.get(id);
      println("Rendering ray " + i + " at (" + r.src + ") (" + r.dst + ")");
      r.display(); 
      i++;
   }
  }
}
