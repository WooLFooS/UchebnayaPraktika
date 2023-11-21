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
    /// Логика взаимодействия для AddEditStudentPage.xaml
    /// </summary>
    public partial class AddEditStudentPage : Page
    {
        public Student student;
        public string WhatToDo;
        public AddEditStudentPage(Student _student, string _whatToDo)
        {
            InitializeComponent();
            student = _student;
            WhatToDo = _whatToDo;
            this.DataContext = student;
            SpecCb.ItemsSource = App.db.Specs.ToList();
            SpecCb.DisplayMemberPath = "Direction";

            if (student.Id_Student > 0)
            {
                var sss = App.db.Specs.ToList().Where(x => x.Id_Spec == student.Id_Spec).First();
                SpecCb.SelectedIndex = SpecCb.Items.IndexOf(sss);
            }
        }

        private void SaveBtn_Click(object sender, RoutedEventArgs e)
        {
            bool errors = false;
            var selectSpec = SpecCb.SelectedItem as Specs;
            if(selectSpec == null || FIOTb.Text == "")
            {
                errors = true;
                MessageBox.Show("Заполните все данные");
            }
            if(!errors)
            {
                if (WhatToDo == "add")
                {
                    App.db.Student.Add(new Student()
                    {
                        Surname_Student = student.Surname_Student,
                        Id_Spec = selectSpec.Id_Spec,
                        IsDeleted = Convert.ToBoolean(0)
                    });
                }
                else student.Id_Spec = selectSpec.Id_Spec;
                MessageBox.Show("Сохранено!");
                App.db.SaveChanges();
                NavigationService.Navigate(new StudentPage());
            }
        }
    }
}
