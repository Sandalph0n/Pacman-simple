
// replaying the game, or player die, the time counter need to be reset
void create_new_controller(){
    controler = new Controler();
    controler.start();
    
}

void open_door(){
    game_map[9][10] = 0;
    game_map[12][10] = 0;
    door_closed = false;
}

void close_door(){
    game_map[9][10] = 1;
    game_map[12][10] = 1;
    door_closed = true;

}


// control ghosts, open/close doors, time counter
class Controler extends Thread{
    String phase = "scatter";
    @Override
    void run(){
        // the time counter
        
        close_door();
        this.phase = "scatter";
        delay(2000);
        open_door();
        delay(3000);
        close_door();
        while(true){
            
            // if there is any ghost that still in the house, then open the door again
            if (((7.5*brick_size < blinky.x && blinky.x < (7.5+4)*brick_size) && (8.5* brick_size < blinky.y && blinky.y <  (8.5 + 3)* brick_size ))||
                ((7.5*brick_size < clyde.x && clyde.x < (7.5+4)*brick_size) && (8.5* brick_size < clyde.y && clyde.y <  (8.5 + 3)* brick_size ))||
                ((7.5*brick_size < inky.x && inky.x < (7.5+4)*brick_size) && (8.5* brick_size < inky.y && inky.y <  (8.5 + 3)* brick_size ))||
                ((7.5*brick_size < pinky.x && pinky.x < (7.5+4)*brick_size) && (8.5* brick_size < pinky.y && pinky.y <  (8.5 + 3)* brick_size ))){
                open_door();
                println("true");
            }
            else {
                close_door();
            }

            // println("thread is running");
            this.phase = "scatter";
            delay(8000 - 400*difficulty);
            this.phase = "chase";
            delay(20000 + 200*difficulty);
        }
        
    }

    void ghost_controller(){ // control the target of each ghost
        if (this.phase == "scatter"){
            blinky.target.x = 21 * brick_size;
            blinky.target.y = 0;

            clyde.target.x = 0;
            clyde.target.y = 23 * brick_size;

            inky.target.x = 21 * brick_size;
            inky.target.y = 23 * brick_size;

            pinky.target.x = 0;
            pinky.target.y = 0;
        }
        else if (this.phase == "chase") {
        
            // blinky
            
            blinky.target.x = player.x;
            blinky.target.y = player.y;
            // pinky

            if (player.current_direction == "left"){
                pinky.target.x = player.x - 4*brick_size;
                pinky.target.y = player.y;
            }
            else if (player.current_direction == "up"){
                pinky.target.x = player.x;
                pinky.target.y = player.y - 4*brick_size;
            }
            else if (player.current_direction == "down"){
                pinky.target.x = player.x ;
                pinky.target.y = player.y + 4*brick_size;;
            
            }

            // inky
            inky.target.x = (float) (player.face_x*2.0 - blinky.x);
            inky.target.y = (float) (player.face_y*2.0 - blinky.y);

            // clyde

            if (dist(clyde.x,clyde.y,player.x,player.y) > 4*brick_size){
                clyde.target.x = player.x;
                clyde.target.y = player.y;
            }
            else{
                clyde.target.x = 0;
                clyde.target.y = 23 * brick_size;
            }
        }
    }
    // check if player is eating point
    void eating_point(){
        for (int i = 0; i < points.size() ; i++ ){
            if (dist(points.get(i).x,points.get(i).y, player.x,player.y) < 20){
                points.remove(i);
                if (points.size() == 0){
                    win = true;
                }
                score += 10;
                return;
            } 
        }
    }

    void check_lose(){
        if (life <= 0){
            lose = true;
            return;
        }
    }


    void check_collision(){ 
        if (dist(blinky.x,blinky.y,player.x,player.y) < brick_size ||
            dist(clyde.x,clyde.y,player.x,player.y) < brick_size  ||
            dist(inky.x,inky.y,player.x,player.y) < brick_size  ||
            dist(pinky.x,pinky.y,player.x,player.y) < brick_size){
            player.init_position();
            life -= 1;
            
            this.check_lose();

            
            blinky.init_position();
            clyde.init_position();
            pinky.init_position();
            inky.init_position();
            game_map[9][10] = 1;
            game_map[12][10] = 1;
            door_closed = true;
            this.interrupt();
            create_new_controller();

        }
        
    }
    
    

    // update method, which is called every game loop
    void update(){
        this.ghost_controller();
        this.check_collision();
        if (player.moving){ // player can only eat point when he/she is moving.
            this.eating_point();    
            
        }    
        


    }

    Controler(){
        super("Controler"); // initialize the parrent class - Thread()
    }
}