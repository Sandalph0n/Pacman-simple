
class Player extends Thread{ 
    // the animation of Pacman is updated each 100ms
    // so i have to run another thread to count separately
    // function to update animation is run, which is overrided


    float speed = 3.4;
    
    float x = (float)(10*brick_size + brick_size/2) ; // player position
    float y = (float)(17*brick_size + brick_size/2) ;

    int grid_x; // player position on grid table
    int grid_y;

    // this point is in front of player, depend on player's dirrection
    // this is to check if player is able to move forward, by calculating the grid_position of this point, and compare to the map

    float face_x;
    float face_y;
    
    private String current_direction = "left"; // current movement direction
    private String next_direction = "left"; // store user input

    private boolean moving = true;

    private ArrayList<PImage> g_up = new ArrayList<PImage>();
    private ArrayList<PImage> g_down = new ArrayList<PImage>();
    private ArrayList<PImage> g_left = new ArrayList<PImage>();
    private ArrayList<PImage> g_right = new ArrayList<PImage>();
    
    PImage current_image;
    
    private void loading_assets(){

        // loading every image 
        PImage p_u_1 = loadImage("assets/pacman-up/1.png");
        PImage p_u_2 = loadImage("assets/pacman-up/2.png");
        PImage p_u_3 = loadImage("assets/pacman-up/3.png");  
        PImage p_d_1 = loadImage("assets/pacman-down/1.png");
        PImage p_d_2 = loadImage("assets/pacman-down/2.png");
        PImage p_d_3 = loadImage("assets/pacman-down/3.png");  
        PImage p_l_1 = loadImage("assets/pacman-left/1.png");
        PImage p_l_2 = loadImage("assets/pacman-left/2.png");
        PImage p_l_3 = loadImage("assets/pacman-left/3.png");
        PImage p_r_1 = loadImage("assets/pacman-right/1.png");
        PImage p_r_2 = loadImage("assets/pacman-right/2.png");
        PImage p_r_3 = loadImage("assets/pacman-right/3.png");
        
        int img_size = 28;

        // resize
        p_u_1.resize(img_size,img_size);
        p_u_2.resize(img_size,img_size);
        p_u_3.resize(img_size,img_size);
        p_d_1.resize(img_size,img_size);
        p_d_2.resize(img_size,img_size);
        p_d_3.resize(img_size,img_size);
        p_l_1.resize(img_size,img_size);
        p_l_2.resize(img_size,img_size);
        p_l_3.resize(img_size,img_size);
        p_r_1.resize(img_size,img_size);
        p_r_2.resize(img_size,img_size);
        p_r_3.resize(img_size,img_size);


        // add image to image sets
        this.g_up.add(p_u_1);
        this.g_up.add(p_u_2);
        this.g_up.add(p_u_3);
        this.g_down.add(p_d_1);
        this.g_down.add(p_d_2);
        this.g_down.add(p_d_3);
        this.g_left.add(p_l_1);
        this.g_left.add(p_l_2);
        this.g_left.add(p_l_3);
        this.g_right.add(p_r_1);
        this.g_right.add(p_r_2);
        this.g_right.add(p_r_3);
    }
    
    void update_grid_position(){ // calculate player position on map's grid
        this.grid_x = (int)this.x / brick_size;
        this.grid_y = (int)this.y / brick_size;
        // println(this.grid_x,this.grid_y);
    }

    @Override
    void run(){ // this function is to update animation only, but i have to overide it as run, since "run" is a method of the parent class Thread
        int i = 0;
        int d_i = 1;
        
        // every direction have three image, so the image set is changed depend on player's direction
        ArrayList<PImage> image_set = new ArrayList<PImage>();
        while (true){
            // if(!game_start){return;}// if game is not started, then do nothing
                
            if (current_direction ==  "left"){
                image_set = g_left; // if direction is left, then assign the left image set
            }           
            // same thing for other direction
            else if (current_direction == "right") {
                image_set = g_right; 
                
            }
            else if (current_direction == "up") {
                image_set = g_up;  
            }
            else if (current_direction == "down") {
                image_set = g_down;  
            }

            this.current_image = image_set.get(i); // current image is what displayed on the screen
            // every image set have three image, so keep changing these image creating animation
            
            if (i >= 2){
                d_i = -1;
            }
            if (i <= 0){
                d_i = 1;
                
            }
            
            
            if (this.moving){i += d_i;}
               
            delay(100); // stop 0.1s
            
        }

    }
    
