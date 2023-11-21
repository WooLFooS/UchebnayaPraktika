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
    /// Логика взаимодействия для DisciplinePage.xaml
    /// </summary>
    public partial class DisciplinePage : Page
    {
        public DisciplinePage()
        {
            InitializeComponent();
            Refresh();
        }

        private void Refresh()
        {
            IEnumerable<Subject> SortedEmployee = App.db.Subject;
            if (SortList.SelectedIndex == 0)
            {
                SortedEmployee = SortedEmployee.OrderBy(x => x.Lectern.Name_Lectern);
            }
            else if (SortList.SelectedIndex == 1)
            {
                SortedEmployee = SortedEmployee.OrderByDescending(x => x.Lectern.Name_Lectern);
            }


            if (FiltrList.SelectedIndex == 0)
            {
                SortedEmployee = SortedEmployee.OrderBy(x => x.Lectern.Faculty.Name_Faculty);
            }
            else if (FiltrList.SelectedIndex == 1)
            {
                SortedEmployee = SortedEmployee.OrderByDescending(x => x.Lectern.Faculty.Name_Faculty);
            }


            if (SearchTb.Text != null)
            {
                SortedEmployee = SortedEmployee.Where(x => x.Name_Subject.ToLower().Contains(SearchTb.Text.ToLower()));
            }

            DisciplineList.ItemsSource = SortedEmployee.ToList().Where(x => x.IsDeleted != Convert.ToBoolean(1));
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
            NavigationService.Navigate(new AddEditDisciplinePage(new Subject(), "add"));
        }

        private void DeleteBtn_Click(object sender, RoutedEventArgs e)
        {
            var discipline = (Subject)DisciplineList.SelectedItem;
            discipline.IsDeleted = Convert.ToBoolean(1);
            Refresh();
            App.db.SaveChanges();
        }

        private void RedaktBtn_Click(object sender, RoutedEventArgs e)
        {
            var discipline = (Subject)DisciplineList.SelectedItem;
            NavigationService.Navigate(new AddEditDisciplinePage(discipline, "redact"));
        }
    }
}
