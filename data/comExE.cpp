#include <iostream>
#include <fstream>
using namespace std;
int main() {

	//system("tabipb.exe");

	system("./extract_pqr.exe");

	ifstream usrdata("usrdata.in");//read usrdata file correspondingly
    string a[16];
    if(usrdata.is_open())
    {
        for(int i=0; i!=16; i++)
        {
            usrdata >> a[i];
        }
    }
    else
    {
        std::cout<<"Cannot find the usrdata file." <<std::endl;
    }
    usrdata.close();
    string name = a[1];
    a[1] += ".xyzr";
    string par1 = "if";
    string par2 = "prob";
    string par3 = "de";
    string par4 = "of";

	char temp[512];
	sprintf(temp, "msms -%s %s -%s %f -%s %d -%s %s", par1.c_str(), 
        a[1].c_str(), par2.c_str(), 1.4, par3.c_str(), 10, par4.c_str(), name.c_str());
	system((char *)temp);

}