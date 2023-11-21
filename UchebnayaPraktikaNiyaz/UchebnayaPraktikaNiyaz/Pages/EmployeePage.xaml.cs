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
            Refresh();
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

            EmployeeList.ItemsSource = SortedEmployee.ToList().Where(x => x.IsDeleted != Convert.ToBoolean(1)); ;
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
            var employee = new Employee();
            NavigationService.Navigate(new AddEditEmployeePage(employee, "add"));
        }

        private void DeleteBtn_Click(object sender, RoutedEventArgs e)
        {
            var employee = (Employee)EmployeeList.SelectedItem;
            if (employee.Chief != employee.Id_Employee)
            {
                employee.IsDeleted = Convert.ToBoolean(1);
                Refresh();
                App.db.SaveChanges();
            }
            else
                MessageBox.Show("Вы не можете удалять другого админа");
        }

        private void RedaktBtn_Click(object sender, RoutedEventArgs e)
        {
            var employee = (Employee)EmployeeList.SelectedItem;
            if (employee == null)
                MessageBox.Show("Для редактирования выберите данные!");
            else
                NavigationService.Navigate(new AddEditEmployeePage(employee, "redact"));
        }
    }
}
