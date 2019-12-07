
class Blob
{
  int w;
  int h;
  
  float xpos;
  float ypos;
  
  int shade;
  
  int lifespan;
  
  Timer timer;
  
  Animation anim;
  
  
  Blob()
  {
    w = 5;
    xpos = random(1280);
    ypos = random(720);
    
    timer = new Timer(10);
    timer.start();
    shade = 126;
    
    lifespan = 5;
    
    anim = new Animation("piskel/blob/blob_", 4);
    
  }
 
   void beABlob()
   {
       //fill(shade);
       //ellipse(xpos, ypos, w, w);
       
       anim.display(xpos-anim.getWidth()/2, ypos - anim.getHeight()/2);
       anim.setWH(anim.getWidth() + 1, anim.getWidth() + 1);
       
       w++;
   }
   
   float getX()
   {
     return xpos;
   }
   
   float getY()
   {
     return ypos;
   }
   
   boolean exploded()
   {
     return timer.done();
   }
   
   boolean killed()
   {
     return lifespan <= 0;
   }
   
   boolean overCircle() {
      float disX = xpos - mouseX;
      float disY = ypos - mouseY;
      if(sqrt(sq(disX) + sq(disY)) < w/2 ) {
        shade = 255;
        return true;
      } else {
        shade = 126;
        return false;
      }
  }
  
  void attack()
  {
    lifespan--;
  }
  
  void spew()
  {
    print("protat");
  }
  
}
