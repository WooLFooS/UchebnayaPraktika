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
    /// Логика взаимодействия для AddEditDisciplinePage.xaml
    /// </summary>
    public partial class AddEditDisciplinePage : Page
    {
        public Subject subject;
        public string WhatToDo;
        public AddEditDisciplinePage(Subject _subject,string _WhatToDo)
        {
            InitializeComponent();
            subject = _subject;
            WhatToDo = _WhatToDo;
            this.DataContext = subject;
            LecCb.ItemsSource = App.db.Lectern.ToList();
            LecCb.DisplayMemberPath = "Name_Lectern";

            if (subject.Id_Subject > 0)
            {
                var s = App.db.Lectern.ToList().Where(x => x.Id_Lectern == subject.Id_Lectern).First();
                LecCb.SelectedIndex = LecCb.Items.IndexOf(s);
            }
        }

        private void SaveBtn_Click(object sender, RoutedEventArgs e)
        {
            bool errors = false;
            var selectLec = LecCb.SelectedItem as Lectern;
            if (selectLec == null || NameTb.Text == "" || SizeTb.Text == "")
            {
                errors = true;
                MessageBox.Show("Заполните обязательные данные!");
            }

            if (!errors)
            {
                if (WhatToDo == "add")
                {
                    App.db.Subject.Add(new Subject()
                    {
                        Name_Subject = NameTb.Text,
                        Cize_Subject = int.Parse(SizeTb.Text),
                        Id_Lectern = selectLec.Id_Lectern,
                        IsDeleted = Convert.ToBoolean(0)
                    });
                }
                else subject.Id_Lectern = selectLec.Id_Lectern;
                MessageBox.Show("Сохранено!");
                App.db.SaveChanges();
                NavigationService.Navigate(new DisciplinePage());
            }
        }
    }
}
