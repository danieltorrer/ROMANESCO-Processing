// SLIDER horizontal version 5.c by Stan le Punk





// SliderAdjustable : extends class of class Slider
public class SliderAdjustable extends Slider {
  protected float minNorm = 0 ;
  protected float maxNorm = 1 ;
  // size
  protected PVector sizeMinMax = new PVector() ;
  protected PVector sizeMolMinMax = new PVector() ;
  int widthMinMax = 10 ;
  // pos  
  protected PVector posMinMax = new PVector() ;
  protected PVector newPosMin = new PVector() ;
  protected PVector newPosMax = new PVector() ;
  // color
  protected color adjIn = color(255) ;
  protected color adjOut = color(125) ; ;

  boolean lockedMin, lockedMax, insideMin, insideMax ;
  
  // CLASSIC CONSTRUCTOR
  SliderAdjustable (PVector pos, PVector posMol , PVector size, PVector posText, PFont p) {
    super(pos, posMol, size, posText, p) ;
    this.posMinMax = pos.copy() ;
    this.newPosMin = posMinMax.copy() ;
    this.sizeMinMax = size.copy() ;
    this.sizeMolMinMax = new PVector(widthMinMax, size.y) ;
  }
  
  SliderAdjustable(PVector pos, PVector posMol , PVector size) {
    super(pos, posMol, size) ;
    this.posMinMax = pos.copy() ;
    this.newPosMin = posMinMax.copy() ;
    this.sizeMinMax = size.copy() ;
    this.sizeMolMinMax = new PVector(widthMinMax, size.y) ;
  }
  
  //slider with external molette
  SliderAdjustable(PVector pos, PVector posMol , PVector size, PVector sizeMol, String moletteShapeType) {
    super(pos, posMol, size, sizeMol, moletteShapeType) ;
    this.posMinMax = pos.copy() ;
    this.newPosMin = posMinMax.copy() ;
    this.sizeMinMax = size.copy() ;
    this.sizeMolMinMax = new PVector(widthMinMax, size.y) ;
  }
  // END CLASSIC CONSTRUCTOR
  /////////////////////////

  
  
  
  /////////
  // METHOD
  
  void minMaxSliderUpdate() {
    float newNormSize = maxNorm -minNorm ;
        
    minNormValueOfSlider = minNorm ;
    maxNormValueOfSlider = maxNorm ;
    sizeMinMax = new PVector (size.x *newNormSize, size.y) ;
    
    posMin = new PVector (pos.x +(size.x *minNorm), pos.y) ;
    posMax = new PVector (pos.x -sizeMol.x +(size.x *maxNorm), pos.y +size.y -sizeMol.y) ;
    
    
  }
  
  // update Min and Max value
  // update min value
  void minUpdate() {
    float range = sizeMol.x *1.5 ;
    //
    if (lockedMin()) lockedMin = true ;
    if (!mousePressed) lockedMin = false ; 
    if (lockedMin) {  
      if (size.x >= size.y) {
        // security
        if (newPosMin.x < posMin.x ) newPosMin.x = posMin.x ;
        else if (newPosMin.x > posMax.x -range) newPosMin.x = posMax.x -range ;
        
        newPosMin.x = constrain(mouseX, pos.x, pos.x+size.x -range) ; 
        // norm the value to return to method minMaxSliderUpdate
        minNorm = map(newPosMin.x, posMin.x, posMax.x, minNormValueOfSlider,maxNormValueOfSlider) ;
      } else newPosMin.y = constrain(mouseY -sizeMinMax.y, posMin.y, posMax.y) ; // this line is not reworking
    }
  }
  
  
  // update maxvalue
  void maxUpdate() {
    float range = sizeMol.x *1.5 ;
    //
    if (lockedMax()) lockedMax = true ;
    if (!mousePressed) lockedMax = false ; 
    if (lockedMax) { 
      if (size.x >= size.y) {
        // security
        if (newPosMax.x < posMin.x +range)  newPosMax.x = posMin.x +range ;
        else if (newPosMax.x > posMax.x ) newPosMax.x = posMax.x ;
        
        newPosMax.x = constrain(mouseX -sizeMol.x, pos.x +range, pos.x +size.x -sizeMol.x) ; 
        // norm the value to return to method minMaxSliderUpdate
        maxNorm = map(newPosMax.x, posMin.x, posMax.x, minNormValueOfSlider,maxNormValueOfSlider) ;
      } else newPosMax.y = constrain(mouseY -sizeMinMax.y, posMin.y, posMax.y) ; // this line is not reworking
    }
  }
  
  
  
  
  
  
  
  
  // Display classic
  void minMaxSliderDisplay() {
    if(lockedMin || lockedMax || insideMax || insideMin) fill(adjIn) ; else fill(adjOut) ;
    noStroke() ;
    rect(newPosMin.x, newPosMin.y +sizeMinMax.y *.4, sizeMinMax.x, sizeMinMax.y *.3) ;
  }
  
