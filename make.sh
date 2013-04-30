set -e
set -u

g++ -Wall -std=c++0x -O2 -o sha1-sat main.cc -lboost_program_options
g++ -Wall -std=c++0x -O2 -o verify-preimage verify-preimage.cc
