using System;
using System.Diagnostics;
using System.Security.Cryptography;
using System.Text;

namespace lab11
{
    class Program
    {
        static void Main(string[] args)
        {
            Stopwatch sw = new Stopwatch();

            string message = "ShstovskayaMarina";

            //for(int i = 0; i < 7; i++)
            //{
            //    message += message;
            //}

            Console.WriteLine($"Start message: {message}");

            sw.Start();

            Console.WriteLine("\nMessage bytes:");
            foreach (var item in Encoding.UTF8.GetBytes(message))
            {
                Console.Write(item.ToString("X"));
            }
            Console.WriteLine();

            SHA512 shaM = new SHA512Managed();
            message = Encoding.UTF8.GetString(shaM.ComputeHash(Encoding.UTF8.GetBytes(message)));

            Console.WriteLine("\nHash string:");
            Console.WriteLine(message);

            Console.WriteLine("\nHash in bytes:");
            foreach (var item in Encoding.UTF8.GetBytes(message))
            {
                Console.Write(item.ToString("X"));
            }

            sw.Stop();

            Console.WriteLine($"\n\nHashing time in milliseconds: {sw.ElapsedMilliseconds}\n");

        }
    }
}
