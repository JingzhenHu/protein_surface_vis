//import controlP5.*;
//import g4p_controls.*;

Protein protein;
triangulation proWsMed;
//triangle[] tri;
triangle_Read triR;
Scene scene;
int numOfTri;
//ControlP5 cp5;
//int controlEvent;
void setup() {
  //frameRate(50);
  //try {
  //  Runtime rt = Runtime.getRuntime();
  //  rt.exec("cmd.exe /c cd data/tabipb.exe");
  //}
  //catch (Exception e)
  //{
  //  println("Unable run the tabipb.exe >_<!!!");
  //  e.printStackTrace();
  //}
  size(800, 800, P3D);
  surface.setResizable(true);
  //background(0, 64, 200);
  //controlEvent = 0;
  //cp5 = new ControlP5(this);
  
  //cp
  protein = new Protein("1ajj");
  //println(protein.proteinID);
  //println(protein.map);
  //println(protein.avePos);
  proWsMed = new triangulation(protein.proteinID, protein.map, protein.avePos);
  //println(proWsMed.area.length);
  //tri = new triangle[proWsMed.area.length];
  //for (int i =0; i < tri.length; i++)
  //{
  //  tri[i] = new triangle(proWsMed.vec[i], proWsMed.norm[i], proWsMed.area[i], proWsMed.rgb[i]);
  //}
  triR = new triangle_Read(protein.proteinID, protein.map, protein.avePos);
  numOfTri = triR.triPos.size();
  //println(numOfTri);
  //println(proWsMed.vec.length);
  for (int i = 0; i < numOfTri; i++)
  {
    for (int j = 0; j < proWsMed.vec.length; j++)
    {
      if (abs(proWsMed.vec[j].mag() - triR.triPos.get(i).C.mag())<0.0001)
      {
        triR.triPos.get(i).setRGB(j);
      }
    }
  }

  //PrintWriter output = createWriter("out.txt");
  //  for (int j = 0; j < proWsMed.vec.length; j++)
  //{
  //  for (int i = 0; i < numOfTri; i++)
  //  {
  //      output.println(proWsMed.vec[j].mag());
  //      output.println();
  //      output.println(triR.triPos.get(i).C.mag());
  //  }
  //}

  //println("BACK To Main");
  //int ss = triR.triPos.size();
  //println(ss);
  //println(triR.triPos.get(ss-1).v1);
  //println(triR.triPos.get(ss-1).v2);
  //println(triR.triPos.get(ss-1).v3);
  noSmooth();
  scene = (Scene)new Scene1();
  scene.setEnable();
  println("Setup Over");
}

float t = 0;
void draw() {
  background(0);
  //protein.displayBG();
  //protein.motion();
  //protein.drawProtein();
  //proWsMed.drawProtein();

  t += 0.005f;
  scene = scene.update();
  //pushMatrix();
  //translate(width/2, height/2, 0);
  //for (triangle alele : tri)
  //{
  //  alele.drawCircle();
  //}
  //popMatrix();
}

void diaTriBG()
{
  strokeWeight(5);
  stroke(255);
  textSize(18);
  text("Protein ID: " + " ", width/6, height/6); // later do the GUI
}

//**************************************************************************
interface Scene {
  Scene update();
  void setEnable();
}



class Scene1 implements Scene {
  boolean isEnable;
  Scene1() {
  }
  public Scene update() {
    background(0);
    camera (-250*sin(t), 0, -250*cos(t), 0, 0, 0, 0, -1, 0);
    //lights();

    //stroke(255, 200);
    smooth();
    strokeWeight(2);
    int i = 0;
    for (PVector v : proWsMed.vec) {
      stroke(proWsMed.rgb[i][0], proWsMed.rgb[i][1], proWsMed.rgb[i][2], 200);
      point(v.x, v.y, v.z);
      i++;
    }
    if (!isEnable) return this;
    if (mousePressed) {
      isEnable = false;
      return new SceneMoveDissolve(this, new Scene2());
    }
    return this;
  }
  public void setEnable() {
    this.isEnable = true;
  }
}

class Scene2 implements Scene {
  boolean isEnable;
  Scene2() {
  }
  public Scene update() {
    background(0);
    camera (-250*sin(t), 0, -250*cos(t), 0, 0, 0, 0, -1, 0);
    //lights();

    //stroke(255, 200);
    //strokeWeight(2);
    //int i = 0;
    //for (PVector v : proWsMed.vec) {
    //  stroke(proWsMed.rgb[i][0], proWsMed.rgb[i][1], proWsMed.rgb[i][2], 200);
    //  point(v.x, v.y, v.z);
    //  i++;
    //}
    //for (triangle alele : tri)
    //{
    //  alele.drawCircle();
    //}
    //fill(230, 250, 255);
    noFill();
    strokeWeight(1);

    //noStroke();
    beginShape(TRIANGLES);
    for (int j = 0; j < numOfTri; j++) {
      //noSmooth();
      int index = triR.triPos.get(j).rgbIndex;
      stroke(proWsMed.rgb[index][0], proWsMed.rgb[index][1], proWsMed.rgb[index][2]);
      PVector v1 = triR.triPos.get(j).v1;
      PVector v2 = triR.triPos.get(j).v2;
      PVector v3 = triR.triPos.get(j).v3;

      vertex(v1.x, v1.y, v1.z);
      vertex(v2.x, v2.y, v2.z);
      vertex(v3.x, v3.y, v3.z);
    }
    endShape();
    if (!isEnable) return this;
    if (mousePressed) {
      isEnable = false;
      return new SceneMoveDissolve(this, new Scene3());
    }
    return this;
  }
  public void setEnable() {
    this.isEnable = true;
  }
}

