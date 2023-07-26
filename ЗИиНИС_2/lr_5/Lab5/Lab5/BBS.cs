using System;
using System.Collections.Generic;
using System.Numerics;
using System.Text;

namespace lab8
{
    class BBS
    {
        private BigInteger n;

        public BBS(BigInteger p, BigInteger q)
        {
            this.n = p * q;
        }

        public bool PrimeNumberIsValid(BigInteger primeNumber)
        {
            if (primeNumber % 4 == 3) return true;
            else return false;
        }

        public BigInteger GetRandomNumber() //Random number from range <Int32.minValue;Int32.maxValue)
        {
            Random random = new Random();
            BigInteger randomNumber;
            if (n > (BigInteger)Int32.MaxValue) randomNumber = (BigInteger)random.Next(1, Int32.MaxValue);
            else randomNumber = (BigInteger)random.Next(1, (Int32)n);
            return randomNumber;
        }

        public string GetSeries(int LengthOfSeries)
        {
            string series = string.Empty;
            string binaryValue = string.Empty;

            BigInteger[] xValues = new BigInteger[LengthOfSeries];
            BigInteger randomNumber = GetRandomNumber();
            xValues[0] = (randomNumber * randomNumber) % n;
            if (xValues[0] % 2 == 1) series += 1;
            else series += 0;

            for (int i = 1; i < LengthOfSeries; i++)
            {
                xValues[i] = (xValues[i - 1] * xValues[i - 1]) % n;
                if (xValues[i] % 2 == 1) series += 1;
                else series += 0;
            }

            return series;
        }
    }
}
