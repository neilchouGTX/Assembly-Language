#include <iostream>
//#include <stdio.h>
using namespace std;

extern "C" void asmMain( );
extern "C" int AllPrimeFactors(int N);
int AllPrimeFactors(int N);


int main() {
	asmMain();
	return 0;
}
int AllPrimeFactors(int N) {
    int i = 2, count=0;
    int temp = 0;
    while (i <= N) {

        if ((N / i == 1) && (N % i == 0)) {
            
            if (temp != i) {
                count++;
                temp = i;
                cout << i << endl;
            }
            break;
        }
        if (N % i == 0) {
            N /= i;
            if (temp != i) {
                count++;
                temp = i;
                cout << i << " ";
            }
            i--;
        }
        i++;
    }
    return count;
}