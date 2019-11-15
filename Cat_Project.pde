Gif runningleft;
Gif walkingleft;
Gif standingleft;
Gif jumpleft;
Gif runningright;
Gif walkingright;
Gif standingright;
Gif jumpright;
HealthBar hp;
Arrow[] arrow;
PImage tree;
PImage field;
PImage archer;
PImage a;
PImage arch;
PImage kitchen;
PImage field2;
int catX;
int catY;
int direction;
int gear;
int ground;
int gmax;
int gmin;
int jump;
int anum;
int slow;
int archerX;
float angle;
int[] y, x;
int stage;
boolean jumping;
boolean falling;
boolean fire;
boolean firstTime;
boolean alive;
float velocityX, velocityY, gravity, t;
void setup()
{
  size(800,600);
  frameRate(50);
  catX = 100;
  catY = 520;
  gear = 0;
  direction = 1;
  ground = 521;
  jump = 0;
  slow = 0;
  anum = 0;
  textSize(11);
  y = new int[10];
  x = new int[20];
  arrow = new Arrow[10000];
  arrow[anum] = new Arrow(760,390);
  jumping = false;
  falling = false;
  fire = true;
  firstTime = true;
  alive = true;
  stage = 1;
  runningleft = new Gif(this, "rl.gif");
  walkingleft = new Gif(this, "wl.gif");
  standingleft = new Gif(this, "sl.gif");
  jumpleft = new Gif(this, "jl.gif");
  runningright = new Gif(this, "rr.gif");
  walkingright = new Gif(this, "wr.gif");
  standingright = new Gif(this, "sr.gif");
  jumpright = new Gif(this, "jr.gif");
  
  /*runningleft = new Gif(this, "rlt.gif");
  walkingleft = new Gif(this, "wlt.gif");
  standingleft = new Gif(this, "slt.gif");
  jumpleft = new Gif(this, "jlt.gif");
  runningright = new Gif(this, "rrt.gif");
  walkingright = new Gif(this, "wrt.gif");
  standingright = new Gif(this, "srt.gif");
  jumpright = new Gif(this, "jrt.gif");*/
  tree = loadImage("tree.png");
  field = loadImage("field.png");
  archer = loadImage("Archer.png");
  kitchen = loadImage("kitchen.jpg");
  field2 = loadImage("field2.png");
  hp = new HealthBar();
  hp.health = 100;
  hp.energy = 100;
  gravity = .3;
}

void draw()
{
  //background(167,115,161);
  if (alive == true)
  {
  if (stage == 0)
  {
    background(kitchen);
    platform0();
    platform0calc();
  }
  if (stage == 1)
  {
    background(tree);
    platform1();
    platform1calc();
    firstTime = true;
  }
  if (stage == 2)
  {
    if(firstTime)
    {
      calculate();
      firstTime = false;
    }
    background(field);
    image(archer,780 - archer.width / 2, 521 - archer.height);
    arrow[anum].drawArrow();
    //arrow[anum].x -= 10;
    //arrow[anum].y -= (10*angle);
    arrow[anum].x -= 10 * cos(angle);
    arrow[anum].y += 10 * sin(angle);
    if (fire)
    {
      calculate();
      fire = false;
    }
    arrow[anum].bounds();
  }
  if (stage == 3)
  {
    background(field2);
    firstTime = true;
  }
  hp.draw();
  text(catX + " " + catY + " " + gmin+ " " + gmax + " " + mouseX + " " + mouseY, 600,10);
  gravity();
  if (keyPressed)
  {
    
    if (key == CODED)
    {
      
    if (keyCode == RIGHT)
    {
      if (gear == 0)
      {
        walk(1);
        direction = 1;
        rest();
      }
      if (gear == 1)
      {
        run(1);
        direction = 1;
      }
    }
    
    if (keyCode == LEFT)
    {
      if (gear == 0)
      {
        walk(0);
        direction = 0;
        rest();
      }
      if (gear == 1)
      {
        run(0);
        direction = 0;
      }
    }
    
    } else {
      stand();
    }
      
    }
  else
  {
    Stop();
    stand();
    rest();
  }
  if (stage == 0 && catX > 800)
  {
    stage = 1;
    catX = 10;
  }
  if (stage == 1 && catX < 0)
  {
    stage = 0;
    catX = 790;
  }
  if (stage == 1 && catX > 800)
   {
     stage = 2;
     catX = 10;
   }
   if (stage == 2 && catX < 0)
   {
     stage = 1;
     catX = 790;
   }
   if (stage == 2 && catX > 800)
   {
     stage = 3;
     catX = 10;
   }
   if (stage == 3 && catX < 0)
   {
     stage = 2;
     catX = 790;
   }
  } else {
    fill(0);
    textSize(40);
    text("You Died",400,300);
    delay(5000);
    setup();
  }
}

