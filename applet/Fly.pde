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

	void move(){
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
