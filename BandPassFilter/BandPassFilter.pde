/**
  * This sketch demonstrates how to use the BandPass effect.<br />
  * Move the mouse left and right to change the frequency of the pass band.<br />
  * Move the mouse up and down to change the band width of the pass band.
  * <p>
  * For more information about Minim and additional features, visit http://code.compartmental.net/minim/
  */
  
float a = 3.95;
float ch = 0.892;
  
import ddf.minim.*;
import ddf.minim.effects.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput output;
FilePlayer groove;
BandPass   bpf;

void setup()
{
  size(512, 200, P3D);
  
  minim = new Minim(this);
  output = minim.getLineOut();
  
  groove = new FilePlayer( minim.loadFileStream("2.mp3") );
  // make a band pass filter with a center frequency of 440 Hz and a bandwidth of 20 Hz
  // the third argument is the sample rate of the audio that will be filtered
  // it is required to correctly compute values used by the filter
  bpf = new BandPass(440, 20, output.sampleRate());
  groove.patch( bpf ).patch( output );
  // start the file playing
  groove.loop();
}

void draw()
{
  background(0);
  stroke(255);
  // draw the waveforms
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  for(int i = 0; i < output.bufferSize()-1; i++)
  {
    float x1 = map(i, 0, output.bufferSize(), 0, width);
    float x2 = map(i+1, 0, output.bufferSize(), 0, width);
    line(x1, height/4 - output.left.get(i)*50, x2, height/4 - output.left.get(i+1)*50);
    line(x1, 3*height/4 - output.right.get(i)*50, x2, 3*height/4 - output.right.get(i+1)*50);
  }
  // draw a rectangle to represent the pass band
  noStroke();
  fill(255, 0, 0, 60);
  rect(mouseX - bpf.getBandWidth()/20, 0, bpf.getBandWidth()/10, height);
  
  
    float q = map(mouseX, 0,width,400, 50);

  float p = map(mouseX, 0,width,800,100);

 // float cutoff = ch *q;
  //hpf.setFreq(cutoff);
  ch = chaos(ch,1);
  float passBand = ch *q;
  bpf.setFreq(passBand);
  //println(ch);
  float bandWidth = 600;
   bpf.setBandWidth(bandWidth);

  a = map(mouseX,0,width,1,4);
  println(a);
}

float chaos(float i, int s){
 for(int k=0; k<s; k++){
  i = a*i *(1-i); 
 }
 return i;
}