/** 
Tab: A_core_scene
Core_scene 1.4.1
*/


/**
OPENING
*/
boolean open_controller = true ;
boolean open_prescene = true ;
int count_to_open_controller = 0 ;
int time_int_second_to_open_controller = 12  ; // the scene run at 15 frame / second.

void opening() {
  if (open_controller || open_prescene) {
    if (OPEN_APP && open_controller) {
      message_opening() ;
    }

    if (OPEN_APP) { 
      if (open_prescene)      {
        launch(sketchPath("")+"PreScene_"+version+".app") ; 
        open_prescene = false ; 
      } else {
        count_to_open_controller += 1 ;
      }

      int time_factor_to_open = 15 ;
      if (open_controller && count_to_open_controller > (time_int_second_to_open_controller *time_factor_to_open) ) { 
        launch(sketchPath("")+"Controleur_"+version+".app") ; 
        open_controller = false ; 
      } 
    }
  }
}


void message_opening() {
  fill(blanc) ;
  stroke(blanc) ;
  textSize(48) ;
  text("Romanesco Unu release" + version, abs(sin(frameCount * .05)) *width, height/2 ) ;
}
/**
End Opening
*/

















/**
GRAPHIC CONFIGURATION 
*/

//SCREEN CHOICE and FULLSCREEN
/*
GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] screenDevice = ge.getScreenDevices();
*/
//FULLSCREEN
// boolean undecorated = false ;

boolean displaySizeByImage ;
String displayMode = ("") ;
//ID of the screen
int whichScreen ;
//size of the Scene
int sceneWidth, sceneHeight ;
//to load the .csv who give the graphic configuration for the Scene
String pathScenePropertySetting = "preferences/sceneProperty.csv" ;
TableRow row ;
Table configurationScene;

//SETUP
void display_setup(int speed) {
  background(0) ;
  frameRate(speed) ; 
  noCursor () ;
  colorMode(HSB, HSBmode.r, HSBmode.g, HSBmode.b, HSBmode.a) ;
  /**
  // The fullscreen option from the external file is disable, because the fullScreen() method cannot be choice in second time, that be must the first line of programm
  // So I disable the line in loadPropertyScene() in display_setup()
  */
  loadPropertyScene() ; 
  
  background_setup() ;
  background_shader_setup() ;
}




//load property from table
void loadPropertyScene() {
  configurationScene = loadTable(sketchPath("") + pathScenePropertySetting, "header");
  row = configurationScene.getRow(0);
  /**
  //The fullscreen option from the external file is disable, because the fullScreen() method cannot be choice in second time, that be must the first line of programm
  // So I disable the line in oadPropertyScene()
  // if(!TEST_ROMANESCO) if (row.getString("fullscreen").equals("TRUE") || row.getString("fullscreen").equals("true")) FULL_SCREEN = true ; else FULL_SCREEN = false ;
  */
  //display on specific screen
  whichScreen = row.getInt("whichScreen") ;

  //size of the scene when it's not fullscreen
  sceneWidth = row.getInt("width") ;
  sceneHeight =  row.getInt("height")  ;
  //SYPHON
  if(row.getString("miroir").equals("TRUE") || row.getString("miroir").equals("true")) {
    miroir_on_off = true ; 
  } else {
    miroir_on_off = false ;
  }
}
// end load property



void size_scene() {
  /*
  if (FULL_SCREEN && !check_size) { 
    // deprecated by fullScreen() method of Processing
    set_fullScreen(whichScreen, true) ;
    check_size = true ; 
  } else
  */ 
  if (!FULL_SCREEN && !check_size || (width != sceneWidth && height != sceneHeight)) {
    catch_display_position() ;
    check_size = true ;
    int which = whichScreen ;
    if(which > screenDevice.length) which = 1 ;
    int pos_x = display_size_x[which -1] - ((display_size_x[which -1]/2) +(sceneWidth /2)) ;
    int pos_y = display_size_y[which -1] - ((display_size_y[which -1]/2) +(sceneHeight /2)) ;
    set_display_sketch (pos_x, pos_y, sceneWidth, sceneHeight, which, true) ;
  }
}
// END size scene




// METHOD TO DISPLAY
////////////////////
GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] screenDevice = ge.getScreenDevices();



