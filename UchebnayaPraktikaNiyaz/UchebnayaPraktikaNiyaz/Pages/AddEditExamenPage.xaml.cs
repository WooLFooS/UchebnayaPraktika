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
    /// Логика взаимодействия для AddEditExamenPage.xaml
    /// </summary>
    public partial class AddEditExamenPage : Page
    {
        public Examen examen;
        public AddEditExamenPage(Examen _examen)
        {
            InitializeComponent();
            examen = _examen;
            this.DataContext = examen;
            DatePck.DisplayDateStart = new DateTime(2014, 01, 01);

            MarkTb.MaxLength = 1;

            SubjectCb.ItemsSource = App.db.Subject.ToList().Where(x => x.IsDeleted == Convert.ToBoolean(0));
            SubjectCb.DisplayMemberPath = "Name_Subject";

            StudentCb.ItemsSource = App.db.Student.ToList().Where(x => x.IsDeleted == Convert.ToBoolean(0));
            StudentCb.DisplayMemberPath = "Surname_Student";

            TeacherCb.ItemsSource = App.db.Employee.ToList().Where(x => x.IsDeleted == Convert.ToBoolean(0));
            TeacherCb.DisplayMemberPath = "Surname";

            if (examen.Id_Examen > 0)
            {
                var b = App.db.Student.ToList().Where(x => x.Id_Student == examen.Id_Student).First();
                StudentCb.SelectedIndex = StudentCb.Items.IndexOf(b);
                var a = App.db.Subject.ToList().Where(x => x.Id_Subject == examen.Id_Subject).First();
                SubjectCb.SelectedIndex = SubjectCb.Items.IndexOf(a);
                var c = App.db.Employee.ToList().Where(x => x.Id_Employee == examen.Id_Employee).First();
                TeacherCb.SelectedIndex = TeacherCb.Items.IndexOf(c);
            }
            if (examen.Id_Examen == 0)
            {
                examen.Date_Examen = DateTime.Now;
            }
        }

        private void SaveBtn_Click(object sender, RoutedEventArgs e)
        {
            bool errors = false;
            var selectStudent = StudentCb.SelectedItem as Student;
            var selectTeacher = TeacherCb.SelectedItem as Employee;
            var selectSubject = SubjectCb.SelectedItem as Subject;
            if (string.IsNullOrEmpty(AuditoryTb.Text) || selectStudent == null || selectTeacher == null || selectSubject == null)
            {
                MessageBox.Show("Заполните данные!");
                errors = true;
            }
            if ((MarkTb.Text == "" || char.IsDigit(char.Parse(MarkTb.Text))) && !errors)
            {
                if (int.Parse(MarkTb.Text) > 5 || int.Parse(MarkTb.Text)
       < 1)
                {
                    MessageBox.Show("Неправильный формат оценки!");
                    errors = true;
                }
            }
            else
            { MessageBox.Show("Неправильный формат оценки!"); errors = true; }

            if (examen.Id_Examen == 0 && !errors)
            {
                if (App.db.Examen.Any(x => x.Date_Examen == examen.Date_Examen && x.Id_Student == examen.Id_Student && x.Id_Subject == examen.Id_Subject))
                {
                    MessageBox.Show("Повторение!!1!");
                    errors = true;
                }
                else
                {

                    App.db.Examen.Add(new Examen()
                    {
                        Date_Examen = examen.Date_Examen,
                        Id_Subject = selectSubject.Id_Subject,
                        Id_Student = selectStudent.Id_Student,
                        Id_Employee = selectTeacher.Id_Employee,
                        Auditory = examen.Auditory,
                        Mark = examen.Mark,
                        IsDeleted = Convert.ToBoolean(0)    
                    });
                }
            }
            if (!errors)
            {
                examen.Id_Subject = selectSubject.Id_Subject;
                examen.Id_Student = selectStudent.Id_Student;
                examen.Id_Employee = selectTeacher.Id_Employee;
                App.db.SaveChanges();
                MessageBox.Show("Сохранено!");
                NavigationService.Navigate(new ExamenPage());
            }
        }
    }
}
