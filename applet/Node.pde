class Node extends PVector{
	PVector velocity = new PVector();
	float minX = 65, minY = 30, maxY = height-30, maxX = width - 65;
	float damping = 0.1;
  
  Node(float theX, float theY){
  	x = theX;
  	y = theY;      
		println("Node creates");
  }          
	
	void update(){
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
