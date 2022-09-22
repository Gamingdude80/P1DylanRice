PImage img;

void setup() {
  size(640, 640);
  noStroke();
  background(0);
  img = loadImage("fireman-hat.png");
}

void draw() {
  background(209);
  fill(0);
  rect(20, 20, 600, 500);
  circle(80,580,80);
  
  imageMode(CORNERS);
  image(img,50,560,110,600);
  fill(255,0,0);
  textSize(32);
  text("FIRE",140,570);
  text("CALL",138,600);
}