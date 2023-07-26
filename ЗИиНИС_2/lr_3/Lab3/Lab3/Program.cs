﻿using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace lab4
{
    class Program
    {
        static void Main(string[] args)
        {
            EnigmaMachine machine = new EnigmaMachine();
            EnigmaSettings eSettings = new EnigmaSettings();

            querySettings(eSettings);

            string message = "";
            Console.Write("Enter message to encrypt: ");
            message = Console.ReadLine();
            while (!Regex.IsMatch(message, @"^[a-zA-Z ]+$"))
            {
                Console.Write("Only letters A-Z is allowed, try again: ");
                message = Console.ReadLine();
            }
            message = message.Replace(" ", "").ToUpper();

            // Задаем настройки машины
            machine.setSettings(eSettings.rings, eSettings.grund, eSettings.order, eSettings.reflector);

            // The plugboard settings
            foreach (string plug in eSettings.plugs)
            {
                char[] p = plug.ToCharArray();
                machine.addPlug(p[0], p[1]);
            }
            Console.WriteLine();
            Console.WriteLine("Plain text:\t" + message);
            string enc = machine.runEnigma(message);
            Console.WriteLine("Encrypted:\t" + enc);

            // Сбрасываем настройки перед дешифрованием
            machine.setSettings(eSettings.rings, eSettings.grund, eSettings.order, eSettings.reflector);
            string dec = machine.runEnigma(enc);
            Console.WriteLine("Decrypted:\t" + dec);
            Console.WriteLine();

            Console.ReadLine();
        }

        private static void querySettings(EnigmaSettings e)
        {
            string r;
            Console.WriteLine("______Enigma Machine______");
            Console.WriteLine("Type of left Rotor: II");
            Console.WriteLine("Type of middle Rotor: B");
            Console.WriteLine("Type of right Rotor: VIII");
            Console.WriteLine("Type of Reflector: С");
            Console.WriteLine("Step L-M-R: 0-2-2");
            e.setDefault();
            Console.WriteLine();
        }
        private class EnigmaSettings
        {
            public char[] rings { get; set; }
            public char[] grund { get; set; }
            public string order { get; set; }
            public char reflector { get; set; }
            public List<string> plugs = new List<string>();

            public EnigmaSettings()
            {
                setDefault();
            }

            public void setDefault()
            {
                rings = new char[] { 'A', 'A', 'A' };
                grund = new char[] { 'B', 'A', 'A' };
                order = "VIII-II-IV";
                reflector = 'C';
                plugs.Clear();
            }
        }
    }
}
