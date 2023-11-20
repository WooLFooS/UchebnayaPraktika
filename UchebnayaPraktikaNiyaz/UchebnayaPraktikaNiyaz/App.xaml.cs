using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;
using System.Windows;
using UchebnayaPraktikaNiyaz.Bases;

namespace UchebnayaPraktikaNiyaz
{
    /// <summary>
    /// Логика взаимодействия для App.xaml
    /// </summary>
    public partial class App : Application
    {
        public static UchebnayaPraktikaNiyazEntities db = new UchebnayaPraktikaNiyazEntities();
        public static bool isAdmin = false;
        public static bool isStudent = false;
        public static bool isPrepodovatel = false;
    }
}
