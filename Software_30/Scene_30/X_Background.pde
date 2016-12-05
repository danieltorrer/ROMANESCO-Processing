
/**
ROMANESCO BACKGROUND 1.0.1

*/
Vec4 colorBackground, colorBackgroundRef, colorBackgroundPrescene;


void background_setup() {
  colorBackgroundRef = Vec4() ;
  colorBackground = Vec4() ;
  colorBackgroundPrescene = Vec4(0,0,20,g.colorModeA) ;
}


void background_romanesco() {
  // in preview mode the background is always on, to remove the trace effect
  if(!FULL_RENDERING) { 
    onOffBackground = false ;
    colorBackground = colorBackgroundPrescene.copy() ;
    background_norm(colorBackground.normalize(Vec4(g.colorModeX,g.colorModeY,g.colorModeZ,g.colorModeA ))) ;
  } else {
    if(onOffBackground) {
      if(whichShader == 0) {
        // check if the color model is changed after the shader used
        if(g.colorMode != 3 || g.colorModeX != 360 || g.colorModeY != 100 || g.colorModeZ !=100 || g.colorModeA !=100) colorMode(HSB,360,100,100,100) ;
        // choice the rendering color palette for the classic background
        if(FULL_RENDERING) {
          // check if the slider background are move, if it's true update the color background
          if(!compare(colorBackgroundRef,update_background())) {
            colorBackground.set(update_background()) ;
          } else {
            colorBackgroundRef.set(update_background()) ;
          }
          background_norm(colorBackground.normalize(Vec4(g.colorModeX,g.colorModeY,g.colorModeZ,g.colorModeA))) ;
        }
        background_norm(colorBackground.normalize(Vec4(g.colorModeX,g.colorModeY,g.colorModeZ,g.colorModeA))) ;
      } else {
        background_shader_draw(whichShader) ;
      }
    }
  }
}






// ANNEXE VOID BACKGROUND
Vec4 update_background() {
  //to smooth the curve of transparency background
  // HSB
  float hue_bg =         map(valueSlider[0][0],0,MAX_VALUE_SLIDER,0,HSBmode.r) ;
  float saturation_bg =  map(valueSlider[0][1],0,MAX_VALUE_SLIDER,0,HSBmode.g) ;
  float brigthness_bg =  map(valueSlider[0][2],0,MAX_VALUE_SLIDER,0,HSBmode.b) ;
  // ALPHA
  float factorSmooth = 2.5 ;
  float nx = norm(valueSlider[0][3], 0.0 , MAX_VALUE_SLIDER) ;
  float alpha = pow (nx, factorSmooth);
  alpha = map(alpha, 0, 1, 0.8, HSBmode.a) ;
  return Vec4(hue_bg,saturation_bg,brigthness_bg,alpha) ;
}







// BACKGROUND SHADER
PShader blurOne, blurTwo, cellular, damierEllipse, heart, necklace,  psy, sinLight, snow ;
//PShader bizarre, water, psyTwo, psyThree ;

void background_shader_setup() {
  String pathShaderBG = preference_path +"shader/shader_bg/" ;

  blurOne = loadShader(pathShaderBG+"blurOneFrag.glsl") ;
  blurTwo = loadShader(pathShaderBG+"blurTwoFrag.glsl") ;
  cellular = loadShader(pathShaderBG+"cellularFrag.glsl") ;
  damierEllipse = loadShader(pathShaderBG+"damierEllipseFrag.glsl") ;
  heart = loadShader(pathShaderBG+"heartFrag.glsl") ;
  necklace = loadShader(pathShaderBG+"necklaceFrag.glsl") ;
  psy = loadShader(pathShaderBG+"psyFrag.glsl") ;
  sinLight = loadShader(pathShaderBG+"sinLightFrag.glsl") ;
  snow = loadShader(pathShaderBG+"snowFrag.glsl") ;

  /*
  bizarre = loadShader(pathShaderBG+"bizarreFrag.glsl") ; // work bad
  water = loadShader(pathShaderBG+"waterFrag.glsl") ; // problem
  psyTwo = loadShader(pathShaderBG+"psyTwoFrag.glsl") ; // problem
  psyThree = loadShader(pathShaderBG+"psyThreeFrag.glsl") ; // problem
  */

}