    void update_face_position(){

        // this method is to create a point in front of player, to check if player face a wall
        if (this.current_direction == "left"){
            this.face_x = this.x - brick_size/2 - 2;
            this.face_y = this.y;
        }
        else if (this.current_direction == "right") {
            this.face_x = this.x + brick_size/2 + 2;
            this.face_y = this.y;
        } 
        else if (this.current_direction == "up") {
            this.face_x = this.x;
            this.face_y = this.y - brick_size/2 - 2 ;
        }  
        else if (this.current_direction == "down") {
            this.face_x = this.x;
            this.face_y = this.y + brick_size/2 + 2 ;
        }  
    }

    void redirection(){
        // player can only redirect, if it stand close to the middle of a square
        // so i calculate the offset from player's pos, to the middle first
        
        if (this.next_direction == this.current_direction){
            return; // if player didn't press key to redirect then do nothing
        }

        int offset_x = (int)abs(this.x % brick_size - brick_size/2);
        int offset_y = (int)abs(this.y % brick_size - brick_size/2);
        
        boolean centralization = false;// if player redirect, then i have to centralize player to the middle to avoid overlapping walls

        // check if player is in the middle of square, if not, then return        
        if (this.current_direction == "left"  || this.current_direction == "right"){
            if (next_direction == "up" || next_direction == "down"){
                if (offset_x > speed+speed/2){
                    return;
                }
                centralization = true;
            }
        }
        
        if (this.current_direction == "up"  || this.current_direction == "down"){
            if (next_direction == "left" || next_direction == "right"){
                if (offset_y > speed+speed/2){
                    return;
                }
                centralization = true;

            }
        }

        // calculate the after-redirecting position
        // to check if player can redirect

        // if player redirect, then check the next grid (after player redirect) is a wall or not
        int next_grid_x = this.grid_x;
        int next_grid_y = this.grid_y;
        if (next_direction == "up"){
            next_grid_y = this.grid_y-1;
        }
        else if (next_direction == "down"){
            next_grid_y = this.grid_y+1;
        }
        else if (next_direction == "right"){
            next_grid_x = this.grid_x+1;
        }
        else if (next_direction == "left"){
            next_grid_x = this.grid_x-1;
        }
        if (game_map[next_grid_y][next_grid_x] == 1 || game_map[next_grid_y][next_grid_x] == 2){
            return;
        }

        // when every conditions above are fulfilled, then redirect the player

        if (centralization){// centralize player to the middle
            // print("centralized");
            this.x = this.grid_x*brick_size + brick_size/2;
            this.y = this.grid_y*brick_size + brick_size/2;
        }
        this.current_direction = this.next_direction; // redirect





    }

    void movement(){

        // calculate the player's face on map-grid, if it is a wall, then can't move
        int face_grid_x = (int)this.face_x / brick_size;
        int face_grid_y = (int)this.face_y / brick_size;
        if (game_map[face_grid_y][face_grid_x] == 1 || game_map[face_grid_y][face_grid_x] == 2){
            this.moving = false;
            return; // If the point in front of the player is a wall, stop executing the move.
        } 
        this.moving = true;

        if (this.current_direction == "up"){
            this.y -= speed;
        }
        else if (this.current_direction == "down") {
            this.y += speed;   
        }
        else if (this.current_direction == "left") {
            this.x -= speed;   
        }
        else if (this.current_direction == "right") {
            this.x += speed;   
        }
        // this.eating_point();

    }

    void keyboard_handler(){ // change the NEXT direction of player
        // the next direction is not the current direction, it is just the place where user's command is stored
        // it have to get through several checks in order to redirect

        if (key == 'w' || key == 'W' || keyCode == UP){
            this.next_direction = "up";
        }
        else if (key == 'a' || key == 'A' || keyCode == LEFT) {
            this.next_direction = "left";
        }
        else if (key == 's' || key == 'S'|| keyCode == DOWN) {
            this.next_direction = "down";
        }
        else if (key == 'd' || key == 'D'|| keyCode == RIGHT) {
            this.next_direction = "right";
        }
    }


    void update(){ // this function is run every game loop
        int moved = -1;
        this.update_grid_position(); // from player's position, caculate position on the grid
        this.update_face_position(); // calculate the player's face position, for checking facing wall
        this.movement(); // update position
        this.redirection(); // check conditions for redirection, then redirect player 


    }

    void init_position(){ // when player die, the position is reset
        player.x = (float)(10*brick_size + brick_size/2); 
        player.y = (float)(17*brick_size + brick_size/2);
    }

    Player(){ // constructor
        super("Player");
    }
    

}