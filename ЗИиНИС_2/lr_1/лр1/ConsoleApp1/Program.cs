using System;
using System.Diagnostics;
using System.Linq;

namespace lab2
{
    class Program
    {
        static void Main(string[] args)
        {
            var sw = new Stopwatch();

            //you can use VigenereCipher with 3 languages: EN(Pendoski), GE(Germany), RU(Russian)
            Console.WriteLine("__________Vigenere__________");
            VigenereCipher cipher = new VigenereCipher();
            string language = "GE";
            string message = "Shastovskaya";
            string key = "Shastov";
            Console.WriteLine($"Start message: {message}\nLanguage: {language}\nKey: {key}");

            sw.Start();
            string encryptedText = cipher.Encrypt(language, message, key);
            sw.Stop();
            Console.WriteLine("Encrypted message: {0}", encryptedText);
            Console.WriteLine($"Time spent on encryption in milliseconds: {sw.ElapsedMilliseconds}\n");

            sw.Start();
            string decryptedText = cipher.Decrypt(language, encryptedText, key);
            sw.Restart();
            Console.WriteLine("Decrypted message: {0}", decryptedText);
            Console.WriteLine($"Time spent on decryption in milliseconds: {sw.ElapsedMilliseconds}\n\n");


            Console.WriteLine("__________Trisemus__________");
            Console.WriteLine($"Start message: {message}\n");
            Console.WriteLine($"Key: {key}\n");

            sw.Restart();
            string encryptedMessageByTrisemus = TrisemusEncryptionOfGerman(key, message);
            sw.Stop();
            Console.WriteLine($"\nEncrypted message using the Trisemus method: {encryptedMessageByTrisemus}\n");
            Console.WriteLine($"Time spent on encryption in milliseconds: {sw.ElapsedMilliseconds}\n");
            sw.Restart();
            string decryptedMessageByTrisemus = TrisemusDecryptionOfGerman(key, encryptedMessageByTrisemus);
            sw.Stop();
            Console.WriteLine($"Decrypted message using the Trisemus method: {decryptedMessageByTrisemus}\n");
            Console.WriteLine($"Time spent on decryption in milliseconds: {sw.ElapsedMilliseconds}\n\n");


            Console.WriteLine("Frequency characteristics of the original message:");
            MessageFrequencyCalculation(message);
            Console.WriteLine("Frequency characteristics of an encrypted message using the Vigenère method:");
            MessageFrequencyCalculation(encryptedText);
            Console.WriteLine("Frequency characteristics of an encrypted message using the Trisemus method:");
            MessageFrequencyCalculation(encryptedMessageByTrisemus);

            Console.ReadLine();
        }

        public class VigenereCipher
        {
            //alphabets
            const string RUalphabet = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ";
            const string ENalphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            const string GEalphabet = "abcdefghijklmnopqrstuvwxyzäöüß";
            public string alphabet;

            //key generation
            private string GetRepeatKey(string s, int n)
            {
                var p = s;
                while (p.Length < n)
                {
                    p += p;
                }
                return p.Substring(0, n);
            }

            private string EncryptDecrypt(string language, string text, string key, bool encrypting = true)
            {
                if (language == "RU")
                {
                    alphabet = RUalphabet;
                }
                else if (language == "EN")
                {
                    alphabet = ENalphabet;
                }
                else if (language == "GE")
                {
                    alphabet = GEalphabet;
                }
                var fullAlphabet = alphabet + alphabet.ToLower();
                var gKey = GetRepeatKey(key, text.Length);
                var returnValue = "";
                var q = fullAlphabet.Length;
                for (int i = 0; i < text.Length; i++)
                {
                    var letterIndex = fullAlphabet.IndexOf(text[i]);
                    var codeIndex = fullAlphabet.IndexOf(gKey[i]);
                    if (letterIndex < 0)
                    {
                        //if the symbol is not found, then add it unchanged
                        returnValue += text[i].ToString();
                    }
                    else
                    {
                        returnValue += fullAlphabet[(q + letterIndex + ((encrypting ? 1 : -1) * codeIndex)) % q].ToString();
                    }
                }
                return returnValue;
            }

            //text encryption
            public string Encrypt(string language, string plainMessage, string key)
                => EncryptDecrypt(language, plainMessage, key);

            //text decryption
            public string Decrypt(string language, string encryptedMessage, string key)
                => EncryptDecrypt(language, encryptedMessage, key, false);
        }


