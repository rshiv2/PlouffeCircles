
Circle c;

void setup() {
  size(640, 400);
  
  /* Edit these fields!! */
  int num_vertices = 100;
  float alpha = 2;
  int radius = 150;
  PVector center = new PVector(width / 2, height / 2);
  /***********************/
  
  
  c = new Circle(num_vertices, alpha, center, radius);
}

void draw() {
  c.display();
  
  noLoop();
}
