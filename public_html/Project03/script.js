var spriteRadius;
var pipeGap;
var pipeWidth;
var distBetweenPipes;
var pipeSpeed;
var gravity;
var jumpVelocity;
var velocityY;
var spriteX;
var spriteY;
var score;
var highScore;
var gameOver;
var menu;
var pipes;
var lastIndex;
var img;

var setup = function(){

    createCanvas(400,400);

    spriteRadius = 16;
    pipeGap = spriteRadius * 9;
    pipeWidth = 40;
    distBetweenPipes = 400;
    pipeSpeed = 5;

    gravity = 0.7;
    jumpVelocity = gravity * -16;
    velocityY = 0;

    spriteX = width / 2;
    spriteY = height / 2;
    score = 0;
    highScore = 0;

    gameOver = false;
    menu = true;

    pipes = [];
    lastIndex = 2;
    
    img = loadImage("https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Windows_Logo_1995.svg/250px-Windows_Logo_1995.svg.png");

    setupPipes();
};


var pipe = function(x,y) {
    this.x = x;
    this.y = y;
    this.canScore = true;
};

var drawPipes = function(i) {
    fill(0, 170, 0);
    rect(pipes[i].x, 0, pipeWidth, pipes[i].y - pipeGap / 2);
    rect(pipes[i].x, pipes[i].y + pipeGap/2, pipeWidth, height - pipes[i].y + pipeGap/2);
};

var setPipePosition = function(setX, setY, i){
    pipes[i].x = setX;
    pipes[i].y = setY;
    pipes[i].canScore = true;
};

var pipeUpdates = function(i) {
    pipes[i].x -= pipeSpeed;
    if (pipes[i].x + pipeWidth < 0) {
        setPipePosition(pipes[lastIndex++].x + distBetweenPipes, random(80, height - 80),i);
        if (lastIndex === 3) {
            lastIndex = 0;
        }
    }
};

var isColliding = function(birdX, birdY, i){
    var pipeY = pipes[i].y - pipeGap / 2;
    var pipeX = birdX;
    if (dist(pipeX, pipeY, birdX, birdY) <= spriteRadius && (pipeX >= pipes[i].x && pipeX <= pipes[i].x + pipeWidth)){
        return true;
    }
    
    pipeY = pipes[i].y + pipeGap / 2;
    if (dist(pipeX, pipeY, birdX, birdY) <= spriteRadius && (pipeX >= pipes[i].x && pipeX <= pipes[i].x + pipeWidth)) {
        return true;
    }

    if (birdX >= pipes[i].x && birdX <= pipes[i].x + pipeWidth) {
        if (birdY <= pipes[i].y - pipeGap / 2 || birdY >= pipes[i].y + pipeGap / 2) {
            return true;
        }
    }
    
    return false;
};

var centerText = function(string, y) {
    textAlign(CENTER);
    fill(0);
    text(string, width/2, y + 2);
    fill(255);
    text(string, width/2, y);
};

var updateSprite = function(){
    velocityY += gravity;
    spriteY += velocityY;
    translate(spriteX, spriteY);
    var rotation = constrain(velocityY / jumpVelocity * -45, -45, 45);
    rotate(rotation);
    image(img,-spriteRadius*1.5,-spriteRadius*1.5,spriteRadius*3,spriteRadius*3);
    rotate(-rotation);
    translate(-spriteX, -spriteY);
};

var gameUpdates = function(i){
    if (gameOver === false) {
        pipeUpdates(i);
        if (pipes[i].x < spriteX && pipes[i].canScore === true) {
            pipes[i].canScore = false;
            score++;
            if(score > highScore){
                highScore = score;
            }
        }
    }
    drawPipes(i);
    if (isColliding(spriteX,spriteY,i) === true) {
        gameOver = true;
    }
    if (spriteY > height - spriteRadius) {
            gameOver = true;
    }
}; 

var drawText = function (){
    if (menu === true) {
        centerText("Flappy Bird", height / 2);
        textSize(20);
        centerText("Press space to start", height / 2 + 60);
    } 
    else if (gameOver === true) {
        centerText("Game Over", height / 2);
        textSize(20);
        centerText("Score: " + score, height / 2 + 50);
    } else {
        centerText(score, 50);
        textSize(12);
        text("High Score: " + highScore, 350, 20);
    }
};

var setupPipes = function(){
    for (var i = 0; i < 3; i++) {
     pipes.push(new pipe(700 + i * distBetweenPipes, random(80, height - 80)));
    }
};

var draw = function() {
    textSize(40);
    background(0, 200, 255);
    if (!menu) {
        for (var i = 0; i < pipes.length; i++) {
            gameUpdates(i);
        }
        updateSprite();
    }
    drawText();
};

var resetGame = function() {
    gameOver = false;
    spriteY = height / 2 - 100;
    score = 0;
    velocityY = 0;
    lastIndex = 2;
    menu = true; 
    for (var i = 0; i < pipes.length; i++) {
        setPipePosition(450 + i*distBetweenPipes, random(80, height - 80), i);
    }
};

var mouseClicked = function() {
    if (!gameOver) {
        velocityY = jumpVelocity;
    } else if (spriteY > height + spriteRadius) {
        resetGame();
        return;
    }
    if (menu === true
) {
        menu = false;
    }
};

var keyPressed = function() {
    if (keyCode === 32) {
        mouseClicked();
    }
};