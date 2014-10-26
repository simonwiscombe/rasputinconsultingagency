/* RASPUTIN CONSULTING AGENCY
 * 
 * 
 */

import processing.opengl.*;
import hypermedia.video.*;
import java.awt.Rectangle;
import ddf.minim.*;

// custom classes
Background bg;
Rasputin rasputin;

// util var
float wu;
float hu;

// game variables
String state;
boolean areFaces;
boolean hasActed;

// font variables
PFont hFont;
PFont subFont;

// audio
Minim minim;
AudioSample askMeQuestion;
AudioSample questionForYou;
AudioSample letMeThink;
AudioSample fearNot;
AudioSample bellTolls;
AudioSample noDoctors;
AudioSample angelsCome;
AudioSample faithReward;
AudioSample stormClouds;
AudioSample childBleeds;
AudioSample headToWar;

AudioSample readFuture;
AudioSample bloodFlows;
AudioSample endOfTimes;
AudioSample apocalypseOfBirds;
AudioSample universeWithinOutwards;
AudioSample riseSinNoMore;
AudioSample ruleforCenturies;

boolean sketchFullScreen() {
  return true;
}

void setup() {
  size(displayWidth, displayHeight, OPENGL);
  frameRate(15);
  
  noStroke();
  smooth();
  
  // util init
  wu = width*(.1);
  hu = height*(.1);
  
  // audio
  minim = new Minim(this);
  askMeQuestion = minim.loadSample("askMeQuestion-LookIntoSoul.wav");
  readFuture = minim.loadSample("readFuture.wav");
  
  letMeThink = minim.loadSample("hmMM.wav");
  
  bellTolls = minim.loadSample("bellTolls-AnnounceTruth.wav");
  angelsCome = minim.loadSample("angelsCome-Last.wav");
  fearNot = minim.loadSample("fearNot-DreamsTrue.wav");
  faithReward = minim.loadSample("faithReward.wav");
  stormClouds = minim.loadSample("stormClouds.wav");
  childBleeds = minim.loadSample("childBleeds.wav");
  headToWar = minim.loadSample("headToWar.wav");
  
  bloodFlows = minim.loadSample("bloodFlows.wav");
  ruleforCenturies = minim.loadSample("commonMan-RuleForCenturies.wav");
  noDoctors = minim.loadSample("noDoctors-GiveRest.wav");
  endOfTimes = minim.loadSample("endOfTimes.wav");
  apocalypseOfBirds = minim.loadSample("apocalypseOfBirds.wav");
  universeWithinOutwards = minim.loadSample("universeWithinOutwards.wav");
  riseSinNoMore = minim.loadSample("riseSinNoMore.wav");
  
  // class init
  bg = new Background();
  rasputin = new Rasputin();
  
  // variables init
  state = "idle";
  hasActed = true;
  areFaces = true;
  
  // font set up
  hFont = loadFont("Arial-Black-60.vlw");
  textFont(hFont);
  textAlign(LEFT);
  
  subFont = loadFont("Arial-ItalicMT-36.vlw");
  
// text("Распутин консультации", 100, 100, 1000, 400 );
}

void draw() {
  bg.sketch();
  rasputin.update();
  
  // --------------------------------
  //     STUFF HAPPENS AFTER THIS
  
  // decide what to do.
  if ( areFaces ) {
    // if the person has interacted with rasputin, pick a new
    // random thing to do.
    if ( hasActed ) {
      float rand = random(10);
      if ( rand <= 5 ) {
        state = "player_ask";
      }
      else if ( rand <= 10 ) {
        state = "rasputin_fortune";
      }
      else {
        state = "rasputin_ask";
      }
      hasActed = false;
    }
  }
  else {
    state = "idle";
  }
  
  // execute on rasputin doing it.
  if ( state == "idle" ) {
    rasputin.idle();
  }
  else if ( state == "player_ask" ) {
    rasputin.player_ask();
    hasActed = rasputin.hasFinished();
  }
  else if ( state == "rasputin_ask") {
    rasputin.rasputin_ask();
  }
  else if ( state == "rasputin_fortune" ) {
    rasputin.rasputin_fortune();
  }
  
  hasActed = rasputin.hasFinished;
}

void resetRasputin() {
  if ( !hasActed ) {
    hasActed = true;
    rasputin.resetHim();
  }
}
