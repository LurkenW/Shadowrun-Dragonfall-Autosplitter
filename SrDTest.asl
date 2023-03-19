state("Dragonfall")
{
    int KBBool: 0x008183BC, 0x0; //Can see if the player is in the Kreuzbasar or in a mission.
    int CCNumber: 0x00189424, 0x0; 
    int LSNumber: 0x009E08E8, 0x10, 0x34C; //Can see loading screen and will remove some load times, and finds transitions
}

init { vars.i = 0;}

/*
CCNumber stands for Character Creation Number, and it tracks wether or not the player 
a) Hasn't entered character creation yet, in which case it's 0, 
b) Is in character creation, in which case it's 1,
c) Has finished character creation, in which case it is 3
*/
/*
LSNumber is for Loading Screen Number. It fluctuates during loadins screens, but remains stable 
during gameplay, so it can be used for splits and removing loads
*/
start
{
    if(current.CCNumber > old.CCNumber && current.CCNumber == 00000003){
        return true;
    }//The timer starts either after character creation,
    if(current.CCNumber == 00000001 && current.LSNumber == 1037){
        return true;
    }//Or upon loading a save
}
/*
Counts how many times a loading screen with a "Continue" button has appeared, and
since that number will be the same over every run, I use it to execute the splits
*/
split 
{
    if(current.LSNumber != old.LSNumber && current.LSNumber == 0 ){
        vars.i = vars.i + 1;
        int counter = vars.i;
        print("i is now " + vars.i);
        switch(counter){
            case 2: //Splits Harlfeld Manor
                return true; 
                break;
            case 3: //Splits Kreuzbasar 1
                return true; 
                break;
            case 4: //Splits Drogenkippe
                return true; 
                break;
            case 5: //Splits Kreuzbasar 2
                return true; 
                break;
            case 8: //Splits False Flag
                return true; 
                break;
            case 9: //Splits Kreuzbasar 3
                return true; 
                break;
            case 11: //Splits Prototype MKVI
                return true; 
                break;
            case 12: //Splits Ambush
                return true; 
                break;
            case 13: //Splits Kreuzbasar 4
                return true; 
                break;
            case 14: //Splits Earwig
                return true; 
                break;
            case 18: //Splits Bloodline
                return true; 
                break;
            case 22: //Splits Kreuzbasar Assault
                return true; 
                break;
            case 24: //Splits Apex Rising
                return true; 
                break;
            case 27: //Splits Return to Harfled
                return true; 
                break;
            case 28: //Splits One Year Later
                return true; 
                break;
        }
    }
}
/*
This doesn't really work yet, but it's also the least important part so I'm dragging my feet
*/
reset 
{
    if(current.CCNumber > old.CCNumber && current.CCNumber == 00000000){
        return true;
    }
}
/*
Like explained before, the LSNumber shifts a lot during loading screens, 
But when the loading is finished, or right before it at least, it will become 1982 or 1508.
If it was 1982 before the loading screen, it will become 1508, and vice versa
There was a bunch of values that acted like this. 
I just picked the smallest one since it'd be easier to remember and work with.
*/
isLoading
{
    if(current.LSNumber == 1982 || current.LSNumber == 1508){ 
        return false;
    }
    else
    {
        return true;
    }
}