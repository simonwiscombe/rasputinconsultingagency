class Rasputin {
  
  Subtitles sub;
  
  float posx;
  float posy;
  
  float timer;
  
  PImage head;
  PImage mouth;
  PImage eyes;
  
  boolean talking;
  float talkTime;
  float talkTimer;
  float mouthTimer;
  boolean mouthOpen;
  
  boolean doAction;
  boolean think;
  boolean hasFinished;
  boolean eyesShown;
  
  String[] questionResponses = new String[7];
  String responseString;
  
  String[] fortuneResponses = new String[7];
  
  Rasputin () {
    sub = new Subtitles();
    posx = wu*5;
    posy = hu*5;
    
    talking = false;
    talkTimer = 0;
    mouthTimer = 0;
    hasFinished = false;
    eyesShown = false;
    
    mouthOpen = false;
    timer = 300;
    think = false;
    
    head = loadImage("Rasputin-Head.png");
    mouth = loadImage("Rasputin-Mouth.png");
    eyes = loadImage("Rasputin-Eyes.png");
    
    questionResponses[0] = "GOD HAS SEEN YOUR TEARS AND HEARD YOUR PRAYERS. FEAR NOT, YOUR DREAMS WILL COME TRUE.";
    questionResponses[1] = "WHEN THE BELL TOLLS THREE TIMES, IT WILL ANNOUNCE THE TRUTH.";
    questionResponses[2] = "WHEN ANGELS COME, THEY WILL SEE TO YOUR REQUEST LAST.";
    questionResponses[3] = "FAITH WILL REWARD.";
    questionResponses[4] = "STORM CLOUDS GATHER IN RESPONSE TO YOUR WORDS.";
    questionResponses[5] = "SO LONG AS THE CHILD BLEEDS!";
    questionResponses[6] = "HEAD TO WAR WITH THE CZAR AND THE ANSWER WILL COME WHEN AWAY.";
    
    fortuneResponses[0] = "IF YOU ARE KILLED BY A COMMON MAN, YOUR FAMILY WILL RULE FOR CENTURIES.";
    fortuneResponses[1] = "DON'T LET THE DOCTORS BOTHER YOU TOO MUCH. GIVE YOURSELF REST.";
    fortuneResponses[2] = "BLOOD FLOWS WHERE SOULS CANNOT GATHER.";
    fortuneResponses[3] = "THE END OF TIMES WILL ARRIVE ON AUGUST 23, 2013.";
    fortuneResponses[4] = "YOUR DAY OF RECKONING IS NEAR. LOOK FOR AN APOCALYPSE OF BIRDS.";
    fortuneResponses[5] = "YOUR UNIVERSE IS WORKED FROM WITHIN OUTWARDS.";
    fortuneResponses[6] = "FOR THEIR DEAR SAKES WHO TORTURE BORE, RISE, BROTHER, GO AND SIN NO MORE.";
  }
  
  void resetHim () {
    talking = false;
    talkTimer = 0;
    mouthTimer = 0;
    hasFinished = false;
    eyesShown = false;
    
    mouthOpen = false;
    timer = 300;
    think = false;
  }
  
  void update () {
    
    if ( talking ) {
      if ( talkTimer == 0 ) {
        mouthOpen = true;
      }
      
      mouthTimer++;
      if( mouthTimer >= 3) {
        mouthOpen = !mouthOpen;
        mouthTimer = 0;
      }
      
      talkTimer++;
      if ( talkTimer >= talkTime ) {
        talking = false;
        talkTimer = 0;
        mouthOpen = false;
      }
    }
    
    // move back and forth
    posx += 100 * sin(.0004 * millis()) / 360;
    posy += 50 * sin(.0003 * millis()) / 360;
    
    pushMatrix();
    rectMode(CENTER);
    translate(posx, posy);
    scale(0.8);
    image(head, -head.width/2, -head.height/2);
    if ( mouthOpen ) {
      openMouth();
    }
    else {
      closeMouth();
    }
    scale(1);
    rectMode(CORNER);
    popMatrix();
  }
  
  void rasputin_ask () {
    
  }
  
  void player_ask () {
    if ( !doAction ) {
      if ( timer == 0 ) {
        hasFinished = false;
      }
      
      timer += 1;
      if ( timer >= frameRate*10 ) {
        askMeQuestion.trigger();
        talkFor(3.2);
        timer = 0;
      }
      
      sub.display("COME WITH A QUESTION IN YOUR HEART. I WILL LOOK INTO YOUR SOUL.");
      
      if ( keyPressed ) {
        askMeQuestion.stop();
        doAction = true;
        timer = 0;
      }
    }
    else {
      if ( timer == 0 ) {
        letMeThink.trigger();
        talkFor(3.5);
      }
      
      timer++;
      if ( timer < 3.6*frameRate ) {
        sub.display("HMMMMMMMMMMMM.");
        eyesShown();
      }
      else {
        if ( !think ) {
          int rand = floor(random(questionResponses.length));
          responseString = questionResponses[rand];
          
          if ( rand == 0 ) {
            fearNot.trigger();
            talkFor(5.5);
          }
          else if ( rand == 1 ) {
            bellTolls.trigger();
            talkFor(3.4);
          }
          else if ( rand == 2 ) {
            angelsCome.trigger();
            talkFor(3.4);
          }
          else if ( rand == 3 ) {
            faithReward.trigger();
            talkFor(1);
          }
          else if ( rand == 4 ) {
            stormClouds.trigger();
            talkFor(2.8);
          }
          else if ( rand == 5 ) {
            childBleeds.trigger();
            talkFor(1.4);
          }
          else if ( rand == 6 ){
            headToWar.trigger();
            talkFor(3.5);
          }
          
          think = true;
        }
        
        sub.display(responseString);
        if ( timer > 12*frameRate ) {
          hasFinished = true;
          timer = 0;
          think = false;
          doAction = false;
        }
      }
    }
  }
  
  void rasputin_fortune () {
    if ( !doAction ) {
      if ( timer == 0 ) {
        hasFinished = false;
      }
      
      timer += 1;
      if ( timer >= frameRate*10 ) {
        readFuture.trigger();
        talkFor(2);
        timer = 0;
      }
      
      sub.display("I WILL READ YOUR FUTURE.");
      
      if ( keyPressed ) {
        readFuture.stop();
        doAction = true;
        timer = 0;
      }
    }
    else {
      if ( timer == 0 ) {
        letMeThink.trigger();
        talkFor(3.5);
      }
      
      timer++;
      if ( timer < 3.6*frameRate ) {
        sub.display("HMMMMMMMMMMMM.");
        eyesShown();
      }
      else {
        if ( !think ) {
          int rand = floor(random(fortuneResponses.length));
          responseString = fortuneResponses[rand];
          eyesShown = false;
          
          if ( rand == 0 ) {
            ruleforCenturies.trigger();
            talkFor(5);
          }
          else if ( rand == 1 ) {
            noDoctors.trigger();
            talkFor(4.8);
          }
          else if ( rand == 2 ) {
            bloodFlows.trigger();
            talkFor(2.7);
          }
          else if ( rand == 3 ) {
            endOfTimes.trigger();
            talkFor(4.2);
          }
          else if ( rand == 4 ) {
            apocalypseOfBirds.trigger();
            talkFor(3.5);
          }
          else if ( rand == 5 ) {
            universeWithinOutwards.trigger();
            talkFor(2.3);
          }
          else if ( rand == 6 ) {
            riseSinNoMore.trigger();
            talkFor(5.5);
          }
          
          think = true;
        }
        
        sub.display(responseString);
        if ( timer > 12*frameRate ) {
          hasFinished = true;
          timer = 0;
          think = false;
          doAction = false;
        }
      }
    }
  }
 
  void idle () {
    mouthOpen = false;    
  }
  
  void eyesShown() {
    pushMatrix();
    rectMode(CENTER);
    translate(posx, posy);
    scale(1.5);
    image( eyes, -eyes.width/2 + 5*sin(millis()) + 5, -eyes.height/2 - 80);
    scale(1);
    rectMode(CORNER);
    popMatrix();
  }
  
  void openMouth() {
    image(mouth, -mouth.width/2 + 11, -mouth.height/2 + 430);
  }
  
  void closeMouth() {
    image(mouth, -mouth.width/2 + 11, -mouth.height/2 + 340);
  }
  
  void superMouth() {
    image(mouth, -mouth.width/2 + 11, -mouth.height/2 + 100);
  }
  
  boolean hasFinished() {
    return hasFinished;
  }
  
  void talkFor( float _t ) {
    talking = true;
    talkTime = _t * frameRate;
  }
}
