class triangle {
  PVector v1, v2, v3;
  PVector C;
  PVector N;
  float R;
  float A;
  float side;
  //float[] rgb = new float[3];;
  int rgbIndex;
  /*
  public triangle(PVector center, PVector normal, float area) {
   C = center;
   N = normal;
   A = area;
   R = 2*pow(3, -0.75)*sqrt(area);
   side = sqrt(3)*R;
   v1 = null;
   v2 = null;
   v3 = null;
   }*/
  //public triangle() {}
  triangle(PVector v1, PVector v2, PVector v3) {
    this.v1 = v1;
    this.v2 = v2;
    this.v3 = v3;
    C = new PVector((v1.x+v2.x+v3.x)/3, (v1.y+v2.y+v3.y)/3, (v1.z+v2.z+v3.z)/3);
    rgbIndex = 0;
  }

  void setRGB(int i)
  {
    rgbIndex = i;
  }
  void drawCircle() {
    PVector u = new PVector(N.y, -N.x, 0);
    u.normalize();
    PVector v = u.cross(N);
    v.normalize();
    //stroke(rgb[0], rgb[1], rgb[2]);
    //pushMatrix();
    //translate(width/2,height/2,0);
    float thea = 0.0;
    for (int i = 1; i < 500; i++)
    {
      float x = C.x + R*(u.x*cos(thea) + v.x*sin(thea));
      float y = C.y + R*(u.y*cos(thea) + v.y*sin(thea));
      float z = C.z + R*(u.z*cos(thea) + v.z*sin(thea));
      point(x, y, z);
      thea += i*2*PI/100;
    }
    //popMatrix();
  }


  boolean isIntersect(triangle tri)
  {
    PVector cdiff = C.sub(tri.C);
    float cdifflen = cdiff.mag();
    if (cdifflen > (R + tri.R))
    {
      return false;
    } else if (cdifflen == (R + tri.R))
    {
      setVertex(C.mult(tri.R/(R + tri.R)).add(tri.C.mult(R/(R + tri.R))));
      return true;
    }
    //else if ()
    //{

    //}
    return false;
  }

  void setVertex(PVector v1)
  {
    this.v1 = v1;
  }
}