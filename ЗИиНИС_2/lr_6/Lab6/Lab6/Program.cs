using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Numerics;
using System.Security.Cryptography;
using System.Text;

namespace lab9
{
    class Program
    {
        static Random rand = new Random();
        static Encoding ascii = Encoding.ASCII;

        static void Main(string[] args)
        {
            var sw = new Stopwatch();

            int maxBigIntegerLengthInBits = 8;
            int z = 8;


            string message = "helloworld";
            Console.WriteLine($"Start message: {message}");


            Console.WriteLine("\n\n__________ASCII__________");
            List<BigInteger> privateKeyList = CreatePrivateKeyList(maxBigIntegerLengthInBits, z);
            Console.WriteLine("\nPrivate key:");
            ShowListBigInteger(privateKeyList);

            BigInteger n = privateKeyList[privateKeyList.Count - 1] * 2 + 1;
            n = GetRandomPrimeBigIntegerBiggerThan(n);
            BigInteger a = 64;
            BigInteger a_inverse = BigInteger.ModPow(a, n - 2, n);
            Console.WriteLine("\n n = " + n + "\n");
            Console.WriteLine("\n a = " + a + "\n");


            List<BigInteger> publicKeyList = CreatePublicKeyList(privateKeyList, a, n);
            Console.WriteLine("\nPublic key:");
            ShowListBigInteger(publicKeyList);

            sw.Start();
            List<BigInteger> encodedMessageASCII = EncodeMessage(message, publicKeyList);
            sw.Stop();
            Console.WriteLine("\nEncoded message:");
            ShowListBigInteger(encodedMessageASCII);
            Console.WriteLine($"Time spent on encryption in milliseconds: {sw.ElapsedMilliseconds}");

            sw.Restart();
            string decodedMessageASCII = DecodeMessage(encodedMessageASCII, privateKeyList, a_inverse, n);
            sw.Stop();
            Console.WriteLine("\nDecoded message:");
            Console.WriteLine(decodedMessageASCII);
            Console.WriteLine($"Time spent on decryption in milliseconds: {sw.ElapsedMilliseconds}");




            Console.WriteLine("\n\n__________BASE64__________");

            z = 8;
            privateKeyList = CreatePrivateKeyList(maxBigIntegerLengthInBits, z);
            Console.WriteLine("\nPrivate key:");
            ShowListBigInteger(privateKeyList);


            n = privateKeyList[privateKeyList.Count - 1] * 2 + 1;
            n = GetRandomPrimeBigIntegerBiggerThan(n);
            a = 31;
            a_inverse = BigInteger.ModPow(a, n - 2, n);
            Console.WriteLine("\n n = " + n + "\n");
            Console.WriteLine("\n a = " + a + "\n");


            publicKeyList = CreatePublicKeyList(privateKeyList, a, n);
            Console.WriteLine("\nPublic key:");
            ShowListBigInteger(publicKeyList);


            string Base64String = Base64Encode(message);
            Console.WriteLine("\nBASE64 string");
            Console.WriteLine(Base64String);


            sw.Restart();
            List<BigInteger> encodedMessageBase64 = EncodeMessage(Base64String, publicKeyList);
            sw.Stop();
            Console.WriteLine("\nEncoded message:");
            ShowListBigInteger(encodedMessageBase64);
            Console.WriteLine($"Time spent on encryption in milliseconds: {sw.ElapsedMilliseconds}");


            sw.Restart();
            string decodedMessageBase64 = DecodeMessage(encodedMessageBase64, privateKeyList, a_inverse, n);
            sw.Stop();
            Console.WriteLine("\nDecoded BASE64 string:");
            Console.WriteLine(decodedMessageBase64);
            Console.WriteLine($"Time spent on decryption in milliseconds: {sw.ElapsedMilliseconds}");

            Console.WriteLine("\nDecoded message:");
            Console.WriteLine(Base64Decode(Base64String));



            Console.ReadLine();
        }


        static void ShowListBigInteger(List<BigInteger> list)
        {
            foreach (var item in list)
            {
                Console.Write(item + " ");
                Console.WriteLine();
            }
        }


        static void ShowListChar(List<char> list)
        {
            foreach (var item in list)
            {
                Console.Write(item + " ");
                Console.WriteLine();
            }
        }


