//Setting variables for storing the list of floor buttons
int[] cols = {100,250};
int[] rows = {100,200,300,400};

//Stores floors for use in elevator display
int currentFloor = 1,destination = 1;

//Defining buttons to be used
Button fire = new Button(80,580,255,"emergency");
Button estop = new Button(560,580,255,"emergency");

//Uses a list to store all floors
Button[] floors = {new Button((cols[0]+cols[1])/2,rows[3],0,"floor"),new Button(cols[0],rows[2],0,"floor"),
                   new Button(cols[1],rows[2],0,"floor"),new Button(cols[0],rows[1],0,"floor"),
                   new Button(cols[1],rows[1],0,"floor"),new Button(cols[0],rows[0],0,"floor"),
                   new Button(cols[1],rows[0],0,"floor")};
                   
Button open = new Button(380,400,0,"doors");
Button close = new Button(500,400,0,"doors");

//Setitng up where images will be stored
PImage img1,img2,img3,img4;

void setup() {
  //Sets display to 640x640
  size(640, 640);
  background(0);
  
  //Find and load images
  img1 = loadImage("fireman-hat.png");
  img2 = loadImage("caution.png");
  img3 = loadImage("open.png");
  img4 = loadImage("close.png");
}

void draw() {
  //Speed of the elevator. Higher means it goes slower
  int speed = 10;
  
  //Background color
  background(209);
  
  //Main panel and number panel drawing
  fill(0);
  rect(20, 20, 600, 500);
  strokeWeight(5);
  stroke(255);
  rect(350, 50, 200, 300);
  
  //Making the emergency
  fire.buttonPress(speed);
  estop.buttonPress(speed);
  
  //Open and close door buttons
  open.buttonHold();
  close.buttonHold();
  
  //Loop to make all the floor buttons
  for(int x = 0;x < floors.length;x++){
    floors[x].buttonPress(speed);
    floors[x].floorText(String.valueOf(x+1));
  }
  
  //Display button images
  img1.resize(60,0);
  img2.resize(50,0);
  img3.resize(70,0);
  img4.resize(70,0);
  image(img1,50,560);
  image(img2,536,553);
  image(img3,345,365);
  image(img4,466,365);
  
  //Section for drawing button text
  rect(130,540,80,75);
  rect(380,540,130,75);
  fill(255,0,0);
  
  //Printing the text used for buttons
  textAlign(CENTER);
  textSize(32);
  text("FIRE",170,570);
  text("CALL",170,600);
  textSize(25);
  text("Emergency",443,565);
  text("Stop",443,595);
  fill(255);
  text("Open",380,460);
  text("Doors",380,490);
  text("Close",502,460);
  text("Doors",502,490);
  
  //Printing the numbers to show current floor and elevator operation
  fill(255,0,0);
  textSize(45);
  switch(currentFloor){ //<>//
    case 1:
      text("1",450,332);
      break;
    case 2:
      text("2",450,292);
      break;
    case 3:
      text("3",450,252);
      break;
    case 4:
      text("4",450,212);
      break;
    case 5:
      text("5",450,172);
      break;
    case 6:
      text("6",450,132);
      break;
    case 7:
      text("7",450,92);
      break;
  }
}

//Button class used to create buttons and run operations on them
class Button{
    private int x,y,background;
    private int timer = 0;
    private boolean active = false;
    private color pressed;
    private String use = "";
    
  //Constructor that initialized button placement, the color of its background,
  //and the use of the button
  Button(int x, int y, int b,String u){
    this.x = x;
    this.y = y;
    this.background = b;
    this.use = u;
  }
  
  //Creates the button and draws it on the display
  void makeButton(color c,color b){
    fill(b);
    strokeWeight(5);
    stroke(c);
    circle(x,y,80);
    strokeWeight(0);
    fill(0);
  }
  
  //Function used during buttons that need one time presses
  void buttonPress(int speed){
    //Makes sure the mouse is being clicked and the button has not been already pressed
    if(mousePressed && this.active == false){
      if((mouseX > x-40 && mouseX < x+40) && (mouseY > y-40 && mouseY < y+40)){
        //If an emergency button, display red instead of yellow
        if(this.use == "emergency"){
          this.pressed = color(255,0,0);
        }
        //If a floor button, find the distance between floors
        else if(this.use == "floor"){
          for(int z = 0;z < floors.length;z++){
            if(floors[z] == this){
              destination = z+1;
              break;
            }
          }
        }
        else{
          this.pressed = color(255,255,0);
        }
        //Starts the timer used to animate the button and the floors changing
        timer = millis();
        this.active = true;
      }
      else{this.pressed = color(0,0,0);}
    }
    //If the floor has not been reached yet, continue updating
    else if(this.active == true && currentFloor != destination){
      this.pressed = color(255,255,0);
      //Calculates how long till the floor is reached
      if(millis() < timer + Math.abs(destination-currentFloor)*1000 || currentFloor != destination){
        //Goes lower if on a higher floor
        if(currentFloor > destination)
          currentFloor--;
        //Goes higher if from a lower floor
        else if(currentFloor < destination)
          currentFloor++;
      //Adds delay to simulate elevator travel
      delay(speed*100);
      }
    }
    //If the emergency button is pressed or the end is reached, finish rendering the travel
    else if(this.active == true && currentFloor == destination){
      if(this.use == "emergency"){
        delay(3000);
      }
      this.active = false;
    }
    //If nothing is going on, just render each button as idle
    else{
      this.pressed = color(0,0,0);
      this.active = false;
    }
    this.makeButton(this.pressed,this.background);
  }
  
  //Fucntion used for buttons that need to be held such as the doors
  void buttonHold(){
     //Makes sure mouse is clicking the button specified
     if(mousePressed && (mouseX > x-40 && mouseX < x+40) && (mouseY > y-40 && mouseY < y+40)){
       this.pressed = color(255,255,0);
     }
     else{
       this.pressed = color(0,0,0);
     }
     this.makeButton(this.pressed,this.background);
  }
  
  //Prints out the numbers on each button for each floor
  void floorText(String num){
    textAlign(CENTER);
    textSize(50);
    fill(255);
    text(num,x,y+12);
  }
}