class Scene3 implements Scene {
  boolean isEnable;
  Scene3() {
  }
  public Scene update() {
    background(0);
    camera (-250*sin(t), 0, -250*cos(t), 0, 0, 0, 0, -1, 0);
    //lights();
    //stroke(255, 200);
    //int i =0;
    //strokeWeight(2);
    //for (PVector v : proWsMed.vec) {
    //  stroke(proWsMed.rgb[i][0], proWsMed.rgb[i][1], proWsMed.rgb[i][2], 200);
    //  point(v.x, v.y, v.z);
    //  i++;
    //}
    //noFill();
    //strokeWeight(1);
    //stroke(255);
    noStroke();
    beginShape(TRIANGLES);
    for (int j = 0; j < numOfTri; j++) {
      //noSmooth();
      int index = triR.triPos.get(j).rgbIndex;
      fill(proWsMed.rgb[index][0], proWsMed.rgb[index][1], proWsMed.rgb[index][2], 255);
      //fill(triR.triPos.get(j).rgb[0], triR.triPos.get(j).rgb[1], triR.triPos.get(j).rgb[2]);
      PVector v1 = triR.triPos.get(j).v1;
      PVector v2 = triR.triPos.get(j).v2;
      PVector v3 = triR.triPos.get(j).v3;

      vertex(v1.x, v1.y, v1.z);
      vertex(v2.x, v2.y, v2.z);
      vertex(v3.x, v3.y, v3.z);
    }
    endShape();

    if (!isEnable) return this;
    if (mousePressed) {
      isEnable = false;
      return new SceneMoveDissolve(this, new Scene1());
    }
    return this;
  }
  public void setEnable() {
    this.isEnable = true;
  }
}

class SceneMoveCube implements Scene {
  private Scene current, next;
  private PImage curImage, nextImage;  // 画面のイメージ
  private float heading;  // 鉛直まわり回転量

  public void setEnable() {
  }
  public SceneMoveCube(Scene cur, Scene next) {
    this.current = cur;
    this.next = next;
    this.curImage = createImage(width, height, RGB);
    this.nextImage = createImage(width, height, RGB);
    this.heading = 0;
  }

  public Scene update() {
    // 画像読み込み
    fill(255);
    current.update();
    loadPixels();
    for (int i = 0; i < pixels.length; ++i)
      curImage.pixels[i] = pixels[i];
    updatePixels();

    fill(255);
    next.update();
    loadPixels();
    for (int i = 0; i < pixels.length; ++i)
      nextImage.pixels[i] = pixels[i];
    updatePixels();
    fill(255);

    background(0);
    camera();
    lights();

    pushMatrix();
    translate(width/2, height/2, -width/2);
    rotateY(radians(heading-=1.5));

    //noSmooth(); 
    noStroke();
    beginShape(QUAD_STRIP);
    texture(curImage);
    for (int i = 0; i <= width; i+=10) {
      vertex(-width/2 + i, -height/2, width/2, i, 0);
      vertex(-width/2 + i, height/2, width/2, i, height);
    }
    endShape();

    beginShape(QUAD_STRIP);
    texture(nextImage);
    for (int i = 0; i <= width; i+=10) {
      vertex(width/2, -height/2, width/2-i, i, 0);
      vertex(width/2, height/2, width/2-i, i, height);
    }
    endShape();
    popMatrix();

    if (heading <= -90) {
      next.setEnable();
      return next;
    }
    return this;
  }
}

class SceneMoveDissolve implements Scene {
  private final int MAX = 50;
  private Scene current, next;
  private PImage curImage, nextImage;  
  private int[] dissolvablePixels;
  private int index;

  public void setEnable() {
  }
  public SceneMoveDissolve(Scene cur, Scene next) {
    this.current = cur;
    this.next = next;
    this.index = 0;
    this.curImage = createImage(width, height, RGB);
    this.nextImage = createImage(width, height, RGB);
    this.dissolvablePixels = new int[width*height];
    for (int i = 0; i < this.dissolvablePixels.length; i++) {
      this.dissolvablePixels[i] = (int)random(MAX);
    }
  }

  public Scene update() {
    current.update();
    loadPixels();
    for (int i = 0; i < pixels.length; ++i)
      curImage.pixels[i] = pixels[i];
    updatePixels();

    next.update();
    loadPixels();
    for (int i = 0; i < pixels.length; ++i)
      nextImage.pixels[i] = pixels[i];
    updatePixels();

    camera();
    background(0);
    loadPixels();
    for (int i = 0; i < dissolvablePixels.length; i++) {
      if (dissolvablePixels[i] <= index) {
        pixels[i] = nextImage.pixels[i];
      } else {
        pixels[i] = curImage.pixels[i];
      }
    }
    updatePixels();

    if ( ++index > MAX ) {
      next.setEnable();
      return next;
    }
    return this;
  }
}