Circle c;
float alpha;
final float THRESHOLD = 20.0;
final int MIN_ALPHA = 0;
final int MAX_ALPHA = 5;
float step;

void setup() {
  size(640, 400);
  frameRate(30);
  stroke(0);
  
  // Edit these fields to customize the animation!
  // ---------------------------------------------
  int num_vertices = 200;
  int radius = 150;
  PVector center = new PVector(width / 2, height / 2);
  step = 0.5;
  alpha = 2;
  
  c = new Circle(num_vertices, alpha, center, radius);
}

void draw() {
  background(12, 24, 36);
  
  float diff = c.update();
  c.display();
  
  // if animation converges, increment alpha
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
  
