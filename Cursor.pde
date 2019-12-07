// Cursor

class Cursor {
  Animation cursor;
  Animation sparkle;
  float xpos;
  float ypos;
  float drag = 10.0;
  
  boolean blackout;
  
  Cursor()
  {
    //cursor = new Animation("piskel/bone/bone_", 6);
    sparkle = new Animation("piskel/sparkle/sparkle_", 6);
    cursor = new Animation("piskel/sparkle/sparkle_", 6);
    blackout = true;
  }
  
  void follow()
  {
    float dx = mouseX - xpos;
    xpos = xpos + dx/drag;
  
    float dy = mouseY - ypos;
    ypos = ypos + dy/drag;
    
    cursor.display(xpos-cursor.getWidth()/2, ypos - cursor.getHeight()/2);
  
    if (blackout) {
      noFill();
      strokeWeight(50);
      stroke(0,0,0,63);
      ellipse(xpos, ypos, 200, 200);
  
      strokeWeight(1800);
      stroke(0,0,0,255);
      ellipse(xpos, ypos, 2000, 2000);
      
      noStroke();
    }
  }
  
  void blackout(boolean b)
  {
    blackout = b;
  }
  
  void throwBone()
  {
    sparkle.display(xpos-sparkle.getWidth()/2, ypos - sparkle.getHeight()/2);
  }
  
}
