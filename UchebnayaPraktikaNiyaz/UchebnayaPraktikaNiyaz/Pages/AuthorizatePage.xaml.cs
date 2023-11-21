using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
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
using static System.Net.WebRequestMethods;




namespace UchebnayaPraktikaNiyaz.Pages
{
    /// <summary>
    /// Логика взаимодействия для AuthorizatePage.xaml
    /// </summary>
    public partial class AuthorizatePage : Page
    {
        public AuthorizatePage()
        {
            InitializeComponent();
        }

        private void EnterBtn_Click(object sender, RoutedEventArgs e)
        {
            var emp = App.db.Employee.Where(x => x.Id_Employee.ToString() == PasswordPb.Password).FirstOrDefault();
            var std = App.db.Student.Where(x => x.Id_Student.ToString() == PasswordPb.Password).FirstOrDefault();
            if (emp != null)
            {
                App.isPrepodovatel = true;
                MessageBox.Show("Good Morning, Teacher");
                Navigation.NextPage(new PageComponent("Экзамены", new ExamenPage()));

            }
            else if (std != null)
            {
                App.isStudent = true;
                MessageBox.Show("Good Morning, Student");
                Navigation.NextPage(new PageComponent("Студент", new StudentPage()));
            }
            else if (PasswordPb.Password == "1718")
            {
                App.isAdmin = true;
                MessageBox.Show("Good Morning, Admin");
                Navigation.NextPage(new PageComponent("Админская", new AdminPage()));
            }
            else
            {
                MessageBox.Show("Sorry, there is no such account");
            }
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            // Ссылка на XL таблицу
            string soucer_xl = "https://www.youtube.com/watch?v=r88nGXjJl2g";
            // Создание переменной библиотеки QRCoder
            QRCoder.QRCodeGenerator qr = new QRCoder.QRCodeGenerator();
            // Присваеваем значиения
            QRCoder.QRCodeData data = qr.CreateQrCode(soucer_xl, QRCoder.QRCodeGenerator.ECCLevel.L);
            // переводим в Qr
            QRCoder.QRCode code = new QRCoder.QRCode(data);
            Bitmap bitmap = code.GetGraphic(100);
            /// Создание картинки
            using (MemoryStream memory = new MemoryStream())
            {
                bitmap.Save(memory, System.Drawing.Imaging.ImageFormat.Bmp);
                memory.Position = 0;
                BitmapImage bitmapimage = new BitmapImage();
                bitmapimage.BeginInit();
                bitmapimage.StreamSource = memory;
                bitmapimage.CacheOption = BitmapCacheOption.OnLoad;
                bitmapimage.EndInit();
                imageQr.Source = bitmapimage;
            }
        }
    }
}
