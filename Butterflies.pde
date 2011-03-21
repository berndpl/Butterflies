//Kinect
import org.openkinect.*;
import org.openkinect.processing.*;                    
KinectTracker tracker;
Kinect kinect;

//Projection Mapping
import processing.opengl.*;
import codeanticode.glgraphics.*;
import deadpixel.keystone.*;   
GLGraphicsOffScreen offscreenA; 
Keystone ks;
CornerPinSurface surfaceA;

//Setup
int nodeCount = 3;
Node[] myNodes = new Node[nodeCount];
Butterfly[] myButterflies = new Butterfly[nodeCount];

Attractor myAttractor;

boolean showRadius = true;
boolean showCenter = false;
boolean showDepth = false;
boolean switchKinect = false;

void setup() {	

  size(640, 480, GLConstants.GLGRAPHICS);  

	//Kinect
	if (switchKinect){
  	kinect = new Kinect(this);
	  tracker = new KinectTracker();
		tracker.setThreshold(650);
		kinect.tilt(0);  
	}
	
	//Projection Mapping
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
	//Kinect
	if (switchKinect){
		tracker.track();  
	}
	//noCursor();  

	//Projection Mapping
  PVector mouse = surfaceA.getTransformedMouse();
  offscreenA.beginDraw();
  
	lights();
  background(0); 

	//Kinect
	if (switchKinect){
		//Show depth image
			if (showDepth){
				tracker.display();
			}
		//Let's draw the raw location
		PVector v1 = tracker.getPos();
		/*fill(50,100,250,200);
		noStroke();
		ellipse(v1.x,v1.y,20,20);*/
		//Let's draw the "lerped" location
		PVector v2 = tracker.getLerpedPos();
		/*fill(100,250,50,200);
		noStroke();
		ellipse(v2.x,v2.y,20,20);*/                                 
		// Display some info
		int t = tracker.getThreshold();
		fill(0);
		println("threshold: " + t + "    " +  "framerate: " + (int)frameRate);

		myAttractor.x = v2.x;
		myAttractor.y = v2.y;
	} else {
		myAttractor.x = mouseX;
		myAttractor.y = mouseY;
	}
	
	for (int i = 0; i<nodeCount; i++){
		myAttractor.attract(myNodes[i]);
		myNodes[i].update();		
		fill(255);
		if (showCenter){ 
			ellipseMode(CENTER);
			ellipse(myNodes[i].x,myNodes[i].y,10,10);
		}
		myButterflies[i].move(int(myNodes[i].x),int(myNodes[i].y)); 		
	}          

	if (showRadius){
		ellipseMode(CENTER);	
		fill(200,80);                 
		if (switchKinect){  		
			//ellipse(v2.x, v2.y,5,5);
		} else {      
			ellipse(mouseX, mouseY,5,5);    
		}
		fill(200,80);                 
		if (switchKinect){  
			//ellipse(v2.x, v2.y,200,200);  
		} else {
			ellipse(mouseX, mouseY,200,200);
		}
	}

	//Projection Mapping
  offscreenA.endDraw();  
  background(0);            
  surfaceA.render(offscreenA.getTexture());                 

}


void keyPressed(){
	
	//Kinect - Change Threshhold with Up/Down Key
	int t = tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == UP) {
      t+=5;
      tracker.setThreshold(t);
    } 
    else if (keyCode == DOWN) {
      t-=5;
      tracker.setThreshold(t);
    }
  }
	
  switch(key) {               

	//Show At  traction Radius
  case '1':
		if(showRadius)
			showRadius=false;
		else
		  showRadius=true;
    break;

  case '2':
		if(showCenter)
		  showCenter=false;
		else
		  showCenter=true;
    break;

   //Kinect  - Show Depth Image to adjust Threshhold         
  case '3':
		if(showDepth)
		  showDepth=false;
		else
		  showDepth=true;
    break;
          
 	//Projection Mapping
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



