XML xml;
XML[] points;

float lat_max = 0;
float lat_min = 180;

float lon_max = 0;
float lon_min = 90; 

float padding_left;
float padding_right;
float padding_top;
float padding_bottom;
XML name;

void setup() {
  xml = loadXML("skyrace.gpx");
  XML track = xml.getChild("trk");
  name = track.getChild("name");
  XML segment = track.getChild("trkseg");
  points = segment.getChildren("trkpt");
  
  size(500,500);
  
  padding_left = width/5;
  padding_right = padding_left;
  
  padding_top = height/10;
  padding_bottom = height/5;
  

}

void draw(){
  background(255);
  textSize(20);
  textAlign(CENTER);
  fill(0);
  
  // centers based on max/min lat
  float text_x = map((lon_min+lon_max)/2, lon_min, lon_max, 0, width);
  float text_y = height-padding_bottom+30;
  
  text(name.getContent(),text_x,text_y);
  
  for (int i = 0; i < points.length; i++) {
    float lat = points[i].getFloat("lat");
    float lon = points[i].getFloat("lon");
    
    if(lat < lat_min){
      lat_min = lat;
    } else if (lat > lat_max) {
      lat_max = lat;
    }
    
    if(lon < lon_min){
      lon_min = lon;
    } else if (lon > lon_max) { 
      lon_max = lon;
    }
      
    float x = map(lon, lon_min, lon_max, padding_left, width-padding_right);
    float y = map(lat, lat_min, lat_max, height-padding_bottom, padding_top);
    
    ellipse(x,y,1,1);
    
    
    XML e = points[i].getChild("ele");
    float elevation = parseFloat(e.getContent()) ;
    //println(lat + ", " + lon + ", " + elevation);
  }

}