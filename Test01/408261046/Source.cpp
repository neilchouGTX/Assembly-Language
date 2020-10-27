#include <iostream>
using namespace std;

extern "C" void Main();
extern "C" int gcd(int x, int y);

int gcd(int x, int y);

int main() {
	Main();
	return 0;
}
int gcd(int x, int y) {
	int i = 2;
	int total = 1;
	while (i <= x) {
		if ((x % i == 0) && (y % i == 0)) {
			total *= i;
			x /= i;
			y /= i;
		}
		else {
			i++;
		}
	}
	return total;
}
