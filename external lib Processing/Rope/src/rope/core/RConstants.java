package rope.core;
/**
	* ROPE - Romanesco processing environment – 
	* Copyleft (c) 2014-2018
	* Variable shared throughout rope.core.
	* Rope constants
	* v 0.2.0.1
	* Processing 3.4
	* @author Stan le Punk
	* @see http://stanlepunk.xyz/
	* @see https://github.com/StanLepunK/Rope
	* @see https://en.wikipedia.org/wiki/Mathematical_constant
	*/



public interface RConstants {
	static final int  NOTHING = 0;
	static final int  NONE = 0;
	static final int  NULL = 0;
	
	static final float PHI = (1 + (float)Math.sqrt(5))/2; //a number of polys use the golden ratio... > 1.618....
	static final float GOLD_NUMBER = PHI;
	static final float GOLD_ANGLE = (float)(2*Math.PI) / (PHI*PHI); // > 137.500 in degree
	static final float ROOT2 = (float)Math.sqrt(2); //...and the square root of two, the famous first irrationnal number by Pythagore
	static final float EULER = (float)2.718281828459045235360287471352; // Euler number constant
	static final double G    = 0.00000000006693; // last gravity constant

	static final int HUE = 50;
	static final int SATURATION = 51;
	static final int BRIGHTNESS = 52;

	static final int ALPHA = 100 ;

	static final int FLUID = 200;
	static final int GRAVITY = 201;
	static final int MAGNETIC = 202;

	static final int BLANK = 300;
	static final int PERLIN = 301;
	static final int CHAOS = 302;
	static final int ORDER = 303;
	static final int EQUATION = 304;

	static final int DRAW = 400;
	static final int FIT = 450;

	static final int CARTESIAN = 500;
	static final int POLAR = 501 ;

	static final int MIX = 600 ;

	static final int STATIC = 1000;
	static final int DYNAMIC = 1001;


	/**
	GRAPHIC
	*/
	static final int PIXEL = 800;
	static final int STAR = 805;
	  
	/**
	COLOUR
	*/
	static final int BLACK = -16777216;
	static final int NOIR = -16777216;
	static final int WHITE = -1;
	static final int BLANC = -1;
	// static final int GRAY = 4050 ; // this already existe
	// static final int GRAY_MEDIUM = -8618884;
		
	// GRAY_1 > HSB,1,1,1 > color(0,0,.1); > close to BLACK
	static final int GRAY_1 = -15132391;
	static final int GRIS_1 = -15132391;
	// GRAY_2 > HSB,1,1,1 > color(0,0,.2);	
	static final int GRAY_2 = -13421773;
	static final int GRIS_2 = -13421773;
	// GRAY_3 > HSB,1,1,1 > color(0,0,.3);
	static final int GRAY_3 = -11776948;
	static final int GRIS_3 = -11776948;
	// GRAY_4 > HSB,1,1,1 > color(0,0,.4);
	static final int GRAY_4 = -10066330;
	static final int GRIS_4 = -10066330;
	// GRAY_5 > HSB,1,1,1 > color(0,0,.5);
	static final int GRAY_MEDIUM = -8421505;
	static final int GRAY_5 = -8421505;
	static final int GRIS = -8421505;
	static final int GRIS_MOYEN = -8421505;
	static final int GRIS_5 = -8421505;
	// GRAY_6 > HSB,1,1,1 > color(0,0,.6);
	static final int GRAY_6 = -6710887;
	static final int GRIS_6 = -6710887;
	// GRAY_7 > HSB,1,1,1 > color(0,0,.7);
	static final int GRAY_7 = -5066062;
	static final int GRIS_7 = -5066062;
	// GRAY_8 > HSB,1,1,1 > color(0,0,.8);
	static final int GRAY_8 = -3355444;
	static final int GRIS_8 = -3355444;
	// GRAY_9 > HSB,1,1,1 > color(0,0,.9); > close to WHITE
	static final int GRAY_9 = -1710619;
	static final int GRIS_9 = -1710619;
	  
	/**
	 * color guide
	 * @see https://fr.wikipedia.org/wiki/Liste_de_noms_de_couleur
	*/
	// RED > HSB,1,1,1 > color(0,1,1);
	static final int RED = -65536;
	static final int ROUGE = -65536;
	// BLOOD > HSB,1,1,1 > color(0,1,.75);
	static final int BLOOD = -4259840;
	static final int SANG = -4259840; 
	// CARMINE > HSB,1,1,1 > color(0,1,.55);
	static final int CARMINE = -7602176;
	static final int CARMIN = -7602176; 
	// GRENAT > HSB,1,1,1 > color(0.9848485 0.9 0.43137255);
	static final int GRENAT = -9565420;
	static final int GARNET = -9565420;
	// GRENAT PROFOND > HSB,1,1,1 > color(0.0 1.0 0.28);
	static final int GRENAT_PROFOND = -12124160;
	static final int GARNET_DEEP = -12124160;
	// ORANGE > HSB,1,1,1 > color(.08,1,1);
	static final int ORANGE = -34304;
	// OR > HSB,1,1,1 > color(0.12 1.0 1.0);
	static public int OR = -20736;
	static public int GOLD = -20736;
	// YELLOW > HSB,1,1,1 > color(0.166 1.0 1.0);
	static public int YELLOW = -256;
	static public int JAUNE = -256;
	// BOUTEILLE / BOTTLE > HSB,1,1,1 > color(0.33333334 0.9150943 0.41568628);
	static final int BOUTEILLE = -16160247;
	static final int BOTTLE = -16160247;
	// GREEN > HSB,1,1,1 > color(0.333 1.0 1.0);
	static final int GREEN = -16711936;
	static final int VERT = -16711936;
	// CYAN > HSB,1,1,1 > color(0.5 1.0 1.0);
	static public int CYAN = -16711681;
	// BLUE > HSB,1,1,1 > color(.6503,1,1);
	static final int BLUE = -16770561;
	static final int BLEU = -16770561;  
	// MAGENTA > HSB,1,1,1 > color(.8333,1,1);
	static public int MAGENTA = -65281;
	// PINK > HSB,1,1,1 > color(.86,.65,1);
	static public int PINK = -42524;
	static public int ROSE = -42524;
	// PURPLE > HSB,1,1,1 > color(.7496,1,1);
	static public int PURPLE = -8453889;
	static public int VIOLET = -8453889;  
	/**
	 * String Constants
	 */
	static final String RANDOM = "RANDOM";
	static final String RANDOM_ZERO = "RANDOM ZERO";
	static final String RANDOM_RANGE = "RANDOM RANGE";
	static final String RANDOM_ROOT = "ROOT_RANDOM";
	static final String RANDOM_QUARTER ="QUARTER_RANDOM";
	static final String RANDOM_2 = "2_RANDOM" ;
	static final String RANDOM_3 = "3_RANDOM" ;
	static final String RANDOM_4 = "4_RANDOM" ;
	static final String RANDOM_X_A = "SPECIAL_A_RANDOM" ;
	static final String RANDOM_X_B = "SPECIAL_B_RANDOM" ;

	static final String SIN = "SIN" ;
	static final String COS = "COS" ;
	static final String TAN = "TAN" ;
	static final String TRIG_0 = "SIN_TAN" ;
	static final String TRIG_1 = "SIN_TAN_COS" ;
	static final String TRIG_2 = "SIN_POW_SIN" ;
	static final String TRIG_3 = "POW_SIN_PI" ;
	static final String TRIG_4 = "SIN_TAN_POW_SIN" ;
}

