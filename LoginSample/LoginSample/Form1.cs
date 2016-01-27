using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace LoginSample
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            SqlConnection connectToapp=new SqlConnection("Server=dfc2c027-37db-4cbb-b8ba-a59a0104aec9.sqlserver.sequelizer.com;Database=dbdfc2c02737db4cbbb8baa59a0104aec9;User ID=hztalkqdfmjcmbup;Password=WzQGVzz5fAuYBfru2SVQkuBRVftKGzGL85ZCkA2YDY3adWNhncmSqfAB68UQgXwN");
            connectToapp.Open();
            SqlCommand querryApp = new SqlCommand("insert into Login values('"+textBox1.Text+"','"+textBox2.Text+"')",connectToapp);
            querryApp.ExecuteNonQuery();
            connectToapp.Close();

        }
    }
}