void keyReleased()
{
  if (key == CODED)
  {
    if (keyCode == SHIFT)
    {
      stand();
      if (gear == 1)
      {
        gear = 0;
      } else {
        gear = 1;
      }
    }
  }
  if (key == ' ')
    {
      jumping = true;
      jump = 0;
    }
}

void stand()
{
  if (direction == 1 && !jumping)
    {
      image(standingright, catX - standingright.width / 2, catY - standingright.height);
    }
    if (direction == 0 && !jumping)
    {
      image(standingleft, catX - standingleft.width / 2, catY - standingleft.height);
    }
}

void walk(int dir)
{
  if (dir == 0)
  {
    image(walkingleft, catX - walkingleft.width / 2, catY - walkingleft.height);
    walkingleft.updatePixels();
    walkingleft.loop();
    catX -= 3;
  }
  if (dir == 1)
  {
    image(walkingright, catX - walkingright.width / 2, catY - walkingright.height);
    walkingright.loop();
    catX += 3;
  }
}

void run(int dir)
{
  if (hp.energy > 0)
  {
  if (dir == 0)
  {
    image(runningleft, catX - runningleft.width / 2, catY - runningleft.height);
    runningleft.loop();
    catX -= 10;
  }
  if (dir == 1)
  {
    image(runningright, catX - runningright.width / 2, catY - runningright.height);
    runningright.loop();
    catX += 10;
  }
  hp.energy -= 1;
  } else {
    gear = 0;
  }
}

void rest()
{
  if (hp.energy < 100)
  {
    hp.energy += 1;
  }
}

void Stop()
{
  runningleft.stop();
  walkingleft.stop();
  runningright.stop();
  walkingright.stop();
  jumpright.stop();
  jumpleft.stop();
}

class HealthBar {
  float health, energy, mx, x, y, w, h;
  color backing, hpbar, ebar;
  PImage heart = loadImage("heart.png");
  PImage bolt = loadImage("bolt.png");
  HealthBar(){
    mx = 100;
    x = 50;
    y = 20;
    w = 200;
    h = 10;
    hpbar = color(255, 0, 0);
    ebar = color(39, 219, 15);
    backing = color(117, 113, 113);
  }
  void draw(){
    if (health <= 0)
    {
      alive = false;
    }
    fill(backing);
    stroke(0);
    rect(x,y,w,h);
    fill(hpbar);
    rect(x,y,map(health,0,mx,0,w),h);
    image(heart,x-15,y-5,25,25);
    
    fill(backing);
    stroke(0);
    rect(x,y + 25,w,h);
    fill(ebar);
    rect(x,y + 25,map(energy,0,mx,0,w),h);
    image(bolt,x-15,y+20,25,25);
    
  }
} 

void platform1()
{
  y[0] = 115;
  y[1] = 190;
  y[2] = 256;
  y[3] = 280;
  y[4] = 325;
  x[0] = 282;
  x[1] = 700;
  x[2] = 0;
  x[3] = 125;
  x[4] = 755;
  x[5] = 800;
  x[6] = 200;
  x[7] = 275;
  x[8] = 410;
  x[9] = 460;
}

void platform0()
{
  y[0] = 340;
  y[1] = 185;
  y[2] = 75;
  x[0] = 230;
  x[1] = 770;
  x[2] = 65;
  x[3] = 220;
  x[4] = 360;
  x[5] = 650;
}

