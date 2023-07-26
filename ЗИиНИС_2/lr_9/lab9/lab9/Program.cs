using System;
using System.Diagnostics;
using System.Numerics;
using System.Security.Cryptography;
using System.Text;

namespace lab12
{
    class Program
    {
        static void Main(string[] args)
        {
            Stopwatch sw = new Stopwatch();

            string text = "i am ann";
            Console.WriteLine($"Origin message: {text}");

            //хэшируем сообщение
            SHA512 shaM = new SHA512Managed();
            string messageHash = Encoding.UTF8.GetString(shaM.ComputeHash(Encoding.UTF8.GetBytes(text)));



            //RSA
            Console.WriteLine("\n\n__________RSA__________");
            //подписываем хешированное сообщение
            BigInteger message = new BigInteger(Encoding.UTF8.GetBytes(messageHash));

            sw.Start();
            RSA.GenerateKeys();
            BigInteger encryptedMessage = RSA.Encrypt(message);
            Console.WriteLine($"\nEncrypted hash = {encryptedMessage}\n");

            //дешифруем и сравниваем с хешем
            BigInteger decryptedMessage = RSA.Decrypt(encryptedMessage);
            Console.WriteLine($"\nDecrypted hash = {decryptedMessage}\n");

            //проверка подписи
            Console.WriteLine("Veryfied = " + (messageHash == (Encoding.UTF8.GetString(decryptedMessage.ToByteArray()))));
            sw.Stop();

            Console.WriteLine($"RSA time im milliseconds = {sw.ElapsedMilliseconds}");



            //El Gamal
            Console.WriteLine("\n\n__________El Gamal__________");

            ElGamal elGamal = new ElGamal();

            sw.Restart();
            string encryptedHash = elGamal.Encrypt(messageHash, "");
            Console.WriteLine($"\nEncrypted hash = {encryptedHash}\n");

            string decryptedHash = elGamal.Decrypt(encryptedHash, "privateKey.txt");
            Console.WriteLine($"\nDecrypted hash = {decryptedHash}\n");

            Console.WriteLine("Veryfied = " + (messageHash == decryptedHash));
            sw.Stop();

            Console.WriteLine($"El Gamal time im milliseconds = {sw.ElapsedMilliseconds}");



            //Shnorr
            Console.WriteLine("\n\n__________Shnorr__________");

            Console.InputEncoding = Encoding.ASCII;

            sw.Restart();
            Shnorr.Do();
            sw.Stop();

            Console.WriteLine($"Shnorr time im milliseconds = {sw.ElapsedMilliseconds}");


            Console.ReadLine();
        }
    }
}
