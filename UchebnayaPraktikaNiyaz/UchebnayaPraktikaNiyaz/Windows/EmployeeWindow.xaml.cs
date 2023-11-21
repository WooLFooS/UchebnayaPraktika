using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using UchebnayaPraktikaNiyaz.Bases;

namespace UchebnayaPraktikaNiyaz.Windows
{
    /// <summary>
    /// Логика взаимодействия для EmployeeWindow.xaml
    /// </summary>
    public partial class EmployeeWindow : Window
    {
        public EmployeeWindow()
        {
            InitializeComponent();
        }

        private void SaveBtn_Click(object sender, RoutedEventArgs e)
        {
            Employee employee = new Employee();
            employee.Id_Employee = Convert.ToInt32(KodSotrTb.Text);
            int rNumber = int.Parse(KodSotrTb.Text);
            if (App.db.Employee.Where(x => x.Id_Employee == rNumber).FirstOrDefault() != null)
            {
                MessageBox.Show("Такой код уже существует");
                return;
            }
            employee.Surname = FIOTb.Text;
            employee.Id_Lectern = KodKafTb.Text;
            employee.Salary = Convert.ToDecimal(OkladTb.Text);
            App.db.Employee.Add(employee);
            App.db.SaveChanges();
            this.Close();
            App.emp.EmployeeList.ItemsSource = App.db.Employee.ToList();
        }
    }
}
