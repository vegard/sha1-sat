set -e
set -u

PATH="espresso-ab-1.0/src:$PATH"

rm -rf benchmarks

mkdir -p benchmarks
mkdir -p benchmarks/22-128
mkdir -p benchmarks/22-144
mkdir -p benchmarks/22-160
mkdir -p benchmarks/23-64
mkdir -p benchmarks/23-80
mkdir -p benchmarks/23-96
mkdir -p benchmarks/80-4
mkdir -p benchmarks/80-8
mkdir -p benchmarks/80-12

for i in {1..10}
do
	./sha1-sat --seed $RANDOM --attack preimage --rounds 22 --hash-bits 128 --cnf --sat2011 > benchmarks/22-128/$(printf "%03u" $i).cnf
	./sha1-sat --seed $RANDOM --attack preimage --rounds 22 --hash-bits 144 --cnf --sat2011 > benchmarks/22-144/$(printf "%03u" $i).cnf
	./sha1-sat --seed $RANDOM --attack preimage --rounds 22 --hash-bits 160 --cnf --sat2011 > benchmarks/22-160/$(printf "%03u" $i).cnf

	./sha1-sat --seed $RANDOM --attack preimage --rounds 23 --hash-bits 64 --cnf --sat2011 > benchmarks/23-64/$(printf "%03u" $i).cnf
	./sha1-sat --seed $RANDOM --attack preimage --rounds 23 --hash-bits 80 --cnf --sat2011 > benchmarks/23-80/$(printf "%03u" $i).cnf
	./sha1-sat --seed $RANDOM --attack preimage --rounds 23 --hash-bits 96 --cnf --sat2011 > benchmarks/23-96/$(printf "%03u" $i).cnf

	./sha1-sat --seed $RANDOM --attack preimage --rounds 80 --hash-bits 4 --cnf --sat2011 > benchmarks/80-4/$(printf "%03u" $i).cnf
	./sha1-sat --seed $RANDOM --attack preimage --rounds 80 --hash-bits 8 --cnf --sat2011 > benchmarks/80-8/$(printf "%03u" $i).cnf
	./sha1-sat --seed $RANDOM --attack preimage --rounds 80 --hash-bits 12 --cnf --sat2011 > benchmarks/80-12/$(printf "%03u" $i).cnf
done
