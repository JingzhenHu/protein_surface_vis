class triangle_Read {
  int map;
  float[] avePos;
  PVector[] vertex;
  //triangle[] triPos;
  ArrayList<triangle> triPos;
  //PVector[][] triVec;
  PVector[] center;

  triangle_Read(String proteinID, int map, float[] avePos) {
    this.map = map;
    this.avePos = avePos;
    try {
      String[] lines = loadStrings(proteinID + ".vert"); 
      int numOfLines = lines.length-3;
      vertex = new PVector[numOfLines];
      for (int i = 0; i < numOfLines; i++)
      {
        String[] content = split(lines[i+3], ' ');

        int[] index = new int[9];
        int k = 0;
        for (int j = 0; j < content.length; j++)
        {
          if (!content[j].equals(""))
          {
            index[k] = j;
            k++;
          }
        }  
        //for (int m = 0; m < 9; m++)
        //{
        //  print(content[index[m]]);
        //}
        vertex[i] = new PVector(map*(float(content[index[0]])-avePos[0]), 
          map*(float(content[index[1]])-avePos[1]), 
          map*(float(content[index[2]])-avePos[2]));
      }
      String[] faces = loadStrings(proteinID + ".face"); 
      int numOfTri = faces.length-3;
      //println(numOfTri);
      //triVec = new PVector[numOfTri][3];
      triPos = new ArrayList<triangle>();
      ;
      center = new PVector[numOfTri];
      for (int i = 0; i < numOfTri; i++)
      {
        String[] content = split(faces[i+3], ' ');

        int[] index = new int[5];
        int k = 0;
        for (int j = 0; j < content.length; j++)
        {
          if (!content[j].equals(""))
          {
            index[k] = j;
            k++;
          }
        }
        //for (int m = 0; m < 5; m++)
        //{
        //  println(content[index[m]]);
        //}

        //println(vertex[int(content[index[j]])-1]);
        triPos.add(new triangle(vertex[int(content[index[0]])-1], 
          vertex[int(content[index[1]])-1], 
          vertex[int(content[index[2]])-1]));
        //triVec[i][j] = vertex[int(content[index[j]-1])];

        // center[i] = triVec[i][0].add(triVec[i][1]).add(triVec[i][2]).div(3);
      }
    }
    catch(Exception e) {
      println("Cannot read from the vert or face file >_<!!!");
      e.printStackTrace();
    }
  }
}