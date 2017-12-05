             //the original play speed
PImage[] images;
int i=0;
int count=0;
boolean run=true;
PImage[][] lines;
float a=3.95;
float ch= 0.892;



void setup() {
  size(840,480);
  images=new PImage[3569];
    lines = new PImage[3569][480];
  for (int i=0; i<images.length; i++) {        //loading a sequence of images
    String filename="clip_"+i+".jpg";            //because my images' name is from 1~66
    images[i]=loadImage(filename);
   // image(images[i],0,0,600,600);
      for (int j = 0; j < 480; j++) {
    lines[i][j] = images[i].get(0, j, 640, 1);
  }
  }

frameRate(24);

}

void draw() {
  background(0);
 // image(images[j], 600, 100, 341, 300);    //text instrctions
  fill(255);
  if (run) {
                        //every Ts display an image
        i++;
        count=0;
        if (i>3568) { 
          i=0;
        }
      } 
    
float mouse = constrain(mouseX,0,width);    
 if(mouseX<0)mouseX=0;
 else if(mouseX>width)mouseX=width;

 
  
 for(int b=0; b<480; b++){
   ch = chaos(ch,b);
   
   
   lines[i][b].loadPixels();
   for(int x=0; x<640 ;x++){
  for(int y = 0; y<1;y++){
     int pos = 640 *y +x;
     color c=lines[i][b].pixels[pos];
     float r = red(c);
     float g = green(c);
     float blue = blue(c);
     r = map(mouse,0,width,r,blue);
     g = map(mouse,0,width,g,blue);
     //blue = map(mouse,0,width,blue,r);
     color newc = color(r,g,blue);
     lines[i][b].pixels[pos] = newc;
   }
   }
   lines[i][b].updatePixels();
 
 
 image(lines[i][b],ch*200,b,640,1); 
 
 }
 a = map(mouseX,0,width,1,4);
String s = "a:"+a;
fill(255);
text(s, 100, 40);

saveFrame("chaos-####.jpg"); 

}


float chaos(float i, int s){
 for(int k=0; k<s; k++){
  i = a*i *(1-i); 
 }
 return i;
}