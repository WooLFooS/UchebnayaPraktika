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
using UchebnayaPraktikaNiyaz.Pages;

namespace UchebnayaPraktikaNiyaz.Windows
{
    /// <summary>
    /// Логика взаимодействия для DisciplineWindow.xaml
    /// </summary>
    public partial class DisciplineWindow : Window
    {
        public DisciplineWindow()
        {
            InitializeComponent();
        }

        private void SaveBtn_Click(object sender, RoutedEventArgs e)
        {
            Subject discipline = new Subject();

            discipline.Cize_Subject = Convert.ToInt32(ObemTb.Text);
            discipline.Name_Subject = NazvanieTb.Text;
            discipline.Id_Lectern = KodKafedraTb.Text;

            App.db.Subject.Add(discipline);
            App.db.SaveChanges();
            this.Close();
            App.dp.DisciplineList.ItemsSource = App.db.Subject.ToList();
        }
    }
}
