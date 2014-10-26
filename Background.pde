class Background {
  
  PImage logo;
  
  Background () {
    logo = loadImage("RasputinConsultancy_Logo.png");
  }
  
  void sketch() {
    background(255,255,255);
    textFont(hFont);
    
    pushMatrix();
    fill(200,0,0);
    translate(25, hu*0.25);
    image(logo, 0, 0);
    
    popMatrix();
  }
}
