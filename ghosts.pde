

class Ghost{
    float speed = 1.8 + ((float)(difficulty))*2/3 ;
    
    float x =  (float)(10*brick_size + brick_size/2); // ghost position
    float y =  (float)(10*brick_size + brick_size/2);

    int grid_x; // ghost position on grid table
    int grid_y;

    PImage current_image; // image of the ghost that displayed on the screen
    PVector target = new PVector(0,0); // the point that ghost want to go to
    
    private String current_direction = "left";
    private String next_direction = "left";
    private int old_grid_x = 0;
    private int old_grid_y = 0;


    String name;

    boolean new_square = true;

    void loading_assets(){
        int img_size = 28;
        if (this.name == "blinky"){
            current_image = loadImage("assets/ghosts/blinky.png");
        }
        if (this.name == "clyde"){
            current_image = loadImage("assets/ghosts/clyde.png");
        }
        if (this.name == "inky"){
            current_image = loadImage("assets/ghosts/inky.png");
        }
        if (this.name == "pinky"){
            current_image = loadImage("assets/ghosts/pinky.png");
        }
        

        current_image.resize(img_size,img_size);
    }

    void find_way(float x1, float y1){
    
        if (!this.new_square){ // if player move to new square, then continue, if not, stop the method 
            return;
        }
        
        StringList available_direction = new StringList(); // initialize available_direction list, with all direction available
        available_direction.append("up");
        available_direction.append("down");
        available_direction.append("left");
        available_direction.append("right");


        StringList d_to_remove = new StringList(); 
        // direction to remove, after checking all the direction which are not available, this list will be used to remove direction from the available_direction list


        // ghost can not go back, so that the back position is not available
        if (current_direction == "left"){
            d_to_remove.append("right");
        }
        if (current_direction == "right"){
            d_to_remove.append("left");
        }
        if (current_direction == "up"){
            d_to_remove.append("down");
        }
        if (current_direction == "down"){
            d_to_remove.append("up");
        }

        
        // check if the grid next to the ghost is a wall, if it is, then ghost can go to that direction
        if (game_map[this.grid_y-1][this.grid_x] == 1){
            d_to_remove.append("up");
        }
        if (game_map[this.grid_y+1][this.grid_x] == 1){
            d_to_remove.append("down");
        }
        if (game_map[this.grid_y][this.grid_x+1] == 1){
            d_to_remove.append("right");
        }
        if (game_map[this.grid_y][this.grid_x-1] == 1){
            d_to_remove.append("left");
        }
        
        // delete all directions that not available
        for (String d : d_to_remove){        
            for(int i = 0; i < available_direction.size(); i ++ ){
                if (available_direction.get(i) == d){
                    available_direction.remove(i);
                }
            }
        }


        // if there is one available direction, go straight
        if (available_direction.size() == 1){
            this.next_direction = available_direction.get(0);
            return;
        }

        // if there is no direction available, then turn 180 degrees
        if (available_direction.size() == 0){
            if (this.current_direction == "left"){
                this.next_direction = "right";
            }
            else if (this.current_direction == "right") {
                this.next_direction = "left";
            }            
            else if (this.current_direction == "up") {
                this.next_direction = "down";
            }            
            else if (this.current_direction == "down") {
                this.next_direction = "up";
            }            
            return;
        }

        float min_path = Float.POSITIVE_INFINITY;
        float next_x = 0, next_y = 0;

        // println(this.x,this.y);
        // calculate min path to the destination
        for (int i = 0; i < available_direction.size(); i++){
            if (available_direction.get(i) == "up"){
                next_y = (float) (this.grid_y - 1)*brick_size + brick_size/2;
                next_x = this.x;
            }
            else if (available_direction.get(i) == "down") {
                next_y = (float) (this.grid_y + 1)*brick_size + brick_size/2;
                next_x = this.x;
            }
            else if (available_direction.get(i) == "left") {
                next_x = (float) (this.grid_x - 1)*brick_size + brick_size/2;
                next_y = this.y;
            }
            else if (available_direction.get(i) == "right") {
                next_x = (float) (this.grid_x + 1)*brick_size + brick_size/2;
                next_y = this.y;
            }
            float current_path = dist(next_x,next_y, x1, y1);
            
            if (current_path < min_path){
                min_path = current_path;
                this.next_direction = available_direction.get(i); // change direction
            }
        }
        
        // println(next_direction);

        this.new_square = false;
        // assign new_square by false, mean every calculation finish

    }

    void redirection(){
        int offset_x = (int)abs(this.x % brick_size - brick_size/2);
        int offset_y = (int)abs(this.y % brick_size - brick_size/2);
        
        // boolean centralization = false;

        if (offset_x > this.speed + this.speed*2/3 || offset_y > this.speed + this.speed*2/3){
            // println("returned");
            return;
        }

        this.find_way(this.target.x,this.target.y); 
        if (this.current_direction == this.next_direction){
            return;
        }

        // centralization 
        this.x = this.grid_x*brick_size + brick_size/2;
        this.y = this.grid_y*brick_size + brick_size/2;        

        // redirection
        this.current_direction = this.next_direction;
        
    }

    void movement(){
        // update position
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
        // println("moved");

    }

    void update_grid_position(){
        // update grid position
        
        this.grid_x = (int)this.x / brick_size;
        this.grid_y = (int)this.y / brick_size;


        // if ghost change grid position, mean it went to another square, then it have to calculate the path again 
        if (this.old_grid_x != this.grid_x || this.old_grid_y != this.grid_y){
            this.new_square = true;
            this.old_grid_x = this.grid_x;
            this.old_grid_y = this.grid_y;
    
        } 

    }

    void update(){
        this.update_grid_position();
        // this.find_way(5000,300);
        this.movement();
        this.redirection();
    }

    void init_position(){// every ghosts have different starting position
        if (this.name == "blinky"){
            this.x =  (float)(9*brick_size + brick_size/2); // ghost position
            this.y =  (float)(10*brick_size + brick_size/2);
        }
        else if (this.name == "clyde") {
            this.x =  (float)(9*brick_size + brick_size/2); // ghost position
            this.y =  (float)(11*brick_size + brick_size/2);
        }
        else if (this.name == "inky") {
            this.x =  (float)(11*brick_size + brick_size/2); // ghost position
            this.y =  (float)(10*brick_size + brick_size/2);
        }
        else if (this.name == "pinky") {
            this.x =  (float)(11*brick_size + brick_size/2); // ghost position
            this.y =  (float)(11*brick_size + brick_size/2);
        }
    }

    Ghost(String name){
        this.name = name;
        this.init_position();

    }
}


