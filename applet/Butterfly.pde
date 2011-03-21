/*import peasy.*;
PeasyCam cam;                       */
   
Fly birdie;

void setup() {
  size(640, 360, P3D);  
	/*cam = new PeasyCam(this, 100);*/
	birdie = new Fly();
}

void draw() {
  background(0); 
	                               
	birdie.move();
//	pushMatrix();
//	translate (width/2,height/2);
//	popMatrix();
}





