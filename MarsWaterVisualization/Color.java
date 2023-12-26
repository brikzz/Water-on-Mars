
/**
 * Write a description of class Color here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
class Color
{
    int r;
    int g;
    int b;
    
    //setting the varibles to the parameters inputed
    Color(int red, int green, int blue){
        r = red;
        g = green;
        b = blue;
    }
    
    //getting the red value from the pixel
    int getRed(){
        return r;
    }
    
    //getting the green value from the pixel
    int getGreen(){
        return g;
    }
    
    //getting the blue value from the pixel
    int getBlue(){
        return b;
    }
}
