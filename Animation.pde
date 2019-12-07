// Animate sequence of gifs.

class Animation 
{
  PImage[] images;
  int imageCount;
  int frame;
  
  int w;
  int h;
  
  Animation(String imagePrefix, int count) 
  {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i, 1) + ".png";
      images[i] = loadImage(filename);
    }
    w = images[0].width;
    h = images[0].height;
  }

  void display(float xpos, float ypos) 
  {
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos, w, h);
  }
  
  void setWH(int wid, int hei) 
  {
    w = wid;
    h = hei;
  }
  
  int getWidth() 
  {
    return w;
    //return images[0].width;
  }
  
  int getHeight() 
  {
    return h;
    //return images[0].height;
  }
}
