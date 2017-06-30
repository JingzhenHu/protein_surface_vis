#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <cmath>
#include <math.h>
#include <iomanip>
//#include <stdlib.h> 
using namespace std;

class Data//a struct to store variables
{
public:
    string fix;
    int index;
    string atom;
    string aminoAcid;
    int aaNumber;
    double x;
    double y;
    double z;
    double charge;
    double radius;
};

int main(int argc, const char * argv[])
{
    cout.precision(17);
    ifstream input;
    string usr[16];
    input.open("usrdata.in");
    if(input.is_open())
    {
        for(int i=0; i!=16; i++)
        {
            input >> usr[i];
        }
    }
    else
        std::cout << "Cannot open the usrdata.in file!" << std::endl;
    input.close();

    string filepath ="test_proteins/";
    filepath +=usr[1];
    filepath +=".pqr";

    //cout << filepath <<endl;
    int numberOfAtom=0;
    vector<Data> list;
    input.open(filepath);
    if(input.is_open())
    {
        string tmp;
        while(getline(input,tmp))
            numberOfAtom++;
        input.clear();
        input.seekg(input.beg);

        for(int i=0; i<numberOfAtom; i++)
        {
            Data d;
            input>>d.fix;
            input>>d.index;
            input>>d.atom;
            input>>d.aminoAcid;
            input>>d.aaNumber;
            input>>d.x;
            input>>d.y;
            input>>d.z;
            input>>d.charge;
            input>>d.radius;
            list.push_back(d);
        }
        input.close();
    }
    else
        std::cout << "Cannot open the pqr file!" << std::endl;
    input.close();

    string xyzr = string(usr[1]);
    //xyzr+=usr[1];
    xyzr+=".xyzr";
    ofstream part(xyzr); //write the RSDID pqr file
    for(int i=0;i<list.size();i++)
    {
        part << setiosflags(ios::left)<< "  " << setiosflags(ios::fixed) <<std::setprecision(5) << std::setw(13) << list[i].x << std::setw(10) <<list[i].y << std::setw(10) << list[i].z << std::setw(10)<<list[i].radius<<std::endl;
    }
    part.close();
}