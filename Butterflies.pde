import processing.opengl.*;
import codeanticode.glgraphics.*;
import deadpixel.keystone.*;
   
GLGraphicsOffScreen offscreenA; 
Keystone ks;
CornerPinSurface surfaceA;


int nodeCount = 3;
Node[] myNodes = new Node[nodeCount];
Butterfly[] myButterflies = new Butterfly[nodeCount];

Attractor myAttractor;

void setup() {	

  size(1024, 600, GLConstants.GLGRAPHICS);  
  offscreenA = new GLGraphicsOffScreen(this, width-10, height-10);
  ks = new Keystone(this);
  surfaceA = ks.createCornerPinSurface(width, height, 20);

	for (int i = 0; i < nodeCount; i++){
		myNodes[i] = new Node(random(width),random(height)); 
		myNodes[i].velocity.x = 2;
		myNodes[i].velocity.y = 2; 
		/*myNodes[i].velocity.x = random(-3,3);
		myNodes[i].velocity.y = random(-3,3); */
		myNodes[i].damping = 0; 		
		myButterflies[i] = new Butterfly();
	}

	myAttractor = new Attractor (0,0);

}

void draw() {

  PVector mouse = surfaceA.getTransformedMouse();

  offscreenA.beginDraw();

  background(0); 	      

	myAttractor.x = mouseX;
	myAttractor.y = mouseY;
	
	for (int i = 0; i<nodeCount; i++){
		myAttractor.attract(myNodes[i]);
		myNodes[i].update();		
		fill(255);
		ellipse(myNodes[i].x,myNodes[i].y,10,10);
		myButterflies[i].move(int(myNodes[i].x),int(myNodes[i].y)); 		
	}          
	
	fill(100,50);                 
	ellipse(mouseX, mouseY,5,5);
	fill(100,50);                 
	ellipse(mouseX, mouseY,200,200);

  offscreenA.endDraw();  

  background(0);            

  surfaceA.render(offscreenA.getTexture());                 

}


void keyPressed(){
  switch(key) {               
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped 
    // & moved
    ks.toggleCalibration();
    break;
  case 'a':
    // loads the saved layout
    ks.load();
    break;
  case 's':
    // saves the layout
    ks.save();
    break;
  }	                   
}



