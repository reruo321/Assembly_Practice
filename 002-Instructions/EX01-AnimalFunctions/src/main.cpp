#include <iostream>

using namespace std;

extern "C" { int goose(); int cow(int a, int b); int pig(int a); int sheep(int c); int duck(int a); }

int main() {
	cout << "int goose() = " << goose() << endl;
	cout << "int cow(15, 2) = " << cow(15, 2) << endl;
	cout << "int pig(123) = " << pig(123) << endl;
	cout << "int sheep(333) = " << sheep(333) << endl;
	cout << "int sheep(0) = " << sheep(0) << endl;
	cout << "int sheep(-1) = " << sheep(-1) << endl;
	cout << "int sheep(55555) = " << sheep(55555) << endl;
	cout << "int sheep(-55555) = " << sheep(-55555) << endl;
	cout << "int duck(-321) = " << duck(-321) << endl;
	cout << "int duck(321) = " << duck(321) << endl;
	cout << "int duck(1) = " << duck(1) << endl;
	cout << "int duck(0) = " << duck(0) << endl;
	cout << "int duck(-1) = " << duck(-1) << endl;
	return 0;
}
