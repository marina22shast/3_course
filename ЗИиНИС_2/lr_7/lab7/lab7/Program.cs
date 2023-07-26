using System;
using System.Diagnostics;
using System.Numerics;
using System.Security.Cryptography;
using System.Text;

namespace lab10
{
    class Program
    {
        static void Main(string[] args)
        {
            //Task1();  //good luck with 1024/2048 bits number
            //Create a UnicodeEncoder to convert between byte array and string.
            UnicodeEncoding ByteConverter = new UnicodeEncoding();
            var sw = new Stopwatch();

            string message = "Sheleh Anna";
            Console.WriteLine($"\n\nOriginal message: {message}");

            Console.WriteLine("\n__________RSA__________");
            //Create byte arrays to hold original, encrypted, and decrypted data.
            byte[] dataToEncrypt = ByteConverter.GetBytes(message);
            byte[] encryptedData;
            byte[] decryptedData;

            //Create a new instance of RSACryptoServiceProvider to generate
            //public and private key data.
            using (RSACryptoServiceProvider RSA1 = new RSACryptoServiceProvider())
            {

                //Pass the data to ENCRYPT, the public key information 
                //(using RSACryptoServiceProvider.ExportParameters(false),
                //and a boolean flag specifying no OAEP padding.
                sw.Start();
                encryptedData = RSA.RSAEncrypt(dataToEncrypt, RSA1.ExportParameters(false), false);
                sw.Stop();
                Console.WriteLine("\nRSA encrypted message:");
                ShowBytes(encryptedData);
                Console.WriteLine($"Time spent on encryption in milliseconds: {sw.ElapsedMilliseconds}");
                //Pass the data to DECRYPT, the private key information 
                //(using RSACryptoServiceProvider.ExportParameters(true),
                //and a boolean flag specifying no OAEP padding.
                sw.Restart();
                decryptedData = RSA.RSADecrypt(encryptedData, RSA1.ExportParameters(true), false);
                sw.Stop();
                //Display the decrypted plaintext to the console. 
                Console.WriteLine("\nRSA decrypted message: \n{0}", ByteConverter.GetString(decryptedData));
                Console.WriteLine($"Time spent on decryption in milliseconds: {sw.ElapsedMilliseconds}");
            }

            Console.WriteLine("\n\n__________ElGamal__________");
            sw.Restart();
            string encrypted = ElGamal.Encrypt(message, "privateKey.txt");
            sw.Stop();
            Console.WriteLine("\nElGamal encrypted message:");
            Console.WriteLine(encrypted);
            Console.WriteLine($"Time spent on encryption in milliseconds: {sw.ElapsedMilliseconds}");

            sw.Restart();
            string decrypted = ElGamal.Decrypt(encrypted, "privateKey.txt");
            sw.Stop();
            Console.WriteLine("\nElGamal decrypted message:");
            Console.WriteLine(decrypted);
            Console.WriteLine($"Time spent on decryption in milliseconds: {sw.ElapsedMilliseconds}");

            Console.ReadLine();
        }


        public static void ShowBytes(byte[] bytes)
        {
            foreach (byte item in bytes)
            {
                Console.Write(item.ToString());
            }
            Console.WriteLine();
        }


        public static void Task1()
        {
            int a = 20;

            System.Numerics.BigInteger[] xarr = { System.Numerics.BigInteger.Pow(10, 20),
                                  System.Numerics.BigInteger.Pow(10, 40),
                                  System.Numerics.BigInteger.Pow(10, 60),
                                  System.Numerics.BigInteger.Pow(10, 80),
                                  System.Numerics.BigInteger.Pow(10, 100)};

            var size1 = 1024;
            var size2 = 2048;
            var r1 = new Random();
            var r2 = new Random();
            BigMath.BigInteger n1 = new BigMath.BigInteger(size1, r1);
            BigMath.BigInteger n2 = new BigMath.BigInteger(size2, r2);

            CalculateBigIntegers(a, xarr, n1);
            CalculateBigIntegers(a, xarr, n2);
        }

        public static void CalculateBigIntegers(int a, System.Numerics.BigInteger[] xarr, BigMath.BigInteger n)
        {
            var sw = new Stopwatch();

            Console.WriteLine("____________________");
            Console.WriteLine($"a = {a}");
            Console.WriteLine($"n = {n}");

            foreach (var x in xarr)
            {
                Console.WriteLine($"x = {x}");
                sw.Start();
                Console.WriteLine($"y = {LocalPow(a, x) % n}");
                sw.Stop();
                Console.WriteLine($"Time spent on calculation: {sw.ElapsedMilliseconds}");
                Console.WriteLine("----------");
            }
        }

        public static BigMath.BigInteger LocalPow(int a, System.Numerics.BigInteger x)
        {
            BigMath.BigInteger newa = a;

            for (int i = 0; i < x; i++)
            {
                newa *= newa;
            }

            return newa;
        }
    }
}
