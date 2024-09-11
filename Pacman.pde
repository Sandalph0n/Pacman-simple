/*
Pacman game, recreated by Khoi Nguyen - oneID: 48651672

Hii, this is my Pacman project - a simple version of the game pacman.

Everything in this game, i coded them myself!!

- all global variables are put in global_variables.pde
- all graphical functions are put in graphics.pde
- mouse and keyboard event handler are put in event_handler.pde
- code for ghost object are in ghosts.pde
- code for player are in player.pde
- main controller, including time counter is in controller.pde

REFERENCE
map: 
https://www.youtube.com/watch?v=GXlckaGr0Eo
other assets (ghost, player ...):
https://pixelaholic.itch.io/pac-man-game-art

*/




void setup() {
    size(1080,920); // 25* brick_size and 23*brick_size
    font = createFont("assets/Pixeltype.ttf",20); // load font
    bg = loadImage("assets/map.jpg");             // load background
    bg.resize(21*brick_size,23*brick_size);       // resize it to fit the screen
    
    
    
    for (int y = 0; y < 23 ; y++){ // read the map, and every place that player can walk on, put a circle representing point
        for (int x = 0; x < 21; x++){
            if (game_map[y][x] == 0){
                if ((y == 9 && x == 10 )||(y == 12 && x == 10 )){
                    continue;
                }
                points.add(new PVector(x*brick_size+ brick_size/2,y*brick_size+ brick_size/2));
            }
        }
    }
    
    // load images of every objects
    player.loading_assets();
    blinky.loading_assets(); 
    clyde.loading_assets(); 
    inky.loading_assets(); 
    pinky.loading_assets(); 



        


    
}




void draw() {  
    //  i will use this draw function as a game loop, means everything that
    //  have to be run repeatedly will be put here
    background(0); // black background
    imageMode(CORNER);
    image(bg, 0, 0);

    
    button_hover = false; // control if the cursor is hand or arrow
    if (!game_start){
        menu_graphic();
    }
    else if (lose) {
        game_lose();
    }
    else if (win) {
        game_win();
    }

    else {
        /*  call the update method of every object
            update methods including key handler (for player), movement, redirection
            or find_way method (for ghost), etc...
        */ 
        player.update();   
        blinky.update();
        clyde.update();
        inky.update();
        pinky.update();
        controler.update();
    
        game_graphics();
        
    }
    alway_on_display();
    
}

