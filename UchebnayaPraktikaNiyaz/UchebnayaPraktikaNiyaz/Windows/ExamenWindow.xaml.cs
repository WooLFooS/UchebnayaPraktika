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
    /// Логика взаимодействия для ExamenWindow.xaml
    /// </summary>
    public partial class ExamenWindow : Window
    {
        public ExamenWindow()
        {
            InitializeComponent();
        }

        private void SaveBtn_Click(object sender, RoutedEventArgs e)
        {
            Examen examen = new Examen();
            examen.Student.Id_Student = Convert.ToInt32(KodStudentTb.Text);
            examen.Id_Subject = Convert.ToInt32(DisciplineTb.Text);
            examen.Id_Employee = Convert.ToInt32(PrepodTb.Text);
            examen.Date_Examen = Convert.ToDateTime(DateTb.Text);
            DateTime eNumber = DateTime.Parse(DateTb.Text);
            if (App.db.Examen.Where(x => x.Date_Examen == eNumber).FirstOrDefault() != null)
            {
                MessageBox.Show("Такой код уже существует");
                return;
            }
            examen.Auditory = AuditoriaTb.Text;
            examen.Mark = Convert.ToInt32(OcenkaTb.Text);
            if (Convert.ToInt32(OcenkaTb.Text) > 5 || Convert.ToInt32(OcenkaTb.Text) < 2)
            {
                MessageBox.Show("Оценка должна быть т 2 до 5");
            }
            App.db.Examen.Add(examen);
            App.db.SaveChanges();
            this.Close();
            App.sp.StudentList.ItemsSource = App.db.Student.ToList();
        }
    }
}
