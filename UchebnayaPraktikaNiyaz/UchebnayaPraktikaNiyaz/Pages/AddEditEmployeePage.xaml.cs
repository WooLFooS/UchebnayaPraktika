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


namespace UchebnayaPraktikaNiyaz.Pages
{
    /// <summary>
    /// Логика взаимодействия для AddEditEmployeePage.xaml
    /// </summary>
    /// 
    public partial class AddEditEmployeePage : Page
    {
        public Employee employee;
        public string WhatToDo;
        public AddEditEmployeePage(Employee _employee, string _WhatToDo)
        {
            InitializeComponent();
            employee = _employee;
            WhatToDo = _WhatToDo;
            this.DataContext = employee;
            LecternCb.ItemsSource = App.db.Lectern.ToList();
            LecternCb.DisplayMemberPath = "Name_Lectern";
            PositionCb.ItemsSource = App.db.Position.ToList(); PositionCb.DisplayMemberPath = "Position_Name";
            if (employee.Id_Employee > 0)
            {
                var b = App.db.Lectern.ToList().Where(x => x.Id_Lectern == employee.Id_Lectern).First();
                LecternCb.SelectedIndex = LecternCb.Items.IndexOf(b); 
                var a = App.db.Position.ToList().Where(x => x.Id_Position == employee.Id_Position).First();
                PositionCb.SelectedIndex = PositionCb.Items.IndexOf(a);
            }
        }

        private void SaveButt_Click(object sender, RoutedEventArgs e)
        {
            bool errors = false; 
            var selectLectern = LecternCb.SelectedItem as Lectern;
            var selectPosition = PositionCb.SelectedItem as Position;
            if (selectLectern == null || selectPosition == null || FioTb.Text == "" || SalaryTb.Text == "")
            {
                errors = true;
                MessageBox.Show("Заполните обязательные данные!");
            }
            if (!errors)
            {
                if (WhatToDo == "add")
                {
                    if (employee.Stage != null)
                    {
                        App.db.Employee.Add(new Employee()
                        {
                            Stage = int.Parse(StageTb.Text),
                        });
                    }
                    App.db.Employee.Add(new Employee()
                    {
                        Id_Lectern = selectLectern.Id_Lectern,
                        Surname = FioTb.Text,
                        Id_Position = selectPosition.Id_Position,
                        Salary = decimal.Parse(SalaryTb.Text),
                        IsDeleted = Convert.ToBoolean(0)
                    });
                }
                employee.Id_Lectern = selectLectern.Id_Lectern;
                employee.Id_Position = selectPosition.Id_Position;
                MessageBox.Show("Сохранено!");
                App.db.SaveChanges();
                NavigationService.Navigate(new EmployeePage());
            }
        }
    }
}
