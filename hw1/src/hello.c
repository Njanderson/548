#include <stdio.h>

int main() {
  int a = 0xdead;
  int b = 0xbeef;
  int c = a / b;
  printf("%d\n", c);
  return 0;
}
