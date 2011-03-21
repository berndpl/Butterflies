class Attractor{
	float x = 0, y = 0;
	float radius = 300;
	
	Attractor(float theY, float theX){
		x = theX;
		y = theY;
	}
 
  void attract(Node theNode) {
		float dx = x - theNode.x;
		float dy = y - theNode.y;
		float d = mag(dx,dy);
		
		if(d > 0 && d < radius){
			float s = d/radius;
			float f = 1 / pow(s, 0.5 * 0.5) - 1;
			f = f/radius;

			theNode.velocity.x += dx * f;
			theNode.velocity.y += dy * f;
		}              
		
	}
	
}