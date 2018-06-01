import processing.pdf.*;

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

PFont font;

boolean record = true; 
int j=0;

String inputFilename = "skyrace.gpx";
String outputFilename = "skyrace.pdf";


void setup() {
  xml = loadXML(inputFilename);
  XML track = xml.getChild("trk");
  name = track.getChild("name");
  XML segment = track.getChild("trkseg");
  points = segment.getChildren("trkpt");

  size(1000, 1000);

  if (record) { 
    beginRecord(PDF, outputFilename);
  }

  //fullScreen();

  padding_left = width/5;
  padding_right = padding_left;

  padding_top = height/10;
  padding_bottom = height/5;

  font = createFont("IBM Plex Sans", 40);
}

void draw() {
  background(30, 30, 30);
  textSize(20);
  textAlign(CENTER);
  textFont(font);
  fill(255);
  stroke(255);

  // centers based on max/min lat
  float text_x = map((lon_min+lon_max)/2, lon_min, lon_max, 0, width);
  float text_y = height-padding_bottom+height/10;

  text(name.getContent(), text_x, text_y);

  String additional_information = "5. august 2017 | 4:45:06 | 32 km | 2000 m elevation";
  textSize(15);
  text(additional_information, text_x, text_y+height/50);

  for (int i = 0; i < points.length; i++) {
    float lat = points[i].getFloat("lat");
    float lon = points[i].getFloat("lon");

    if (lat < lat_min) {
      lat_min = lat;
    } else if (lat > lat_max) {
      lat_max = lat;
    }

    if (lon < lon_min) {
      lon_min = lon;
    } else if (lon > lon_max) { 
      lon_max = lon;
    }

    float x = map(lon, lon_min, lon_max, padding_left, width-padding_right);
    float y = map(lat, lat_min, lat_max, height-padding_bottom, padding_top);


    ellipse(x, y, 1, 1);
  }

  if (record) {
    j++;
    if (j>1) {
      endRecord();
    }
  }
}