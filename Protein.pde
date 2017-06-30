// 'r' control rotation
class Protein {
  String proteinID;
  int map;
  float[][] pos;
  float[] charge;
  float[][] rgb;
  float[] radius;
  float[] avePos;
  float[] drawX;
  float[] drawY;
  float[] drawZ;
  float rotX;
  float rotY;
  float rotZ;
  int rotation;
  public Protein(String proteinID)
  {
    this.proteinID = proteinID;
    try {
      String[] lines = loadStrings("test_proteins/" + proteinID + ".pqr");
      int numOfLines = lines.length;
      pos = new float[numOfLines][3];
      charge = new float[numOfLines];
      rgb = new float[numOfLines][3];
      radius = new float[numOfLines];
      drawX = new float[numOfLines];
      drawY = new float[numOfLines];
      drawZ = new float[numOfLines];
      avePos = new float[3];
      rotX = 0.2;
      rotY = 0.4;
      rotZ = 0.3;
      rotation = 0;
      float sumX = 0.0;
      float sumY = 0.0;
      float sumZ = 0.0;
      for (int i = 0; i < numOfLines; i++)
      {
        String[] content = split(lines[i], ' ');

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
        //for (int m = 0; m < 10; m++)
        //{
        //  print(content[index[m]]);
        //}

        pos[i][0] = float(content[index[5]]);
        pos[i][1] = float(content[index[6]]);
        pos[i][2] = float(content[index[7]]);

        sumX += pos[i][0];
        sumY += pos[i][1];
        sumZ += pos[i][2];

        charge[i] = float(content[index[8]]);
        float max = max(charge);
        float min = min(charge);
        //println(max);
        //println(min);
        for (int j = 0; j < numOfLines; j++)
        {
          convertRGB1(max, min, charge[j], j);
        }
        radius[i] = 6*float(content[index[9]]);
        //float radMax = max(radius);
        //float radMin = min(radius);

        //for (int j = 0; j < numOfLines; j++)
        //{
        //  charge[j] = charge[j]/max;
        //}
        //convertRGB2(charge, numOfLines);
      }
      avePos[0] = sumX/numOfLines;
      avePos[1] = sumY/numOfLines;
      avePos[2] = sumZ/numOfLines;
      //println(avePos[0]);
      //println(avePos[1]);
      //println(avePos[2]);

      map = floor(map(abs((avePos[0] + avePos[1] + avePos[2])/3), 64, 0, 4, 8));
      //round(640/avPosXe)/10;
      //println(map);
      for (int i = 0; i < numOfLines; i++)
      {
        for (int j = 0; j < 3; j++)
        {
          pos[i][j] *= map;
        }
      }

      //for (int m = 0; m < numOfLines; m++)
      //{
      //println(rgb[m][0]);
      //println(rgb[m][1]);
      //println(rgb[m][2]);
      //}
      //println(radius[0]);
    }
    catch(Exception e) {
      println("Cannot read from the pqr file >_<!!!");
      e.printStackTrace();
    }
  }

  public void displayBG() {
    strokeWeight(5);
    stroke(255);
    textSize(18);
    fill(255);
    text("Protein ID: " + proteinID, width/6, height/6);
  }
  public void motion()
  {
    for (int i = 0; i < radius.length; i++)
    {
      drawX[i] = pos[i][0] - map*avePos[0];
      drawY[i] = pos[i][1] - map*avePos[1];
      drawZ[i] = pos[i][2] - map*avePos[2];
    }
  }
  public void drawProtein()
  {
    noStroke();
    //if (key == 'l')
    //{
    //  fill(200,0,0,50);
    //  lights();
    //  directionalLight(100, 40, 20, 0, 0, -0.125);
    //  ambientLight(100, 0, 0);
    //}
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
    for (int i = 0; i < radius.length; i++)
    {
      pushMatrix();
      //width/2 + pos[i][0] - avePosX, height/2 + pos[i][1] - avePosY
      translate(drawX[i], drawY[i], drawZ[i]);
      fill(rgb[i][0], rgb[i][1], rgb[i][2]);
      specular(rgb[i][0], rgb[i][1], rgb[i][2]);
      //fill(200,0,0,50);
      sphere(radius[i]);
      popMatrix();
    }
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
  }
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