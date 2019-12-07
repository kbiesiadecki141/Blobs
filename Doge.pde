
class Doge
{
  Animation doge_left;
  Animation doge_right;
  Animation doge_front;

  Doge()
  {
    doge_left = new Animation("piskel/dogleft/dogleft_", 6);
    doge_right = new Animation("piskel/dogright/dogright_", 6);
    doge_front = new Animation("piskel/dogfront/dogfront_", 1);
  }
  
  void sniff()
  {
   
  }
}
