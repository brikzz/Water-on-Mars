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
    
    //gets the color distance (how different the colors are)
    double Distance(Color c){
        double dist;
        //inputing the formula with Math methods
        //using abs so the positive value of the difference will be derived 
        //but just as i am writing this i realized that it is a square so the abs is not needed
        dist = Math.sqrt(Math.pow(Math.abs(c.getRed() - this.getRed()), 2) + 
                         Math.pow(Math.abs(c.getGreen() - this.getGreen()), 2) +
                         Math.pow(Math.abs(c.getBlue() - this.getBlue()), 2));
        //going to use the return value for edge detection and greenscreen
        return dist;
    }
}
