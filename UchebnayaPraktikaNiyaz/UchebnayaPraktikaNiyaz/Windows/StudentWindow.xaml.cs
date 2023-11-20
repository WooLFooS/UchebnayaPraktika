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
    /// Логика взаимодействия для StudentWindow.xaml
    /// </summary>
    public partial class StudentWindow : Window
    {
        public StudentWindow()
        {
            InitializeComponent();
        }

        private void SaveBtn_Click(object sender, RoutedEventArgs e)
        {
            Student student = new Student();

            student.Id_Student = Convert.ToInt32(KodStudentTb.Text);
            int rNumber = int.Parse(KodStudentTb.Text);
            if(App.db.Student.Where(x => x.Id_Student == rNumber).FirstOrDefault() != null)
            {
                MessageBox.Show("Такой код уже существует");
                return;
            }
            student.Surname_Student = FIOTb.Text;
            student.Id_Spec = KodSpecTb.Text;
            student.IsDeleted = true;
            App.db.Student.Add(student);
            App.db.SaveChanges();
            this.Close();
            App.sp.StudentList.ItemsSource = App.db.Student.ToList();
        }
    }
}
