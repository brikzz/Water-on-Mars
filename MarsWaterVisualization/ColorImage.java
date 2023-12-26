
/**
 * Write a description of class ColorImage here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
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
    
    ColorImage Water(double gel){
        ColorImage c = new ColorImage(width, height);
        //background math: 31 km in total / 255 color = 0.1215686 km per color
        //ex: (0,0,0) = 0km    (1,1,1) = 0.1215686 km
        //gel range: 600-2700 meters (0.6km - 2.7km)
        //changed starting int color to 45 because from previous trials, the subtraction from GEL was at 46 so making it 45 would help speed up the process
        int color = 45;
        double totalSize = width*height;
        double totalWater = 0;
        double finalWater = 0;
        //making sure that it only runs when there is water left to be dispersed
        while(gel > 0){
            //checks every pixel every round of color
            for(int x = 0; x < image.length; x++){
                for(int y = 0; y < image[x].length; y++){
                    //setting the inital color values at that specific xy pixel
                    int red = image[x][y].getRed();
                    int green = image[x][y].getGreen();
                    int blue = image[x][y].getBlue();
                    //since the colors are gray, the RGB color values are the same so i just used red as the checking value
                    //checks if the color is equal to the lowest color on the image (lowest point on mars)
                    //also adds more water to the colors that already have water
                    if(red <= color){
                        //if the color is equal to the current checking color var, make the pixel blue to represent water
                        //the colors are automatically gradientified because of the R and G color values determining the darkness of the blue
                        blue = 255;
                        //since the map of Mars is stretched out therefore making the pixels not proportional to the actual area in which it takes up on mars
                        //so we have to subtract the height of water(0.1215686km) divided by the pixel area to get the exact amount of water in that one pixel and color level 
                        //because otherwise it would just be subtracting the amount by assuming the whole surface of Mars is covered which is not the case
                        gel = gel - 0.1215686/(width*height);
                    }
                    //setting the pixel to be that final color
                    //subtracting 40, 40, 20 to make the blue more prominent
                    c.setColor (x, y, new Color((int)red - 40 , (int)green - 40, (int)blue - 20));
                    
                }
            }
            //keep on increasing the color that is checked until it gets to white (but also 
            if(color < 255){
                color++;
            }
        }
        //getting the amount of surface blue
        for(int x = 0; x < image.length; x++){
            for(int y = 0; y < image[x].length; y++){
                if((c.getColor(x,y)).getBlue() == 235){
                    totalWater++;
                }
            }
        }
        //percentage of water on mars
        System.out.println("Water takes up " + ((totalWater/totalSize) * 100) + "% of Mars's surface");
        return c;
    }
}