        public static string TrisemusEncryptionOfGerman(string key, string message)
        {
            string alphabet = "abcdefghijklmnopqrstuvwxyzäöüß";
            string alphabetWithKey = "";
            string temp = alphabet;
            int rows = 5;
            string[] tableOfTrisemus = new string[rows];
            string encryptedMessage = "";

            for (int i = 0; i < key.Length; i++)
            {
                if (alphabetWithKey.Length > 0)
                {
                    for (int j = 0; j < alphabetWithKey.Length; j++)
                    {
                        if (alphabetWithKey[j] != key[i])
                        {
                            alphabetWithKey += key[i];
                            break;
                        }
                    }
                }
                else
                {
                    alphabetWithKey += key[i];
                }
            }
            int counter = 0;
            for (int i = 0; i < alphabet.Length; i++)
            {
                for (int j = 0; j < alphabetWithKey.Length; j++)
                {
                    if (alphabet[i] == alphabetWithKey[j])
                    {
                        temp = temp.Remove(i - counter, 1);
                        counter++;
                        break;
                    }
                }
            }
            //Console.WriteLine(temp);
            alphabetWithKey += temp;

            Console.WriteLine(alphabet + " - исходный немецкий алфавит");
            Console.WriteLine(alphabetWithKey + " - немецкий алфавит с ключевым словом: " + key + "\n");

            for (int i = 0; i < tableOfTrisemus.Length; i++)
            {
                int count = 0;
                for (int j = i * 6; j < alphabetWithKey.Length; j++)
                {
                    if (count < 6)
                    {
                        tableOfTrisemus[i] += alphabetWithKey[j];
                        count++;
                    }
                    else
                    {
                        break;
                    }
                }
            }
            Console.WriteLine("Таблица Трисемуса:");
            for (int i = 0; i < tableOfTrisemus.Length; i++)
            {
                Console.WriteLine(tableOfTrisemus[i]);
            }

            for (int i = 0; i < message.Length; i++)
            {
                for (int j = 0; j < tableOfTrisemus.Length; j++)
                {
                    for (int k = 0; k < tableOfTrisemus[j].Length; k++)
                    {
                        if (message[i] == tableOfTrisemus[j][k])
                        {
                            if (j == 4)
                            {
                                encryptedMessage += tableOfTrisemus[0][k];
                            }
                            else
                            {
                                encryptedMessage += tableOfTrisemus[j + 1][k];
                            }
                        }
                    }
                }
            }

            return encryptedMessage;
        }


        public static string TrisemusDecryptionOfGerman(string key, string encryptedMessage)
        {
            string alphabet = "abcdefghijklmnopqrstuvwxyzäöüß";
            string alphabetWithKey = "";
            string temp = alphabet;
            int rows = 5;
            string[] tableOfTrisemus = new string[rows];
            string decryptedMessage = "";

            for (int i = 0; i < key.Length; i++)
            {
                if (alphabetWithKey.Length > 0)
                {
                    for (int j = 0; j < alphabetWithKey.Length; j++)
                    {
                        if (alphabetWithKey[j] != key[i])
                        {
                            alphabetWithKey += key[i];
                            break;
                        }
                    }
                }
                else
                {
                    alphabetWithKey += key[i];
                }
            }
            int counter = 0;
            for (int i = 0; i < alphabet.Length; i++)
            {
                for (int j = 0; j < alphabetWithKey.Length; j++)
                {
                    if (alphabet[i] == alphabetWithKey[j])
                    {
                        temp = temp.Remove(i - counter, 1);
                        counter++;
                        break;
                    }
                }
            }
            //Console.WriteLine(temp);
            alphabetWithKey += temp;

            for (int i = 0; i < tableOfTrisemus.Length; i++)
            {
                int count = 0;
                for (int j = i * 6; j < alphabetWithKey.Length; j++)
                {
                    if (count < 6)
                    {
                        tableOfTrisemus[i] += alphabetWithKey[j];
                        count++;
                    }
                    else
                    {
                        break;
                    }
                }
            }

            for (int i = 0; i < encryptedMessage.Length; i++)
            {
                for (int j = 0; j < tableOfTrisemus.Length; j++)
                {
                    for (int k = 0; k < tableOfTrisemus[j].Length; k++)
                    {
                        if (encryptedMessage[i] == tableOfTrisemus[j][k])
                        {
                            if (j == 0)
                            {
                                decryptedMessage += tableOfTrisemus[4][k];
                            }
                            else
                            {
                                decryptedMessage += tableOfTrisemus[j - 1][k];
                            }
                        }
                    }
                }
            }

            return decryptedMessage;
        }


        public static void MessageFrequencyCalculation(string str)
        {
            var res = str
                .GroupBy(c => c)
                .ToDictionary(g => g.Key, g => g.Count());
            //foreach (var ch in res)
            //{
            //    Console.WriteLine("'" + ch.Key + "'" + " : " + ch.Value);
            //}
            //Console.WriteLine();
            foreach (var ch in res)
            {
                Console.Write("'" + ch.Key + "'" + " : ");
                for (int i = 0; i < ch.Value; i++)
                {
                    Console.Write("*");
                }
                Console.WriteLine();
            }
        }


    }
}
