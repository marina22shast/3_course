using System;
using System.Numerics;
using System.Text;

namespace lab8
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.OutputEncoding = Encoding.UTF8;
            Console.InputEncoding = Encoding.UTF8;

            Console.WriteLine("______BBS______");
            //p и q -взаимно простые и mod 4 == 3
            BigInteger p = 11;
            BigInteger q = 19;
            BBS generatorBBS = new BBS(p, q);
            string series = string.Empty;

            Console.WriteLine("p= " + p + "\nq= " + q);
            //длина строки, которую нужно сгенерировать
            int SeriesSize = 10;
            Console.WriteLine($"Number of operations = {SeriesSize}");
            //x - рандомная
            series = generatorBBS.GetSeries(SeriesSize);
            Console.WriteLine("String: " + series);


            Console.WriteLine("\n\n______RC4______");
            //keys: 20, 21, 22, 23, 60, 61 
            string message = "Hello world!";
            Console.WriteLine($"message: {message}");

            byte[] keys = ASCIIEncoding.ASCII.GetBytes("20x");
            RC4 encoder = new RC4(keys);
            byte[] encryptedBytes = ASCIIEncoding.ASCII.GetBytes(message);

            byte[] result = encoder.Encode(encryptedBytes, encryptedBytes.Length);
            string encryptedString = ASCIIEncoding.ASCII.GetString(result);

            Console.WriteLine($"Encrypted message: {encryptedString}");

            RC4 decoder = new RC4(keys);

            byte[] decryptedBytes = decoder.Decode(result, result.Length);
            string decryptedString = ASCIIEncoding.ASCII.GetString(decryptedBytes);

            Console.WriteLine($"Decrypted message: {decryptedString}");

            Console.ReadKey();
        }
    }
}
