import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import java.io.File;

/** 
* This PhotoshopDriver is where you will write the commands to actually load,
* edit, and save your images. It contains a couple of utility methods that will be 
* used to handle the file reading and writing, which you shouldn't change, but the
* main method is yours to use however you need.
*/
    void setup(){
        /**
         * An example of how you might write the code for loading an image, applying a filter, 
         * and saving it to a new filename.
         * Always save your resulting image to a new filename, so you don't overwrite the original!
         * Note I am saving to a file with the ".jpg" filetype.
         * This will work for most photos, but you may get some color error from the compression process.
         * If you want a higher-quality export, give your filename the ".png" filetype instead.
         */
        
        ColorImage photo = loadImage("marscyl2.png");
        //ColorImage bgphoto = loadImage("lego.jpg");
        
        
        ColorImage contrastPhoto = photo.Contrast(2);
        saveImage("contrast.jpg", contrastPhoto);
        ColorImage edgePhoto = photo.Edge(50);
        saveImage("edge.jpg", edgePhoto);
        /*ColorImage greenscreenPhoto = photo.Greenscreen(150, new Color(255, 255, 255), bgphoto);
        saveImage("greenscreen.jpg", greenscreenPhoto);
        ColorImage slidePhoto = photo.Slide(300);
        saveImage("slide.jpg", slidePhoto);
        ColorImage lslidePhoto = photo.lSlide(300);
        saveImage("lslide.jpg", lslidePhoto);
        ColorImage flipPhoto = photo.Flip();
        saveImage("flip.jpg", flipPhoto);
        ColorImage invertPhoto = photo.Invert();
        saveImage("invert.jpg", invertPhoto);*/
    }

    /**
     * Takes an image filename (e.g. "photo.jpg") and converts it to a ColorImage.
     */
    public static ColorImage loadImage(String filename){
        BufferedImage image = null;
        try {
            image = ImageIO.read(new File(filename));
        } catch (Exception e) {
            System.out.println("Problem loading image: " + filename);
            System.out.println(e);
            System.exit(1);
        }
        if(image == null){
            System.out.println("null image");
        }
        ColorImage c = new ColorImage(image.getWidth(), image.getHeight());
        for (int x=0; x<image.getWidth(); x++){
            for (int y=0; y<image.getHeight(); y++){
                c.setColor(x,y,fromARGB(image.getRGB(x,y)));
            }
        }
        return c;
    }
    
    /** 
     * Converts the R,G,B values of a Color to ARGB format, which is required by the BufferedImage
     * file writing class.
     */
    public static int toARGB(Color c) {
        int ir = Math.min(Math.max(c.getRed(),0),255);
        int ig = Math.min(Math.max(c.getGreen(),0),255);
        int ib = Math.min(Math.max(c.getBlue(),0),255);
        return (ir << 16) | (ig << 8) | (ib << 0);
    }
    
    /** 
     * Takes a packed int in ARGB format, which we get from the BufferedImage file writing class,
     * and turns it into a Color object by separating out its R,G,B values.
     */
    public static Color fromARGB(int packed){
        int r = ((packed >> 16) & 255);
        int g = ((packed >> 8) & 255);
        int b = (packed & 255);
        return new Color(r,g,b);
    }
    
    /**
     * Reads in each pixel from a ColorImage, and then writes the image out to a file.
     * Supports PNG and JPG file types.
     */
    public static void saveImage(String filename, ColorImage image){
        try {
            
            BufferedImage bi = new BufferedImage(image.getWidth(), image.getHeight(), BufferedImage.TYPE_INT_RGB);
            for(int x = 0; x < image.getWidth(); x++) {
                for (int y = 0; y < image.getHeight(); y++) {
                    bi.setRGB(x,y,toARGB(image.getColor(x,y)));
                }
            }
            if(filename.substring(filename.length()-4).equalsIgnoreCase(".png")){
                ImageIO.write(bi, "PNG", new File(filename));
            }
            else if (filename.substring(filename.length()-4).equalsIgnoreCase(".jpg")){
                ImageIO.write(bi, "JPG", new File(filename));
            }
            else {
                System.out.println("Unsupported file type - please save your image as either a .jpg or .png file");
            }
            
        } catch(Exception e) {
            System.out.println("Problem saving image: " + filename);
            System.out.println(e);
            System.exit(1);
        }
    }

    /**
     * Simpler version of the saveImage method for testing. Doesn't require integration with ColorImage, just writes
     * a gradient of colors out to an image to make sure the BufferedImage, ImageIO, and File libraries are working
     * as expected.
     */
    public static void saveTestImage(){
        try {
            
               BufferedImage biTest = new BufferedImage(250,200,BufferedImage.TYPE_INT_RGB);
               for(int x = 0; x < 250; x++){
                   for(int y = 0; y < 200; y++){
                       biTest.setRGB(x,y,(x << 16) | (y << 8) | (0 << 0));
                    }
                }
                ImageIO.write(biTest, "PNG", new File("testGradient.png"));
                
        } catch(Exception e) {
            System.out.println("Problem saving test gradient image");
            System.out.println(e);
            System.exit(1);
        }
    }
