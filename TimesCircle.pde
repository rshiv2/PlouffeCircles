
Circle c;
float alpha;
final float THRESHOLD = 1.0;
final int MIN_ALPHA = 0;
final int MAX_ALPHA = 5;
float step = 0.5;

void setup() {
  size(640, 400);
  stroke(0);
  
  /* Edit these fields!! */
  int num_vertices = 100;
  alpha = 2;
  int radius = 150;
  PVector center = new PVector(width / 2, height / 2);
  frameRate(20);
  /***********************/
  
  
  c = new Circle(num_vertices, alpha, center, radius);
}

void draw() {
  background(255);
  
  float diff = c.update();
  c.display();
  
  if (diff < THRESHOLD) {
    float curr_alpha = c.getAlpha();
    if (curr_alpha >= MAX_ALPHA) {
      step = -1; 
    } else if (curr_alpha <= MIN_ALPHA) {
      step = 1;  
    }
    
    c.setAlpha(c.getAlpha() + step); 
  }

}
  
