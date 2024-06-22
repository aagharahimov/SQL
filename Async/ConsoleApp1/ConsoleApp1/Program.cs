using System.Security.Cryptography;

namespace Async
{
    public class Program
    {
        public static void Main()
        {
            Thread thread = new Thread(Loop1);
            Thread thread2 = new Thread(Loop2);

            thread.Start();
            thread2.Start();
            
         
        }

        static void Loop1()
        {
            for (int i = 0; i < 100; i++)
            {
                Console.WriteLine(i);
                Thread.Sleep(1);
            }
        }
        static void Loop2()
        {
            for (int i = 0; i < 100; i++)
            {
                Console.WriteLine(i);
            }
        }
    }
}