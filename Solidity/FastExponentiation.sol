// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
/*  (base ^ exponent) mod p */
contract FastExponentiation {

    function fast_exp(
        uint256 p,
        uint256 b,
        uint256 exponent
    )
        public
        pure
        returns (uint256)
    {
        uint256 temp = exponent;
        uint256 i = 0;

        /* Step 1: Find bit length */
        while (temp > 0) {
            temp /= 2;
            i++;
        }

        uint256 bit_length = i;
        uint256[] memory exp_bits = new uint256[](bit_length);

        /* Step 2: Convert exponent to binary */
        temp = exponent;
        for (i = 0; i < bit_length; i++) {
            exp_bits[i] = temp % 2;
            temp /= 2;
        }

        /* Step 3: Fast exponentiation */
        uint256 x = b % p;
        uint256 y = 1;

        for (i = 0; i < bit_length; i++) {
            if (exp_bits[i] == 1) {
                y = (y * (x % p)) % p;
            }
            x = (x * x) % p;
        }

        return y;
    }
}
