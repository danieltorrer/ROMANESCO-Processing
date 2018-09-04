/**
Lorenz attractor
2016-2018
v 0.0.3
Inspirated by Nature of Code of Daniel Shiffman
*/
/*
* @see https://www.youtube.com/watch?v=f0lkz2gSsIk&list=PLRqwX-V7Uu6ZiZxtDDRCi6uhfTH4FilpH&index=15
* @see https://en.wikipedia.org/wiki/Lorenz_system
*/
class Lorenz extends Romanesco {
	public Lorenz() {
		item_name = "Lorenz attractor";
		ID_item = 27 ;
		ID_group = 1 ;
		item_author  = "Stan le Punk";
		item_version = "Version 0.0.2";
		item_pack = "Nature of Code 2016";
    item_costume = "";
    item_mode = "Classic/Point";

	  hue_fill_is = true;
    sat_fill_is = true;
    bright_fill_is = true;
    alpha_fill_is = true;
    // hue_stroke_is = true;
    // sat_stroke_is = true;
    // bright_stroke_is = true;
    // alpha_stroke_is = true;
    // thickness_is = true;
    size_x_is = true;
    // size_y_is = true;
    // size_z_is = true;
    // diameter_is = true;
    // canvas_x_is = true;
    // canvas_y_is = true;
    // canvas_z_is = true;

    // frequence_is = true;
    // speed_x_is = true;
    // speed_y_is = true;
    // speed_z_is = true;
    // spurt_x_is = true;
    // spurt_y_is = true;
    // spurt_z_is = true;
    // dir_x_is = true;
    // dir_y_is = true;
    // dir_z_is = true;
    jit_x_is = true;
    jit_y_is = true;
    jit_z_is = true;
    // swing_x_is = true;
    // swing_y_is = true;
    // swing_z_is = true;

    // quantity_is = true;
    // variety_is = true;
    life_is = true;
    // flow_is = true;
    // quality_is = true;
    // area_is = true;
    // angle_is = true;
    // scope_is = true;
    // scan_is = true;
    // align_is = true;
    // repulsion_is = true;
    // attraction_is = true;
    // density_is = true;
    // influence_is = true;
    // calm_is = true;
    spectrum_is = true;
  }

  float a = 10;
  float b = 28;
  float c = 8. / 3.;
  Vec3 pos;
  ArrayList<Vec3> list_points;



  void setup() {
    setting_start_position(ID_item, width/2, height/2, 0);
  }



	void draw() {
    if(list_points == null) {
      pos = Vec3(.01, 0, 0) ;
      list_points = new ArrayList<Vec3>() ;
    } else {
      build_lorenz_attractor(list_points) ;
      if(alpha(fill_item[ID_item]) > 0 || thickness_item[ID_item] > 0) {
        float size = size_x_item[ID_item] *.1 ;
        Vec3 jitter = Vec3(jitter_x_item[ID_item], jitter_y_item[ID_item], jitter_z_item[ID_item]) ;
        jitter.mult(height/10) ;
        float spectrum = map(spectrum_item[ID_item],0,360, 0, 10) ;
        noFill() ;
        show_lorenz_attractor(fill_item[ID_item], size, thickness_item[ID_item], jitter, spectrum, list_points, mode[ID_item]) ;
      }


      // keep the size of list reasonable :)
      int max = 5000 ;
      if(!FULL_RENDERING) max /= 50 ;
      int threshold = 2 + int(life_item[ID_item] *max) ;
      if(list_points.size() > threshold) {
        int remove_size = list_points.size() - threshold ;
        for(int i = 0 ; i < remove_size ; i++) {
          if(i < list_points.size()) list_points.remove(i) ;
        }  
      }
    }    
  }



  void build_lorenz_attractor(ArrayList<Vec3> list) {
    float dt = .01 ;
    Vec3 d = Vec3() ;
    d.x = (a * (pos.y -pos.x)) *dt ;
    d.y = (pos.x * (b -pos.z) - pos.y) *dt ;
    d.z = (pos.x * pos.y -c *pos.z) *dt ;
    
    pos.add(d) ;
    Vec3 final_pos = pos.copy() ;
    list.add(final_pos) ;
  }


  void show_lorenz_attractor(int fill, float size, float strokeWeight, Vec3 jitter, float spectrum, ArrayList<Vec3> list, int mode) {
    Vec4 vec_fill = color_HSB_a(fill) ;
    strokeWeight(strokeWeight) ;

    if(mode == 0 ) beginShape() ;
    for(Vec3 p : list) {
      
      float hue = random_gaussian(vec_fill.x, spectrum) ;
      stroke(hue,vec_fill.y, vec_fill.z, vec_fill.w) ;
      Vec3 pos = p.copy() ;
      pos.mult(size) ;
      pos.jitter(jitter) ;
      if(mode == 0 ) {
        vertex(pos) ;
      } else {
        point(pos) ;
      }
    }
    if(mode == 0 ) endShape() ;
  }
}












