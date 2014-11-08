#include <stdio.h>
#include <iostream>

struct VS {
  int _1;
  int _2;
};

union VU {
  double number;
  VS vs;
};

struct Value {
  int pointer;
  VU value;
};

typedef unsigned char   Bit8u;
typedef unsigned short  Bit16u;
typedef unsigned int    Bit32u;

int main(int argc, char* argv[]) {

  //Store some values in our union-structure
  Value v;
  v.value.number = 100.0;

  std::cout<<"Value number is "<<v.value.number<<std::endl;

  v.value.vs._1 = 1;
  v.value.vs._2 = 2;
  std::cout<<"Value number 1 is "<<v.value.vs._1<<std::endl;
  std::cout<<"Value number 2 is "<<v.value.vs._2<<std::endl;

  Bit8u data[4] = {0x01,0x23,0x45,0x67};

  Bit16u constructed = (data[2]<<8) | (data[1]&0xff);
  printf("constructed 16bit: %x\n", constructed);

  printf("data: %x\n", *(Bit32u*)data);
  printf("data[0,1] 16bit: %x\n", *(Bit16u*)data);
  printf("data[1,2] 16bit: %x\n", *(Bit16u*)(data+1));
  printf("data[2,3] 16bit: %x\n", *(Bit16u*)(data+2));

  return 0;
}