void platform1calc()
{
  int ng = 521;
  while (ng == 521)
  {
    if (x[8] < catX && catX < x[9] && catY <= y[4])
    {
      ground = y[4];
      gmax = x[9];
      gmin = x[8];
      break;
    } else {
      ground = 521;
      gmax = 10000;
      gmin = -10000;
    }
    if (x[6] < catX && catX < x[7] && catY <= y[3])
    {
      ground = y[3];
      gmax = x[7];
      gmin = x[6];
      break;
    } else {
      ground = 521;
      gmax = 10000;
      gmin = -10000;
    }
    if (x[4] < catX && catX < x[5] && catY <= y[2])
    {
      ground = y[2];
      gmax = x[5];
      gmin = x[4];
      break;
    } else {
      ground = 521;
      gmax = 10000;
      gmin = -10000;
    }
    if (x[2] < catX && catX < x[3] && catY <= y[1])
    {
      ground = y[1];
      gmax = x[3];
      gmin = x[2];
      break;
    } else {
      ground = 521;
      gmax = 10000;
      gmin = -10000;
    }
    if (x[0] < catX && catX < x[1] && catY <= y[0])
    {
      ground = y[0];
      gmax = x[1];
      gmin = x[0];
      break;
    } else {
      ground = 521;
      gmax = 10000;
      gmin = -10000;
    }
    break;
  }
}

void platform0calc()
{
  int ng = 521;
  while (ng == 521)
  {
    if (x[4] < catX && catX < x[5] && catY <= y[2])
    {
      ground = y[2];
      gmax = x[5];
      gmin = x[4];
      break;
    } else {
      ground = 521;
      gmax = 10000;
      gmin = -10000;
    }
    if (x[2] < catX && catX < x[3] && catY <= y[1])
    {
      ground = y[1];
      gmax = x[3];
      gmin = x[2];
      break;
    } else {
      ground = 521;
      gmax = 10000;
      gmin = -10000;
    }
    if (x[0] < catX && catX < x[1] && catY <= y[0])
    {
      ground = y[0];
      gmax = x[1];
      gmin = x[0];
      break;
    } else {
      ground = 521;
      gmax = 10000;
      gmin = -10000;
    }
    break;
  }
}

void gravity()
{
    if (catY < ground && !jumping)
    {
      if (!falling)
      {
        t = 0;
        falling = true;
        if (direction == 0)
        {
          velocityX = -3;
        }
        if (direction == 1)
        {
          velocityX = 3;
        }
      }
          if (falling)
          {
          velocityY += gravity * t;        // Apply gravity to vertical velocity
          catX += velocityX * t;      // Apply horizontal velocity to X position
          if (catY + (velocityY * t) > ground)
          {
            catY = ground;
            falling = false;
          } else {
          catY += velocityY * t;      // Apply vertical velocity to y position
          }
          }
          t += .02;
    }
          if (jumping)
          {
            if (jump == 0)
            {
              if (hp.energy >= 50)
              {
              t = 1;
              velocityY = -12;
              hp.energy -= 50;
              jump = 1;
              if (direction == 0)
              {
                 velocityX = -5;
              }
              if (direction == 1)
              {
                velocityX = 5;
              }
               } else {
                jumping = false;
              }
              
            }
          velocityY += gravity * t;        // Apply gravity to vertical velocity
          catX += velocityX * t;      // Apply horizontal velocity to X position
          if (catY + (velocityY * t) > ground)
          {
            catY = ground;
            jumping = false;
          } else {
          catY += velocityY * t;      // Apply vertical velocity to y position
          if (direction == 0)
          {
            image(jumpleft, catX - jumpleft.width / 2, catY - jumpleft.height);
          }
          if (direction == 1)
          {
            image(jumpright, catX - jumpright.width / 2, catY - jumpright.height);
          }
          }
          }
          
}

class Arrow
{
  PImage img = loadImage("arrow.png");;
  float x;
  float y;
  
  Arrow(float startX, float startY)
  {
    x = startX;
    y = startY;
  }
  
  void drawArrow()
  {
    image(img,x,y + (img.height / 2));
  }
  
  void bounds()
  {
    if (this.x <= 0 || this.x >= 800 || this.y + img.height <= 0 || this.y + img.height >= 521)
    {
      anum += 1;
      arrow[anum] = new Arrow(760,390);
      fire = true;
    }
    if (this.x <= catX - (walkingleft.width / 2) && this.x <= catX + (walkingleft.width / 2) && this.y >= catY && this.y <= catY + walkingleft.height)
    {
      hp.health -= 25;
      anum += 1;
      arrow[anum] = new Arrow(760,390);
      fire = true;
    }
  }
}
  
  void calculate()
  {
    angle = -1 * (atan((390 - catY)/(760-catX))); //((390 - catY)/(760-catX));
    println(degrees(angle));
  }