// window method
void set_display_sketch(int pos_x, int pos_y, int size_x, int size_y, int which_screen, boolean change_setting) {
  if(change_setting) {
    catch_display_position() ; 
    set_display(pos_x, pos_y, size_x, size_y, which_screen) ;
  }
}

// main method to display
void set_display(int pos_x, int pos_y, int size_x, int size_y, int which_screen) {
  int which = which_screen - 1 ;
  if(which < 0 ) which = 0 ;
  if(which < screenDevice.length ) {
    println("Surface set location",pos_x +display_pos_x[which],pos_y +display_pos_y[which]) ;
    surface.setLocation(pos_x +display_pos_x[which],pos_y +display_pos_y[which]) ;
    // surface.setLocation(20,20) ;
    surface.setSize(size_x,size_y) ;
    // surface.setLocation(pos_x +display_pos_x[which],pos_y +display_pos_y[which]) ;

  } else {
    println("You try to use an unvailable display") ;
    surface.setSize(size_x,size_y) ;
    surface.setLocation(20,20) ;
  }
}


// catch info about the different display
int [] display_pos_x, display_pos_y ;
int [] display_size_x, display_size_y ;
int display_num ;
void catch_display_position() {
  display_num = screenDevice.length ;
  display_pos_x = new int [display_num] ;
  display_pos_y = new int [display_num] ;
  display_size_x = new int [display_num] ;
  display_size_y = new int [display_num] ;
  
  for(int i = 0 ; i < display_num ; i++) {
    GraphicsDevice gd = screenDevice[i];
    GraphicsConfiguration[] graphicsConfigurationOfThisDevice = gd.getConfigurations();
    // loop with a single element the screen selected above
    for (int j = 0 ; j < graphicsConfigurationOfThisDevice.length ; j++ ) {
      Rectangle gcBounds = graphicsConfigurationOfThisDevice[j].getBounds() ;
      display_pos_x[i] = gcBounds.x ;
      display_pos_y[i] = gcBounds.y ;
      display_size_x[i] = gd.getDisplayMode().getWidth();
      display_size_y[i] = gd.getDisplayMode().getHeight();
    }
  }
}



// Deprecated by fullScreen() method of Processing
// fullscreen method
/*
void set_fullScreen(int which_screen, boolean change_setting) {
  if(change_setting ) {
    catch_display_position() ;
    int which = which_screen -1 ;
    if(which < screenDevice.length) {
      int size_x = display_size_x[which] ;
      int size_y = display_size_y[which] ;
      set_display(0, 0, size_x, size_y, which_screen) ;
    } else {
      int size_x = display_size_x[0] ;
      int size_y = display_size_y[0] ;
      set_display(0, 0, size_x, size_y, 0) ;
      println("You try to use an unvailable display") ;
    }
  }
}
*/

/**
END GRAPHIC CONFIGURATION
*/



































//CURSOR, PEN, LEAP MOTION
///////////////////////////

void cursorDraw() {
  //mousePressed
  if(ORDER_ONE || ORDER_TWO || ORDER_THREE) ORDER = true ; else ORDER = false ;  
  
  //next previous
  if (nextPrevious) nextPreviousInt = 1 ; else nextPreviousInt = 0 ;
}
///////////////
//END CURSOR, PEN, 




/**
We use this void to re-init the temp value of SHORT EVENT from the Préscène, because this one is not refresh at the same framerate than the Scene.
Prescene have a 15 fps and the 60 fps, so the resulte when you press a key on the Prescene, this one is only refresh on the Scène after 4 frames.
*/
void init_value_temp_prescene() {
  // to change the value of the keyboard "a" to "z" to false
  for(int i = 1 ; i < 27 ;i++) {
    if(valueTempPrescene[i].equals("1")) {
    	valueTempPrescene[i] = "0" ;
    }
  }
  // to change the value of the special touch of keyboard like ENTER, BACKSPACE to false
  for(int i = 30 ; i < 38 ;i++) {
    if(valueTempPrescene[i].equals("1")) valueTempPrescene[i] = "0" ;
  }
  // to change the value of the special num touch of keyboard from '0' to '9'
  for(int i = 51 ; i < 61 ;i++) {
    if(valueTempPrescene[i].equals("1")) valueTempPrescene[i] = "0" ;
  }
}