  // Display advanced
  void minMaxSliderDisplay(color adjIn, color adjOut, color strokeIn, color strokeOut, float thickness) {
    this.adjIn = adjIn ;
    this.adjOut = adjOut ;
    strokeWeight(thickness) ;
    if(lockedMin || lockedMax || insideMax || insideMin) {
      fill(adjIn) ;
      stroke(strokeIn) ;
    } else {
      fill(adjOut) ;
      stroke(strokeOut) ;
    }
    rect(newPosMin.x, newPosMin.y +sizeMinMax.y *.4, sizeMinMax.x, sizeMinMax.y *.3) ;
    noStroke() ;
  }
  
  
  
  
  
  
  // ANNEXE
  // INSIDE
  boolean insideMin() {
    if(insideRect(posMin, sizeMolMinMax)) insideMin = true ; else insideMin = false ;
    return insideMin ;
  }
  
  boolean insideMax() {
    PVector pos = new PVector (posMax.x +(sizeMol.x*.5), posMax.y) ;
    if(insideRect(pos, sizeMolMinMax)) insideMax = true ; else insideMax = false ;
    return insideMax ;
  }
  
  //LOCKED
  boolean lockedMin () {
    if (insideMin && mousePressed) return true ; else return false ;
    //if (insideMin && mousePressed && !lockedMol && !insideMax && !lockedMax) return true ; else return false ;
  }
  
  boolean lockedMax () {
    if (insideMax && mousePressed) return true ; else return false ;
   // if (insideMax && mousePressed && !lockedMol && !insideMin && !lockedMin) return true ; else return false ;
  }
}
// END Extends class SLIDER
///////////////////////////


















////////////////
// CLASS SLIDER
public class Slider {
  protected PVector pos, size, posMol, posText, sizeMol, posMin, posMax ;
  protected PVector newPosMol = new PVector() ;
  protected color sliderColor = color(60) ;
  protected color molIn = color(255) ;
  protected color molOut = color(125) ;
  protected color colorText = color(0) ; ;
  protected boolean lockedMol, insideMol ;
  protected PFont p ;
  protected float minNormValueOfSlider = 0 ;
  protected float maxNormValueOfSlider = 1 ;
  // advance slider
  protected int newValMidi ;
  protected int IDmidi = -2 ;
  protected String moletteShapeType = ("") ;
  
