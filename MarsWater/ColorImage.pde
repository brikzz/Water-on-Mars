//find altitude map first by nasa and then disperse water in lower altitudes

class ColorImage
{
    //creating a 2d array to represent the original picture
    Color[][] image;
    //have variables for width and height
    int width;
    int height;
    
    ColorImage(int newWidth, int newHeight){
        width = newWidth;
        height = newHeight;
        image = new Color[width][height];
        //having values for the inital picture so it isn't null
        for(int col = 0; col < image.length; col++){
            for(int row = 0; row < image[col].length; row++){
                image[col][row] = new Color(0,0,0);
            }
        }
    }
    
    //get width of the picture and set as the width var
    int getWidth(){
        return width;
    }
    
    //get height of the picture and set as the height var
    int getHeight(){
        return height;
    }
    
    //get the entire color of the pixel
    Color getColor(int x, int y){
        return image[x][y];
    }
    
    //change the color of the pixel to another color
    void setColor(int x, int y, Color c){
        image[x][y] = c;
    }
    
    //make the image contrasted
    //higher factor number == more contrasted
    ColorImage Contrast(double factor){
        //create a new 2D array for the altered picture to go
        ColorImage c = new ColorImage(width, height);
        for(int x = 0; x < image.length; x++){
            for(int y = 0; y < image[x].length; y++){
                //to find the new color values, subtract 128 (256/2) first, to either get a negative number to make the dark colors even darker
                //for lighter colors, the values will still be positive so they will not be pulled into the darkess
                //then multiply that number by the factor: this is where the negative numbers will become even more dark
                //add 128 for the positive numbers to become even brighter
                double red = (image[x][y].getRed() - 128) * factor + 128;
                double green = (image[x][y].getGreen() - 128) * factor + 128;
                double blue = (image[x][y].getBlue() - 128) * factor + 128;
                //setting the pixel to be that final color
                c.setColor (x, y, new Color((int)red, (int)green, (int)blue));
            }
        }
        //returning the final picture contrasted
        return c;
    }
    
    //make the image have edge detection at where the colors contrast according to the tolerance
    ColorImage Edge(double tolerance){
        //create a new 2D array for the altered picture to go
        ColorImage c = new ColorImage(width, height);
        //only goes up to 1 less than the index because the loop checks for the pixel to the right of it
        for(int x = 0; x < width - 1; x++){
            for(int y = 0; y < height; y++){
                //use the color distance value from Color class and 
                //see if the color distance between the pixel and the one next to it is greater than the tolerance parameter
                //if the color distance is greater, it becomes an edge and becomes black
                if(image[x][y].Distance(image[x + 1][y]) > tolerance){
                    c.setColor (x, y, new Color(0, 0, 0));
                }
                //if it doesn't reach the edge standard, the pixel becomes white filler
                else{
                    c.setColor (x, y, new Color(255, 255, 255));
                }
            }
        }
        //returning the final edge detected picture
        return c;
    }
}
    
    
