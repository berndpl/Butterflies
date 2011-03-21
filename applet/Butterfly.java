import processing.core.*; 
import processing.xml.*; 

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

public class Butterfly extends PApplet {

/*import peasy.*;
PeasyCam cam;                       */
   
Fly birdie;

public void setup() {
  size(640, 360, P3D);  
	/*cam = new PeasyCam(this, 100);*/
	birdie = new Fly();
}

public void draw() {
  background(0); 
	                               
	birdie.move();
//	pushMatrix();
//	translate (width/2,height/2);
//	popMatrix();
}





class Fly{
	float posX;
	float posY;
	int speed;               
	int ang;
	
	Fly(){
		this.posX = width/2;
		this.posY = height/2;
		this.speed = 5;		
		this.ang = 0;
	}                

	public void move(){
		pushMatrix();
    posX = sin(radians(ang))*100+mouseX;
    posY = cos(radians(ang))*30+mouseY;
		ang++;
		println ("ang "+ang);
		println ("posX "+posX);
		translate(posX,posY);
		box(20);     
		popMatrix(); 		        
	}
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--stop-color=#cccccc", "Butterfly" });
  }
}
