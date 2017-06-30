class triangulation {
  String proteinID;
  int map;
  //float[][] pos;
  //Collection<Point> vec;
  PVector[] vec;
  PVector[] norm;
  float[] potential;
  float[] area;

  float[][] rgb;
  float[] avePos;
  //float[] drawX;
  //float[] drawY;
  //float[] drawZ;
  //float rotX;
  //float rotY;
  //float rotZ;
  int rotation;
  public triangulation(String proteinID, int map, float[] avePos)
  {
    this.proteinID = proteinID;
    this.map = map;
    this.avePos = avePos;
    try {
      String[] lines = loadStrings("surface_potential.dat"); 
      int numOfLines = lines.length-1;
      //pos = new float[numOfLines][3];
      vec = new PVector[numOfLines];
      norm = new PVector[numOfLines];
      potential = new float[numOfLines];
      area = new float[numOfLines];
      rgb = new float[numOfLines][3];
      //drawX = new float[numOfLines];
      //drawY = new float[numOfLines];
      //drawZ = new float[numOfLines];
      //rotX = 0.2;
      //rotY = 0.4;
      //rotZ = 0.3;
      //rotation = 0;
      for (int i = 0; i < numOfLines; i++)
      {
        String[] content = split(lines[i+1], ' ');

        int[] index = new int[10];
        int k = 0;
        for (int j = 0; j < content.length; j++)
        {
          if (!content[j].equals(""))
          {
            index[k] = j;
            k++;
          }
        }  
        //pos[i][0] = map*float(content[index[5]]);
        //pos[i][1] = map*float(content[index[6]]);
        //pos[i][2] = map*float(content[index[7]]);
        //for (int m = 0; m < 10; m++)
        //{
        //  print(content[index[m]]);
        //}
        vec[i] = new PVector(map*(float(content[index[1]])-avePos[0]), 
          map*(float(content[index[2]])-avePos[1]), 
          map*(float(content[index[3]])-avePos[2]));
        norm[i] = new PVector(float(content[index[4]]), float(content[index[5]]), 
          float(content[index[6]]));                             
        potential[i] = float(content[index[7]]);
        area[i] = pow(map, 2)*float(content[index[9]]);
        float max = max(potential);
        float min = min(potential);
        //println(max);
        //println(min);
        for (int j = 0; j < numOfLines; j++)
        {
          convertRGB1(max, min, potential[j], j);
        }
      }
      println(map);
      //for (int m = 0; m < numOfLines; m++)
      //{
      //println(rgb[m][0]);
      //println(rgb[m][1]);
      //println(rgb[m][2]);
      //}
      //println(vec.get(40495));
      //println(rgb[40495][0]);
      //println(rgb[40495][1]);
      //println(rgb[40495][2]);
    }
    catch(Exception e) {
      println("Cannot read from the surface_potential file >_<!!!");
      e.printStackTrace();
    }
  }
  /*
  public void motion()
   {
   for (int i = 0; i < potential.length; i++)
   {
   drawX[i] = vec.get(i).x - map*avePos[0];
   drawY[i] = vec.get(i).y - map*avePos[1];
   drawZ[i] = vec.get(i).z - map*avePos[2];
   }
   }
   
   
   public void drawProtein()
   {
   stroke(255);
   lightSpecular(255, 255, 255);
   directionalLight(204, 204, 204, 0, 0, -1);
   //camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
   
   pushMatrix();
   if (mouseX > (0+avePos[0]) && mouseY >(0+avePos[0]) 
   && mouseX < (width-avePos[0]) && mouseY < (height-avePos[1])) {
   translate(mouseX, mouseY, -avePos[2]);
   } else {
   translate(width/2, height/2, -avePos[2]);
   }
   rotateZ(rotZ);
   rotateY(rotY);
   rotateX(rotX);
   //beginShape();
   for (int i = 0; i < potential.length; i++)
   {
   stroke(rgb[i][0], rgb[i][1], rgb[i][2]);
   point(drawX[i], drawY[i], drawZ[i]);
   }
   //endShape();
   popMatrix();
   if (keyPressed)
   {
   if (key == 'r' || key == 'R')
   {
   rotation = (rotation + 1)%2;
   }
   }
   if (rotation == 1)
   {
   rotZ += 0.01;
   rotY += 0.02;
   rotX -= 0.025;
   }
   }*/
  public void convertRGB1(float maxV, float minV, float value, int index) {
    float midV = 0.0;//(maxV - minV)/2;
    if (value >= midV) {
      rgb[index][0] = 255;
      rgb[index][1] = 255*((maxV - value) / (maxV - midV));
      rgb[index][2] = 0;
    } else {
      rgb[index][0] = 0;
      rgb[index][1] = 255*((value - minV) / (midV - minV));
      rgb[index][2] = 255;
    }
  }
}