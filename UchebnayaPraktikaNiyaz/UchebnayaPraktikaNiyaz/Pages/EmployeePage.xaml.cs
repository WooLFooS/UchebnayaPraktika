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
using System.Windows.Navigation;
using System.Windows.Shapes;
using UchebnayaPraktikaNiyaz.Bases;
using UchebnayaPraktikaNiyaz.Windows;

namespace UchebnayaPraktikaNiyaz.Pages
{
    /// <summary>
    /// Логика взаимодействия для EmployeePage.xaml
    /// </summary>
    public partial class EmployeePage : Page
    {
        public EmployeePage()
        {
            InitializeComponent();
            EmployeeList.ItemsSource = App.db.Employee.ToList();
            if (!App.isAdmin)
            {
                AddBtn.Visibility = Visibility.Hidden;
            }

        }


        private void Refresh()
        {
            IEnumerable<Employee> SortedEmployee = App.db.Employee;
            if (SortList.SelectedIndex == 0)
            {
                SortedEmployee = SortedEmployee.OrderBy(x => x.Salary);
            }
            else if (SortList.SelectedIndex == 1)
            {
                SortedEmployee = SortedEmployee.OrderByDescending(x => x.Salary);
            }

            if (FiltrList.SelectedIndex == 0)
                SortedEmployee = SortedEmployee.Where(x => x.Salary >= 30000);
            if (FiltrList.SelectedIndex == 1)
                SortedEmployee = SortedEmployee.Where(x => x.Salary < 30000);


            if (SearchTb.Text != null)
            {
                SortedEmployee = SortedEmployee.Where(x => x.Surname.ToLower().Contains(SearchTb.Text.ToLower()));
            }

            EmployeeList.ItemsSource = SortedEmployee.ToList();
        }
        private void SortList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Refresh();
        }

        private void FiltrList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Refresh();
        }

        private void SearchTb_TextChanged(object sender, TextChangedEventArgs e)
        {
            Refresh();
        }

        private void AddBtn_Click(object sender, RoutedEventArgs e)
        {
            new EmployeeWindow().ShowDialog();
        }
    }
}
