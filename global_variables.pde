
PFont font; //font
PImage bg;  // background


ArrayList <PVector> points = new ArrayList <PVector> ();

boolean game_pause = false; // player is open setting ?
boolean game_start = false; 
boolean button_hover = false; // when user is hovering their cursor on anybutton, then change the cursor to HAND
boolean door_closed = false;
boolean win = false;
boolean lose = false;


int point = 220; // there are 220 points
int brick_size = 40; // size of a grid in the game.
int difficulty = 2;  // set the difficulty is medium, three value possible: 1 2 3
int score = 0;
int life = 3;




int[][] game_map = {{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}, // map grid
                    {1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1},
                    {1,0,1,1,1,0,1,1,1,0,1,0,1,1,1,0,1,1,1,0,1},
                    {1,0,1,1,1,0,1,1,1,0,1,0,1,1,1,0,1,1,1,0,1},
                    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                    {1,0,1,1,1,0,1,0,1,1,1,1,1,0,1,0,1,1,1,0,1},
                    {1,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,1},
                    {1,1,1,1,1,0,1,1,1,0,1,0,1,1,1,0,1,1,1,1,1},
                    {1,1,1,1,1,0,1,0,0,0,0,0,0,0,1,0,1,1,1,1,1},
                    {1,1,1,1,1,0,1,0,1,1,2,1,1,0,1,0,1,1,1,1,1},
                    {1,0,0,0,0,0,0,0,1,2,2,2,1,0,0,0,0,0,0,0,1},
                    {1,1,1,1,1,0,1,0,1,2,2,2,1,0,1,0,1,1,1,1,1},
                    {1,1,1,1,1,0,1,0,1,1,2,1,1,0,1,0,1,1,1,1,1},
                    {1,1,1,1,1,0,1,0,0,0,0,0,0,0,1,0,1,1,1,1,1},
                    {1,1,1,1,1,0,0,0,1,1,1,1,1,0,0,0,1,1,1,1,1},
                    {1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1},
                    {1,0,1,1,1,0,1,1,1,0,1,0,1,1,1,0,1,1,1,0,1},
                    {1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1},
                    {1,1,0,0,1,0,1,0,1,1,1,1,1,0,1,0,1,0,0,1,1},
                    {1,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,1},
                    {1,0,1,1,1,1,1,1,1,0,1,0,1,1,1,1,1,1,1,0,1},
                    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}};
    
Player player = new Player();
Ghost blinky = new Ghost("blinky");
Ghost clyde = new Ghost("clyde");
Ghost inky = new Ghost("inky");
Ghost pinky = new Ghost("pinky");
Controler controler = new Controler();


