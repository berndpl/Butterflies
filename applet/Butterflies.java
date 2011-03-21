import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 
import codeanticode.glgraphics.*; 
import deadpixel.keystone.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class Butterflies extends PApplet {




   
GLGraphicsOffScreen offscreenA; 
Keystone ks;
CornerPinSurface surfaceA;


int nodeCount = 3;
Node[] myNodes = new Node[nodeCount];
Butterfly[] myButterflies = new Butterfly[nodeCount];

Attractor myAttractor;

boolean showRadius;
boolean showCenter;

public void setup() {	

  size(1024, 600, GLConstants.GLGRAPHICS);  
//  size(1024, 600, P3D);  
  /*offscreenA = new GLGraphicsOffScreen(this, width-10, height-10);
  ks = new Keystone(this);
  surfaceA = ks.createCornerPinSurface(width, height, 20);*/

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

public void draw() {

  /*PVector mouse = surfaceA.getTransformedMouse();

  offscreenA.beginDraw();*/

ambientLight(200,200,200);

  background(0); 	      
//  		lights();
	myAttractor.x = mouseX;
	myAttractor.y = mouseY;
	
	for (int i = 0; i<nodeCount; i++){
		myAttractor.attract(myNodes[i]);
		myNodes[i].update();		
		fill(255);
		if (showRadius){ 
			ellipseMode(CENTER);
			ellipse(myNodes[i].x,myNodes[i].y,10,10);
		}
		myButterflies[i].move(PApplet.parseInt(myNodes[i].x),PApplet.parseInt(myNodes[i].y)); 		
	}          

	if (showRadius){
		ellipseMode(CENTER);	
		fill(100,50);                 
		ellipse(mouseX, mouseY,5,5);
		fill(100,50);                 
		ellipse(mouseX, mouseY,200,200);
	}
  /*offscreenA.endDraw();  

  background(0);            

  surfaceA.render(offscreenA.getTexture());                 */

}


public void keyPressed(){
  switch(key) {               

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



class Attractor{
	float x = 0, y = 0;
	float radius = 300;
	
	Attractor(float theY, float theX){
		x = theX;
		y = theY;
	}
 
  public void attract(Node theNode) {
		float dx = x - theNode.x;
		float dy = y - theNode.y;
		float d = mag(dx,dy);
		
		if(d > 0 && d < radius){
			float s = d/radius;
			float f = 1 / pow(s, 0.5f * 0.5f) - 1;
			f = f/radius;

			theNode.velocity.x += dx * f;
			theNode.velocity.y += dy * f;
		}              
		
	}
	
}
class Butterfly{
	float posX;
	float posY;
	int speed;               
	int ang; 
	int flapSpeed = 25;
	int flap = 1;  
	int w = 20;
	
	Butterfly(){
		this.posX = width/2+random(0,100);
		this.posY = height/2+random(0,100);
		this.speed = 5;		
		this.ang = 0;
	}                

	public void move(int moveX, int moveY){
		pushMatrix();
    posX = sin(radians(ang))*60+moveX;
    posY = cos(radians(ang))*30+moveY;
		ang++;
		translate(posX,posY);    

		noStroke();
		lights();
		fill(100,250);
		sphere(3);
		popMatrix();
                       
		flap = flap + flapSpeed;

		pushMatrix();
		translate(posX,posY,-w/2);    
		rotateX(radians(90));
		rotateY(sin(radians(flap)));
//		rect(0,0, w, w);
		fill(255,200);
		ellipseMode(CORNER);
		ellipse(0,0, w, w);
		popMatrix(); 

		pushMatrix();
		translate(posX,posY,-w/2);    
		rotateX(radians(90));    
		rotateY(sin(radians(flap))* -1);
		fill(255,200);
		ellipseMode(CORNER);
  	ellipse(-w,0, w, w);
		popMatrix(); 
		 		        
	}
}
class Node extends PVector{
	PVector velocity = new PVector();
	float minX = 65, minY = 30, maxY = height-30, maxX = width - 65;
	float damping = 0.1f;
  
  Node(float theX, float theY){
  	x = theX;
  	y = theY;      
		println("Node creates");
  }          
	
	public void update(){
		x += velocity.x+random(-3,3);
		y += velocity.y+random(-3,3);		

		//X
		if (x < minX) {
			x = minX - (x-minX);
			velocity.x = -velocity.x;
		}
		if (x > maxX) {
			x = maxX - (x-maxX);
			velocity.x = -velocity.x;
		}                          

		//Y
		if (y < minY) {
			y = minY - (y-minY);
			velocity.y = -velocity.y;
		}
		if (y > maxY) {
			y = maxY - (y-maxY);
			velocity.y = -velocity.y;
		}                          

		velocity.x *= (1-damping);
		velocity.y *= (1-damping);

	}
	
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--stop-color=#cccccc", "Butterflies" });
  }
}
