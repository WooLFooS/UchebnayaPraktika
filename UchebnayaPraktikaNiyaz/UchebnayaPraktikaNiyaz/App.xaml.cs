using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;
using System.Windows;
using UchebnayaPraktikaNiyaz.Bases;
using UchebnayaPraktikaNiyaz.Pages;

namespace UchebnayaPraktikaNiyaz
{
    /// <summary>
    /// Логика взаимодействия для App.xaml
    /// </summary>
    public partial class App : Application
    {
        public static UchebnayaPraktikaNiyaz2Entities db = new UchebnayaPraktikaNiyaz2Entities();
        public static bool isAdmin = false;
        public static bool isStudent = false;
        public static bool isPrepodovatel = false;
        public static StudentPage sp = new StudentPage();
        public static ExamenPage em = new ExamenPage();
        public static EmployeePage emp = new EmployeePage();
        public static DisciplinePage dp = new DisciplinePage();
    }
}
