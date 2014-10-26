class Subtitles {
    
  Subtitles () {
  }
  
  void display (String _t) {
    textAlign(CENTER);
    
    pushMatrix();
    translate(0, hu*8.5);
    textFont(subFont);
    fill(0);
    text(_t,3,3,wu*10,100);
    fill(246,246,0);
    text( _t,0,0,wu*10,100);
    popMatrix();
    
    noStroke();
    textAlign(LEFT);
  }
}
