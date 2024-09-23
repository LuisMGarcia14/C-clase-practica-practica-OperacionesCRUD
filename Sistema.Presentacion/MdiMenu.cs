using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Sistema.Presentacion
{
    public partial class MdiMenu : Form
    {
        public MdiMenu()
        {
            InitializeComponent();
        }

        private void btnUsuario_Click(object sender, EventArgs e)
        {
            FrmUsuario formulario = new FrmUsuario();
            formulario.MdiParent = this;
            formulario.Show();
        }
    }
}