  // CLASSIC CONSTRUCTOR
  //CONSTRUCTOR with title
  public Slider(PVector pos, PVector posMol , PVector size, PVector posText, PFont p) {
    this.pos = pos.copy() ;
    this.posMol = new PVector(pos.x + (posMol.x*size.x), pos.y +(posMol.y*size.y)) ;
    this.size = size.copy() ;
    this.posText = posText ;
    this.p = p ;

    //which molette for slider horizontal or vertical
    if (size.x >= size.y) sizeMol = new PVector (size.y, size.y ) ; else sizeMol = new PVector (size.x, size.x ) ;
    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y ) ;
  }
  
  //CONSTRUCTOR minimum
  public Slider(PVector pos, PVector posMol, PVector size) {
    this.pos = pos.copy() ;
    this.posMol = new PVector(pos.x + (posMol.x*size.x), pos.y +(posMol.y*size.y)) ;
    this.size = size.copy() ;

    //which molette for slider horizontal or vertical
    if (size.x >= size.y) sizeMol = new PVector (size.y, size.y ) ; else sizeMol = new PVector (size.x, size.x ) ;
    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y ) ;
  }
  
  //slider with external molette
  public Slider(PVector pos, PVector posMol , PVector size, PVector sizeMol, String moletteShapeType) {
    this.pos = pos.copy() ;
    this.posMol = new PVector(pos.x + (posMol.x*size.x), pos.y +(posMol.y*size.y)) ;
    this.sizeMol = sizeMol.copy() ;
    this.size = size.copy() ;
    this.moletteShapeType = moletteShapeType ;

    posMin = new PVector (pos.x, pos.y) ;
    posMax = new PVector (pos.x + size.x - sizeMol.x, pos.y + size.y - sizeMol.y) ;
  }
  
  // END CONSTRUCTOR
  
  
  
  
  
  
  
  
  // METHODES
  //SETTING
  void sliderSetting() {
    this.newPosMol = posMol.copy() ;
  }
  

  void sliderSettingMidi(int IDmidi) {
    this.IDmidi = IDmidi ;
  }
  void sliderSettingPos(float normPos) {
    newPosMol.x = size.x *normPos ;
  }
  // END SETTING
  
  
  
  // UPDATE
  // update molette position
  void moletteUpdate() {
    // check if the mouse is in the slider or not
    // security
    if (newPosMol.x < posMin.x ) newPosMol.x = posMin.x ;
    if (newPosMol.x > posMax.x ) newPosMol.x = posMax.x ;
    
    //
    if (lockedMol()) lockedMol = true ;
    if (!mousePressed) lockedMol = false ; 
    if (lockedMol) {  
      if (size.x >= size.y) newPosMol.x = constrain(mouseX -(sizeMol.x *.5), posMin.x, posMax.x) ; else newPosMol.y = constrain(mouseY -(sizeMol.y *.5), posMin.y, posMax.y) ;
    }
  }
  

  
  
  
  
  
  
  // DISPLAY SLIDER
  //Slider display classic
  void sliderDisplay() {
    fill(sliderColor) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
  }
  
  // slider display advanced
  void sliderDisplay(color sliderColor, color sliderStrokeColor, float thickness) {
    this.sliderColor = sliderColor ;
    fill(sliderColor) ;
    stroke(sliderStrokeColor) ;
    strokeWeight(thickness) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    noStroke() ;
  }
  //Slider update with title
  void sliderDisplayText(String s, boolean t) {
    //SLIDER
    fill(sliderColor) ;
    rect(pos.x, pos.y, size.x, size.y ) ;
    if (t) {
      fill(colorText) ;
      textFont (p) ;
      textSize (posText.z) ;
      text(s, posText.x, posText.y ) ;
    }
  }
  
  
  // DISPLAY MOLETTE
  //display molette
  void moletteDisplay() {
    if(lockedMol || insideMol) fill(molIn); else fill(molOut ) ;
    if(moletteShapeType.equals("ELLIPSE")) ellipse(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y) ; else  rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
  }
  
  // display molette advanced
  void moletteDisplay(color molIn, color molOut, color strokeIn, color strokeOut, float thickness) {
    this.molIn = molIn ;
    this.molOut = molOut ;

    strokeWeight(thickness) ;
    if(lockedMol || insideMol) {
      fill(molIn);
      stroke(strokeIn) ;
    } else {
      fill(molOut ) ;
      stroke(strokeOut) ;
    }
    if(moletteShapeType.equals("ELLIPSE") ) {
      ellipse(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
    } else if(moletteShapeType.equals("RECT")) {
      rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
    } else rect(newPosMol.x, newPosMol.y, sizeMol.x , sizeMol.y ) ;
    
    noStroke() ;
  }


  

  
  
  
  
  
  

  //ANNEXE VOID
  // return the position of the molette between 0 and 1
  float getValue() {
    float value ;
    if (size.x >= size.y) value = map (newPosMol.x, posMin.x, posMax.x, minNormValueOfSlider,maxNormValueOfSlider) ; 
                          else value = map (newPosMol.y, posMin.y, posMax.y, minNormValueOfSlider,maxNormValueOfSlider) ;
    return value ;
  }
  
  
  // check if the mouse is inside the molette or not
  //rect
  boolean insideSlider() { 
    if(insideRect(pos, size)) insideMol = true ; else insideMol = false ;
    return insideMol ;
  }
  
  
  boolean insideMolette() { 
    if(insideRect(newPosMol, sizeMol)) insideMol = true ; else insideMol = false ;
    return insideMol ;
  }
  

  //ellipse
  boolean insideEllipse() {
    float disX = pos.x -mouseX ; 
    float disY = pos.y -mouseY ; 
    if (sqrt(sq(disX) + sq(disY)) < size.x *.5) insideMol = true ; else insideMol = false ;
    return insideMol ;
  }
  
  
  
  //locked
  boolean lockedMol () {
    if (insideMol && mousePressed ) return true ; else return false ;
  }
  
  // END CLASSIC METHOD
  /////////////////////
  
 
 
 
 
 
 
 
 
 
 ///////////////////
 // ADVANCED METHOD
 // update position from midi controller
  void updateMidi(int val) {
    //update the Midi position only if the Midi Button move
    if (newValMidi != val) { 
      newValMidi = val ; 
      newPosMol.x = map(val, 1, 127, posMin.x, posMax.x) ;
      // posX = newValMidi ; 
    }
  }

  
  //////
  //VOID
  void load(int load) {
    newPosMol.x = load ;
    /*
    float lh = float(longueurSlider) ;
    spos = xpos + (loadX / (100.0 + ( (11.0/lh)*rapportChargement) ) * longueurSlider);
    */
  }
  
  
  
  // give the ID from the controller Midi
  void selectIDmidi(int num) { IDmidi = num ; }
  
  
  
  
  ////////
  //RETURN
  //give the IDmidi 
  int IDmidi() { return IDmidi ; }
}
