Circle c;
float alpha;
final float THRESHOLD = 1e-3;
final int MIN_ALPHA = 100;
final int MAX_ALPHA = 150;
float step;

void setup() {
  size(400, 400);
  frameRate(30);
  stroke(0);
  
  // Edit these fields to customize the animation!
  // ---------------------------------------------
  int num_vertices = 200;
  int radius = 150;
  PVector center = new PVector(width / 2, height / 2);
  step = 0.5;
  alpha = MIN_ALPHA;
  
  c = new Circle(num_vertices, alpha, center, radius);
}

void draw() {
  background(12, 24, 36);
  
  float diff = c.update();
  c.display();
  
  // if animation converges, increment alpha
  if (diff <= THRESHOLD) {
    float currAlpha = c.getAlpha();
    
    c.setAlpha((currAlpha + step) % MAX_ALPHA); 
    println("alpha = " + c.getAlpha());
  }

}
  