void background_shader_draw(int whichOne) {
  if(TEST_ROMANESCO || FULL_RENDERING) {
    PVector posBGshader = new PVector(0,0) ;
    PVector sizeBGshader = new PVector(width,height, height) ; 
    fill(0) ; noStroke() ;

    if     (whichOne ==1) rectangle(posBGshader, sizeBGshader, blurOne ) ;
    else if(whichOne ==2) rectangle(posBGshader, sizeBGshader, blurTwo ) ;
    else if(whichOne ==3) rectangle(posBGshader, sizeBGshader, cellular) ;
    else if(whichOne ==4) rectangle(posBGshader, sizeBGshader, damierEllipse) ;
    else if(whichOne ==5) rectangle(posBGshader, sizeBGshader, heart) ;
    else if(whichOne ==6) rectangle(posBGshader, sizeBGshader, necklace) ;
    else if(whichOne ==7) rectangle(posBGshader, sizeBGshader, psy) ;
    else if(whichOne ==8) rectangle(posBGshader, sizeBGshader, snow ) ;
    else if(whichOne ==9) rectangle(posBGshader, sizeBGshader, sinLight ) ;
    
    
    //rectangle(posBGshader, sizeBGshader, bizarre) ;  // work bad
    //rectangle(posBGshader, sizeBGshader, water) ; // problem
    //rectangle(posBGshader, sizeBGshader, psyTwo) ; // problem
    //rectangle(posBGshader, sizeBGshader, psyThree) ; // problem
  }  else if (whichOne != 0  ) {
    background_norm(1) ;
    int sizeText = 14 ;
    textSize(sizeText) ;
    fill(orange) ; noStroke() ;
    text("Shader is ON", sizeText, height/3) ;
  } 

}

float shaderMouseX, shaderMouseY ;
void rectangle(PVector pos, PVector size, PShader s) {
  int factorSize = 10 ;
  size.mult(factorSize) ;
  pushMatrix() ;
  translate(-size.x *.5,-size.y *.5 , -size.z*.5) ;
  shader(s) ;

  Vec4 RGBbackground = HSBa_to_RGBa( map(valueSlider[0][0],0,MAX_VALUE_SLIDER,0,g.colorModeX), 
                                map(valueSlider[0][1],0,MAX_VALUE_SLIDER,0,g.colorModeY), 
                                map(valueSlider[0][2],0,MAX_VALUE_SLIDER,0,g.colorModeZ),
                                map(valueSlider[0][3],0,MAX_VALUE_SLIDER,0,g.colorModeA)  ) ;
  float redNorm = map(RGBbackground.x,0,255,0,1) ;
  float greenNorm = map(RGBbackground.y,0,255,0,1) ;
  float blueNorm = map(RGBbackground.z,0,255,0,1) ;
  float alphaNorm = map(RGBbackground.w,0,255,0,1) ;
  float varTime = (float)millis() *.001 ;
  if(spaceTouch) {
    shaderMouseX = map(mouse[0].x,0,width,0,1) ;
    shaderMouseY = map(mouse[0].y,0,height,0,1) ;
  }
  
  s.set("colorBG",redNorm, greenNorm, blueNorm, alphaNorm) ; 
  s.set("mixSound", mix[0]) ;
  s.set("timeTrack", getTimeTrack()) ;
  s.set("tempo", tempo[0]) ;
  s.set("beat", allBeats(0)) ;
  s.set("mouse",shaderMouseX, shaderMouseY) ;
  s.set("resolution",size.x/factorSize, size.y/factorSize) ;
  s.set("time", varTime);
  
  beginShape(QUADS) ;
  vertex(pos.x,pos.y) ;
  vertex(pos.x +size.x,pos.y) ;
  vertex(pos.x +size.x,pos.y +size.y) ;
  vertex(pos.x,pos.y +size.y) ;
  endShape() ;
  resetShader() ;
  popMatrix() ;
}

//
//END BACKGROUND
