sha1-sat -- SAT instance generator for SHA-1
============================================


# Compiling

To compile, you first need to make sure you have the Boost libraries
installed. When you do, simply run make.sh:

    bash make.sh


# Running

To generate a CNF instance encoding a preimage attack on the full SHA-1
algorithm, run:

    ./main --cnf --rounds=80 --hash-bits=160 > instance.cnf

To look at the possible options, run:

    ./main --help

The program can also generate OPB instances (pseudo-boolean constraints) if
you specify --opb instead of --cnf.


# Verifying solutions

To verify that the solution output by the solver is actually correct, run:

    perl verify-preimage instance.cnf solution | ./verify-preimage

Here, 'solution' is the file output e.g. by minisat or the 'v'-line for
other popular solvers like CryptoMiniSAT or PrecoSAT. The program returns
an error code of 0 if and only if the solution is correct.


# Using espresso

Part of the encoding used by this program is generated using the logic
minimiser espresso. In particular, it is used to minimise the truth tables
for half-adders.

You used to be able to obtain espresso from
<ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/other-software/espresso-ab-1.0.tar.gz>,
but it is no longer available there. As a consequence, I have decided to
move the dependency on espresso "out of line" and provide the precomputed
output tables (see the data/ subdirectory).

If you wish to regenerate these tables (or if you would like to encode them
for adders with different number of operands), this is how you would use
espresso:

    wget ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/other-software/espresso-ab-1.0.tar.gz
    tar xzvf espresso-ab-1.0.tar.gz
    (cd espresso-ab-1.0 && ./configure && make)

    g++ -std=c++ -o mkhalfadder mkhalfadder.cc
    ./mkhalfadder 2 2 | espresso-ab-1.0/src/espresso > data/halfadder-2-2.out.txt


# About

I developed this program as part of my master thesis. You can find it here:
<https://www.duo.uio.no/handle/10852/34912>.

The program creates the smallest and easiest-to-solve instances that I know
about; in particular, it uses a novel encoding of adders which is described
in more detail in my short benchmark description "Instance generator for
encoding preimage, second-preimage, and collision attacks on SHA-1", which
you can find on page 119 of the SAT Competition 2013 proceedings:
<https://tuhat.helsinki.fi/portal/files/27982690/sc2013_proceedings.pdf>.

Please e-mail comments, suggestions, etc. to me at <vegard.nossum@gmail.com>.

If you use the program in your research, please make a note of this in your
acknowledgements and let me know about your paper/thesis/etc.!