        static int GetIntFromString(string str)
        {
            int ret = 0;
            int bit = 1;
            for (int i = str.Length - 1; i >= 0; i--)
            {
                if (str[i] == '1')
                    ret += bit;
                bit *= 2;
            }
            return ret;
        }


        public static string Base64Encode(string plainText)
        {
            var plainTextBytes = Encoding.ASCII.GetBytes(plainText);
            return Convert.ToBase64String(plainTextBytes);
        }


        public static string Base64Decode(string base64EncodedData)
        {
            var base64EncodedBytes = Convert.FromBase64String(base64EncodedData);
            return Encoding.ASCII.GetString(base64EncodedBytes);
        }


        static BigInteger GetNOD(BigInteger a, BigInteger b)
        {
            while (a != 0 && b != 0)
            {
                if (a > b)
                    a = a % b;
                else
                    b = b % a;
            }
            return (a != 0 ? a : b);
        }


        static BigInteger modInverse(BigInteger a, BigInteger n)
        {

            for (BigInteger x = 1; x < n; x++)
                if (((a % n) * (x % n)) % n == 1)
                    return x;
            return 1;
        }


        public static BigInteger RandomIntegerBelow(BigInteger N)
        {
            byte[] bytes = N.ToByteArray();
            BigInteger R;

            do
            {
                rand.NextBytes(bytes);
                bytes[bytes.Length - 1] &= (byte)0x7F; //force sign bit to positive
                R = new BigInteger(bytes);
            } while (R >= N);

            return R;
        }


        static BigInteger GetRandomBigInteger(int length)
        {
            var rng = new RNGCryptoServiceProvider();
            byte[] bytes = new byte[length];
            rng.GetBytes(bytes);

            BigInteger value = new BigInteger(bytes);

            if (value.Sign == -1)
                value *= -1;

            return value;
        }


        static BigInteger GetRandomPrimeBigInteger()
        {
            var rng = new RNGCryptoServiceProvider();
            byte[] bytes = new byte[512 / 8];
            rng.GetBytes(bytes);

            BigInteger value = new BigInteger(bytes);
            Boolean isPrime = false;

            if (value.Sign == -1)
                value *= -1;

            BigInteger biggerValue = value;
            Boolean isBiggerPrime = false;
            BigInteger lowerValue = value;
            Boolean isLowerPrime = false;
            do
            {
                biggerValue++;
                lowerValue--;
                isBiggerPrime = biggerValue.IsProbablyPrime();
                isLowerPrime = lowerValue.IsProbablyPrime();
                Console.WriteLine(biggerValue);
                Console.WriteLine(lowerValue);
            } while (!isBiggerPrime && !isLowerPrime);
            if (isLowerPrime)
                value = lowerValue;
            if (isBiggerPrime)
                value = biggerValue;
            return value;
        }


        static BigInteger GetRandomPrimeBigIntegerBiggerThan(BigInteger than)
        {
            BigInteger value = than;
            Boolean isPrime = false;

            if (value.Sign == -1)
                value *= -1;

            BigInteger biggerValue = value;
            Boolean isBiggerPrime = false;
            do
            {
                biggerValue++;
                isBiggerPrime = biggerValue.IsProbablyPrime();
            } while (!isBiggerPrime);
            if (isBiggerPrime)
                value = biggerValue;
            return value;
        }


        static List<BigInteger> CreatePrivateKeyList(int maxBigIntegerLengthInBits, int z)
        {
            List<BigInteger> privateKeyList = new List<BigInteger>();
            privateKeyList.Add(GetRandomBigInteger(maxBigIntegerLengthInBits));

            for (int i = 1; i < z; i++)
            {
                privateKeyList.Insert(
                    0,
                    privateKeyList[privateKeyList.Count - i] % 2 == 1 ?
                    ((privateKeyList[privateKeyList.Count - i] - 1) / 2 - 1) : (privateKeyList[privateKeyList.Count - i] / 2 - 1));
            }
            return privateKeyList;
        }


