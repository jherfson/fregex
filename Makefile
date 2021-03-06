# A very basic makefile with just the test target.

F90 = g95

default: fexp.o ; $(F90) -c regex.f90

test: testharness
	tests/testdrive.pl < tests/test.1
	tests/testdrive.pl < tests/test.2


testharness: fexp.o test.o regex_test.o fexp_debug.o
	$(F90) fexp.o test.o fexp_debug.o -o test
	$(F90) fexp.o regex_test.o fexp_debug.o -o regex_test

clean:
	rm *.mod *.o test regex_test

fexp.o : fexp.f90 fexp_debug.o ; $(F90) -c fexp.f90
test.o : test.f90 ; $(F90) -c test.f90
regex_test.o : regex_test.f90 ; $(F90) -c regex_test.f90
fexp_debug.o : fexp_debug.f90 ; $(F90) -c fexp_debug.f90




