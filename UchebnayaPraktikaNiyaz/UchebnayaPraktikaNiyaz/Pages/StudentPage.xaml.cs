using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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
    /// Логика взаимодействия для StudentPage.xaml
    /// </summary>
    public partial class StudentPage : Page
    {
 

        public StudentPage()
        {
            InitializeComponent();
            Refresh();
            if(!App.isAdmin)
            {
                AddBtn.Visibility = Visibility.Hidden;
                DeleteBtn.Visibility = Visibility.Hidden;
                RedaktBtn.Visibility = Visibility.Hidden;
            }
            
        }


        public void Refresh()
        {
            IEnumerable<Student> SortedStudent = App.db.Student;
            if (SortList.SelectedIndex == 0)
            {
                SortedStudent = SortedStudent.OrderBy(x => x.Surname_Student);
            }
            else if(SortList.SelectedIndex == 1)
            {
                SortedStudent = SortedStudent.OrderByDescending(x => x.Surname_Student);
            }

            if (FiltrList.SelectedIndex == 0)
                SortedStudent = SortedStudent.Where(x => x.Specs.Direction == "Прикладная математика");
            if (FiltrList.SelectedIndex == 1)
                SortedStudent = SortedStudent.Where(x => x.Specs.Direction == "Информационные системы и технологии");
            if (FiltrList.SelectedIndex == 2)
                SortedStudent = SortedStudent.Where(x => x.Specs.Direction == "Прикладная информатика");
            if (FiltrList.SelectedIndex == 3)
                SortedStudent = SortedStudent.Where(x => x.Specs.Direction == "Ядерные физика и технологии");
            if (FiltrList.SelectedIndex == 4)
                SortedStudent = SortedStudent.Where(x => x.Specs.Direction == "Бизнес-информатика");

            if(SearchTb.Text != null)
            {
                SortedStudent = SortedStudent.Where(x => x.Surname_Student.ToLower().Contains(SearchTb.Text.ToLower()));
            }

            StudentList.ItemsSource = SortedStudent.ToList().Where(x => x.IsDeleted != Convert.ToBoolean(1));
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
            NavigationService.Navigate(new AddEditStudentPage(new Student(), "add"));
        }

        private void DeleteBtn_Click(object sender, RoutedEventArgs e)
        {
            var student = (Student)StudentList.SelectedItem;
            student.IsDeleted = Convert.ToBoolean(1);
            Refresh();
            App.db.SaveChanges();
        }

        private void RedaktBtn_Click(object sender, RoutedEventArgs e)
        {
            var student = (Student)StudentList.SelectedItem;
            NavigationService.Navigate(new AddEditStudentPage(student, "redact"));
        }
    }
}
