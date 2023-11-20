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

namespace UchebnayaPraktikaNiyaz.Pages
{
    /// <summary>
    /// Логика взаимодействия для ExamenPage.xaml
    /// </summary>
    public partial class ExamenPage : Page
    {
        public ExamenPage()
        {
            InitializeComponent();
            ExamenP.ItemsSource = App.db.Examen.ToList();
            if (!App.isAdmin)
            {
                AddBtn.Visibility = Visibility.Hidden;
            }

        }

        private void SortList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void FiltrList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void SearchTb_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void AddBtn_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