        static List<BigInteger> CreatePublicKeyList(List<BigInteger> privateKeyList, BigInteger a, BigInteger n)
        {
            List<BigInteger> publicKeyList = new List<BigInteger>();
            publicKeyList.AddRange(privateKeyList);
            for (int i = 0; i < publicKeyList.Count; i++)
            {
                publicKeyList[i] = (publicKeyList[i] * a) % n;
            }
            return publicKeyList;
        }


        static List<BigInteger> EncodeMessage(string message, List<BigInteger> publicKeyList)
        {
            List<Byte> Bytes = ascii.GetBytes(message).ToList();
            List<BigInteger> encodedMessageASCII = new List<BigInteger>();
            foreach (var item in Bytes)
            {
                string symbol = Convert.ToString(item, 2);
                BigInteger weight = 0;
                for (int i = 0; i < symbol.Length; i++)
                {
                    if (symbol[symbol.Length - 1 - i] == '1')
                        weight += publicKeyList[publicKeyList.Count - 1 - i];
                }
                encodedMessageASCII.Add(weight);
            }
            return encodedMessageASCII;
        }


        static string DecodeMessage(List<BigInteger> encodedMessage, List<BigInteger> privateKeyList, BigInteger a_inverse, BigInteger n)
        {
            List<string> symbols = new List<string>();
            for (int i = 0; i < encodedMessage.Count; i++)
            {
                string symbol = "";
                BigInteger decodedCode = (encodedMessage[i] * a_inverse) % n;
                for (int j = 0; decodedCode != 0; j++)
                {
                    if (decodedCode - privateKeyList[privateKeyList.Count - 1 - j] >= 0)
                    {
                        decodedCode -= privateKeyList[privateKeyList.Count - 1 - j];
                        symbol = '1' + symbol;
                    }
                    else
                    {
                        symbol = '0' + symbol;
                    }
                }
                symbol = symbol.PadLeft(8, '0');
                symbols.Add(symbol);
            }

            List<byte> symbolsCodes = new List<byte>();
            for (int i = 0; i < symbols.Count; i++)
            {
                symbolsCodes.Add((byte)GetIntFromString(symbols[i]));
            }

            string decodedMessage = "";
            foreach (var item in ascii.GetChars(symbolsCodes.ToArray()))
            {
                decodedMessage += item;
            }
            return decodedMessage;
        }


        static List<BigInteger> EncodeMessageBase64(string message, List<BigInteger> publicKeyList)
        {
            List<Byte> Bytes = Encoding.UTF8.GetBytes(message).ToList();
            List<BigInteger> encodedMessageASCII = new List<BigInteger>();
            foreach (var item in Bytes)
            {
                string symbol = Convert.ToString(item, 2);
                BigInteger weight = 0;
                for (int i = 0; i < symbol.Length; i++)
                {
                    if (symbol[symbol.Length - 1 - i] == '1')
                        weight += publicKeyList[publicKeyList.Count - 1 - i];
                }
                encodedMessageASCII.Add(weight);
            }
            return encodedMessageASCII;
        }


        static string DecodeMessageBase64(List<BigInteger> encodedMessage, List<BigInteger> privateKeyList, BigInteger a_inverse, BigInteger n)
        {
            List<string> symbols = new List<string>();
            for (int i = 0; i < encodedMessage.Count; i++)
            {
                string symbol = "";
                BigInteger decodedCode = (encodedMessage[i] * a_inverse) % n;
                for (int j = 0; decodedCode != 0; j++)
                {
                    if (decodedCode - privateKeyList[privateKeyList.Count - 1 - j] >= 0)
                    {
                        decodedCode -= privateKeyList[privateKeyList.Count - 1 - j];
                        symbol = '1' + symbol;
                    }
                    else
                    {
                        symbol = '0' + symbol;
                    }
                }
                symbol = symbol.PadLeft(8, '0');
                symbols.Add(symbol);
            }

            List<byte> symbolsCodes = new List<byte>();
            for (int i = 0; i < symbols.Count; i++)
            {
                symbolsCodes.Add((byte)GetIntFromString(symbols[i]));
            }

            string decodedMessage = "";
            foreach (var item in Encoding.UTF8.GetChars(symbolsCodes.ToArray()))
            {
                decodedMessage += item;
            }
            return decodedMessage;
        }



    }
}
