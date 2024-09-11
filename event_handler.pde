void mousePressed(){
    if (mouseButton != LEFT){
        return; // if button clicked is not left, then stop the function
    }

    if (game_start){
        // mouse_game_event();
        
    }
    else{
        mouse_menu_event();
    }


}


void keyPressed(){
    player.keyboard_handler();



    if (win || lose){
        if (key != ' '){
            return;
        }
        lose = false;
        win = false;
        game_start = false;
        // init player, ghosts
        player.init_position();
        blinky.init_position();
        inky.init_position();
        clyde.init_position();
        pinky.init_position();
        // close the door
        close_door();
        // create new controler
        controler.interrupt();
        create_new_controller();
        // refresh life
        life = 3;        
        // refresh points
        score = 0;
        while (points.size() > 0){
            points.remove(0);
        }

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


    }


}



void mouse_menu_event(){
    // difficulty decrease button
    if ((width/2 - 100 <= mouseX && mouseX <= width/2 - 100 + 60)&&(brick_size*10-90 <= mouseY && mouseY <= brick_size*10-90 + 60)){
        difficulty--;
        if (difficulty <1){
            difficulty = 1;
        }
    }

    // difficulty increase button
    if ((width/2 + 40  <= mouseX && mouseX <= width/2 + 40 + 60)&&(brick_size*10-90 <= mouseY && mouseY <= brick_size*10-90 + 60)){
        difficulty++;
        if (difficulty > 3){
            difficulty = 3;
        }
    }

    // start button 
    if ((width/2 - 80  <= mouseX && mouseX <= width/2 - 80 + 160)&&(brick_size*10+10 <= mouseY && mouseY <= brick_size*10+10 + 70)){
        game_start = true;   
        // thread("call_update_animation");

        blinky.speed =  1.5 + ((float)(difficulty))*0.5;
        clyde.speed =  1.5 + ((float)(difficulty))*0.5;
        inky.speed =  1.5 + ((float)(difficulty))*0.5;
        pinky.speed =  1.5 + ((float)(difficulty))*0.5;

        try{
            player.start();}
        catch (Exception e) {
        }
        
        create_new_controller();
    }
}





// void mouse_game_event(){



// }

