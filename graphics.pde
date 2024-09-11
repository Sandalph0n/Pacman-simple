void menu_graphic(){ // start menu graphic
    // gray square above the map\
    noStroke();
    fill(50,50,50,200);
    rect(0,0,width,height);
    // black square in the middle
    fill(0);
    rect(width /2-150, brick_size*10-150, 300, 300, 10, 10, 10, 10);
    // difficulty text
    textFont(font, 50);
    fill(#FFFF09);
    textAlign(LEFT,BASELINE);
    
    text("Difficulty",width /2-140, brick_size*10-120);
    // difficulty adjust
    stroke(#007AED);
    noFill();
    strokeWeight(2);
    rect(width/2 -30, brick_size*10-100, 60, 80, 10, 10, 10, 10);
    
    textFont(font, 100);
    textAlign(CENTER,CENTER);
    text(str(difficulty),width/2+5, brick_size*10-58);
    
    // adjust difficulty button
    if ((width/2 - 100 <= mouseX && mouseX <= width/2 - 100 + 60)&&(brick_size*10-90 <= mouseY && mouseY <= brick_size*10-90 + 60)){
        fill(50,50,50);
        button_hover = true;    
    }
    else{
        fill(0);
    }
    rect(width/2 - 100, brick_size*10-90, 60, 60, 10, 10, 10, 10);
    noStroke();
    fill(#FFFF09);
    triangle(width/2 - 100 - 10 + 60,
            brick_size*10-90 + 10, 
            width/2 - 100 - 10 + 60, 
            brick_size*10-90 + 10 + 40, 
            width/2 - 100 - 45 + 60, 
            brick_size*10-90 + 30);

    
    stroke(#007AED);
    if ((width/2 + 40  <= mouseX && mouseX <= width/2 + 40 + 60)&&(brick_size*10-90 <= mouseY && mouseY <= brick_size*10-90 + 60)){
        fill(50,50,50);
        button_hover = true;    
    }
    else{
        fill(0);
    }
    rect(width/2 + 40 , brick_size*10-90, 60, 60, 10, 10, 10, 10);
    noStroke();
    fill(#FFFF09);
    triangle(width/2 + 40 + 10,
            brick_size*10-90 + 10,
            width/2 + 40 + 10,
            brick_size*10-90 + 50,
            width/2 + 40 + 10 + 35,
            brick_size*10-90 + 30);

    noFill();
    stroke(#FFFF09);


    // draw start button
    if ((width/2 - 80  <= mouseX && mouseX <= width/2 - 80 + 160)&&(brick_size*10+10 <= mouseY && mouseY <= brick_size*10+10 + 70)){
        fill(50,50,50);
        button_hover = true;    
    }
    else{
        fill(0);
    }
    rect(width/2 - 80, brick_size*10+10, 160, 70, 10, 10, 10, 10);
    fill(#FFFF09);
    textFont(font, 70);
    textAlign(CENTER, TOP);
    text("START", width/2 ,brick_size*10+23 + 10);
}

void game_graphics(){ // ingame graphic
    if (win || lose){ // if win or lose, then stop drawing stuff below
        return;
    }
    
    for(PVector current_point: points){ // draw every points in the map
        fill(#FFFF09);
        strokeWeight(1);
        stroke(0);
        circle(current_point.x,current_point.y,8);
    }    


    imageMode(CENTER);  // change image align to center 
    

    if (door_closed){ // draw the door
        rect(10*brick_size,9*brick_size + brick_size/3, brick_size,brick_size/3); 
        rect(10*brick_size,12*brick_size + brick_size/3, brick_size,brick_size/3); 

    }
    

    // println(player.x, player.y);
    image(player.current_image,player.x, player.y);
    image(blinky.current_image,blinky.x,blinky.y);
    image(clyde.current_image,clyde.x,clyde.y);
    image(inky.current_image,inky.x,inky.y);
    image(pinky.current_image,pinky.x,pinky.y);

    // lifes
    textFont(font, 80);
    text("Lifes: " + str(life),21*brick_size+8,brick_size*7);
    

}


void alway_on_display(){ // every thing that alway on screen/work is coded here :)
    // text, credits, etc..
    
    textAlign(LEFT,BOTTOM);
    textFont(font, 100);
    fill(#FFFF09);
    

    text("PACMAN",21*brick_size+8,brick_size*2-10);
    
    textFont(font, 80);
    text("SCORES:",21*brick_size+8,brick_size*4);
    text(str(score),21*brick_size+8,brick_size*5);

    textFont(font, 50);
    stroke(#FFFF09);
    strokeWeight(3);
    line(21*brick_size,brick_size*9+3,width,brick_size*9+3);
    text("Author: ",21*brick_size+8,brick_size*10);
    text("Khoi Nguyen Vu ",21*brick_size+8,brick_size*10 + 40);
    text("Discord: ",21*brick_size+8,brick_size*13 );
    text("aoikanariya ",21*brick_size+8,brick_size*13 + 40);
    text("If there is any ",21*brick_size+8,brick_size*16);
    text("bug, please ",21*brick_size+8,brick_size*16 +40);
    text("contact me on ",21*brick_size+8,brick_size*16 + 80);
    text("discord!! ",21*brick_size+8,brick_size*16 + 120);
    text("Thank you",21*brick_size+8,brick_size*16 + 160);
    text("Enjoy :>",21*brick_size+8,brick_size*16 + 250);


    // if cursor is hovering on buttons, then change it to hand
    if (button_hover){
        cursor(HAND);

    }
    else {
        cursor(ARROW);

    }

}

void game_lose(){ // draw lose screen
    noStroke();
    fill(50,50,50,200);
    rect(0,0,width,height);
    textAlign(CENTER,CENTER);
    textFont(font, 400);
    fill(#FFFF09);

    text("LOSE", 11*brick_size,height/2);
    textFont(font, 60);
    text("Press SPACE to play again", 11*brick_size,height/2 + brick_size*3);

}

void game_win(){ // draw win screen
    noStroke();
    fill(50,50,50,200);
    rect(0,0,width,height);
    textAlign(CENTER,CENTER);
    textFont(font, 400);
    fill(#FFFF09);

    text("WIN", 11*brick_size,height/2);
    textFont(font, 60);
    text("Press SPACE to play again", 11*brick_size,height/2 + brick_size*3);



}