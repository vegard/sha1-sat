/*
 * sha1-sat -- SAT instance generator for SHA-1
 * Copyright (C) 2011-2012, 2021  Vegard Nossum <vegard.nossum@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <stdio.h>
#include <stdlib.h>

/*
 * This program generates an input file for Espresso that encodes a
 * "half-adder" constraint (AKA unary-binary constraint).
 *
 * The half-adder constraint is a constraint over N 1-bit inputs n and
 * one M-bit input m and is satisfied when m = sum(n).
 *
 * For example, with N=4 and M=3, a half-adder constraint with inputs
 * n=1101b and m=011b is satisfied because 1 + 1 + 0 + 1 == 3.
 */

int main(int argc, char *argv[])
{
	if (argc != 3) {
		fprintf(stderr, "Usage: %s N M\n", argv[0]);
		exit(EXIT_FAILURE);
	}

	unsigned int n = atoi(argv[1]);
	unsigned int m = atoi(argv[2]);

	printf(".i %u\n", n + m);
	printf(".o 1\n");

	for (unsigned int i = 0; i < 1U << n; ++i) {
		for (unsigned int j = 0; j < 1U << m; ++j) {
			for (unsigned int k = n; k--; )
				printf("%u", 1 - ((i >> k) & 1));
			for (unsigned int k = m; k--; )
				printf("%u", 1 - ((j >> k) & 1));

			printf(" %u\n", __builtin_popcount(i) != j);
		}
	}

	printf(".e\n");

	return 0;
}
