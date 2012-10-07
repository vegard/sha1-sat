set -e
set -u

g++ -Wall -std=c++0x -O2 -o main main.cc -lboost_program_options
