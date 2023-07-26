namespace Steganography
{
    partial class frmMain
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.label12 = new System.Windows.Forms.Label();
            this.btnOpenCodedPic = new System.Windows.Forms.Button();
            this.btnReadTextFromPic = new System.Windows.Forms.Button();
            this.tbOutputText = new System.Windows.Forms.TextBox();
            this.pbOpenedCodedPic = new System.Windows.Forms.PictureBox();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.colorImage2 = new System.Windows.Forms.PictureBox();
            this.colorImage1 = new System.Windows.Forms.PictureBox();
            this.label11 = new System.Windows.Forms.Label();
            this.btnSaveCodedPic = new System.Windows.Forms.Button();
            this.pbCodedPic = new System.Windows.Forms.PictureBox();
            this.btnWriteTextInPic = new System.Windows.Forms.Button();
            this.tbInputText = new System.Windows.Forms.TextBox();
            this.btnOpenOriginalPic = new System.Windows.Forms.Button();
            this.pbOriginalPic = new System.Windows.Forms.PictureBox();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.saveFileDialog1 = new System.Windows.Forms.SaveFileDialog();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.groupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pbOpenedCodedPic)).BeginInit();
            this.tableLayoutPanel1.SuspendLayout();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.colorImage2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.colorImage1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbCodedPic)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbOriginalPic)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.label12);
            this.groupBox2.Controls.Add(this.btnOpenCodedPic);
            this.groupBox2.Controls.Add(this.btnReadTextFromPic);
            this.groupBox2.Controls.Add(this.tbOutputText);
            this.groupBox2.Controls.Add(this.pbOpenedCodedPic);
            this.groupBox2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox2.Location = new System.Drawing.Point(698, 4);
            this.groupBox2.Margin = new System.Windows.Forms.Padding(4);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Padding = new System.Windows.Forms.Padding(4);
            this.groupBox2.Size = new System.Drawing.Size(687, 694);
            this.groupBox2.TabIndex = 2;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Decoder";
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Location = new System.Drawing.Point(265, 566);
            this.label12.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(146, 17);
            this.label12.TabIndex = 31;
            this.label12.Text = "Enter Your Text Here:";
            // 
            // btnOpenCodedPic
            // 
            this.btnOpenCodedPic.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.btnOpenCodedPic.Location = new System.Drawing.Point(297, 20);
            this.btnOpenCodedPic.Margin = new System.Windows.Forms.Padding(4);
            this.btnOpenCodedPic.Name = "btnOpenCodedPic";
            this.btnOpenCodedPic.Size = new System.Drawing.Size(100, 28);
            this.btnOpenCodedPic.TabIndex = 29;
            this.btnOpenCodedPic.Text = "Open Image";
            this.btnOpenCodedPic.UseVisualStyleBackColor = true;
            this.btnOpenCodedPic.Click += new System.EventHandler(this.btnOpenCodedPic_Click);
            // 
            // btnReadTextFromPic
            // 
            this.btnReadTextFromPic.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.btnReadTextFromPic.Location = new System.Drawing.Point(247, 497);
            this.btnReadTextFromPic.Margin = new System.Windows.Forms.Padding(4);
            this.btnReadTextFromPic.Name = "btnReadTextFromPic";
            this.btnReadTextFromPic.Size = new System.Drawing.Size(180, 37);
            this.btnReadTextFromPic.TabIndex = 30;
            this.btnReadTextFromPic.Text = "Read Text From Image";
            this.btnReadTextFromPic.UseVisualStyleBackColor = true;
            this.btnReadTextFromPic.Click += new System.EventHandler(this.btnReadTextFromPic_Click);
            // 
            // tbOutputText
            // 
            this.tbOutputText.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(178)));
            this.tbOutputText.Location = new System.Drawing.Point(109, 613);
            this.tbOutputText.Margin = new System.Windows.Forms.Padding(4);
            this.tbOutputText.Name = "tbOutputText";
            this.tbOutputText.Size = new System.Drawing.Size(457, 34);
            this.tbOutputText.TabIndex = 29;
            // 
            // pbOpenedCodedPic
            // 
            this.pbOpenedCodedPic.Location = new System.Drawing.Point(31, 59);
            this.pbOpenedCodedPic.Margin = new System.Windows.Forms.Padding(4);
            this.pbOpenedCodedPic.Name = "pbOpenedCodedPic";
            this.pbOpenedCodedPic.Size = new System.Drawing.Size(627, 386);
            this.pbOpenedCodedPic.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pbOpenedCodedPic.TabIndex = 0;
            this.pbOpenedCodedPic.TabStop = false;
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 2;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.Controls.Add(this.groupBox2, 1, 0);
            this.tableLayoutPanel1.Controls.Add(this.groupBox1, 0, 0);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 30);
            this.tableLayoutPanel1.Margin = new System.Windows.Forms.Padding(4);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 1;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(1389, 702);
            this.tableLayoutPanel1.TabIndex = 1;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.colorImage2);
            this.groupBox1.Controls.Add(this.colorImage1);
            this.groupBox1.Controls.Add(this.label11);
            this.groupBox1.Controls.Add(this.btnSaveCodedPic);
            this.groupBox1.Controls.Add(this.pbCodedPic);
            this.groupBox1.Controls.Add(this.btnWriteTextInPic);
            this.groupBox1.Controls.Add(this.tbInputText);
            this.groupBox1.Controls.Add(this.btnOpenOriginalPic);
            this.groupBox1.Controls.Add(this.pbOriginalPic);
            this.groupBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox1.Location = new System.Drawing.Point(4, 4);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(4);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(4);
            this.groupBox1.Size = new System.Drawing.Size(686, 694);
            this.groupBox1.TabIndex = 1;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Encoder";
            // 
            // colorImage2
            // 
            this.colorImage2.Location = new System.Drawing.Point(354, 426);
            this.colorImage2.Margin = new System.Windows.Forms.Padding(4);
            this.colorImage2.Name = "colorImage2";
            this.colorImage2.Size = new System.Drawing.Size(324, 213);
            this.colorImage2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.colorImage2.TabIndex = 30;
            this.colorImage2.TabStop = false;
            // 
            // colorImage1
            // 
            this.colorImage1.Location = new System.Drawing.Point(354, 59);
            this.colorImage1.Margin = new System.Windows.Forms.Padding(4);
            this.colorImage1.Name = "colorImage1";
            this.colorImage1.Size = new System.Drawing.Size(324, 213);
            this.colorImage1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.colorImage1.TabIndex = 29;
            this.colorImage1.TabStop = false;
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(96, 293);
            this.label11.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(146, 17);
            this.label11.TabIndex = 28;
            this.label11.Text = "Enter Your Text Here:";
            // 
            // btnSaveCodedPic
            // 
            this.btnSaveCodedPic.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.btnSaveCodedPic.Location = new System.Drawing.Point(126, 656);
            this.btnSaveCodedPic.Margin = new System.Windows.Forms.Padding(4);
            this.btnSaveCodedPic.Name = "btnSaveCodedPic";
            this.btnSaveCodedPic.Size = new System.Drawing.Size(100, 28);
            this.btnSaveCodedPic.TabIndex = 27;
            this.btnSaveCodedPic.Text = "Save Image";
            this.btnSaveCodedPic.UseVisualStyleBackColor = true;
            this.btnSaveCodedPic.Click += new System.EventHandler(this.btnSaveCodedPic_Click);
            // 
            // pbCodedPic
            // 
            this.pbCodedPic.Location = new System.Drawing.Point(12, 426);
            this.pbCodedPic.Margin = new System.Windows.Forms.Padding(4);
            this.pbCodedPic.Name = "pbCodedPic";
            this.pbCodedPic.Size = new System.Drawing.Size(324, 213);
            this.pbCodedPic.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pbCodedPic.TabIndex = 15;
            this.pbCodedPic.TabStop = false;
            // 
            // btnWriteTextInPic
            // 
            this.btnWriteTextInPic.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.btnWriteTextInPic.Location = new System.Drawing.Point(88, 383);
            this.btnWriteTextInPic.Margin = new System.Windows.Forms.Padding(4);
            this.btnWriteTextInPic.Name = "btnWriteTextInPic";
            this.btnWriteTextInPic.Size = new System.Drawing.Size(155, 28);
            this.btnWriteTextInPic.TabIndex = 3;
            this.btnWriteTextInPic.Text = "Write Text In Image";
            this.btnWriteTextInPic.UseVisualStyleBackColor = true;
            this.btnWriteTextInPic.Click += new System.EventHandler(this.btnWriteTextInPic_Click);
            // 
            // tbInputText
            // 
            this.tbInputText.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(178)));
            this.tbInputText.Location = new System.Drawing.Point(12, 326);
            this.tbInputText.Margin = new System.Windows.Forms.Padding(4);
            this.tbInputText.Name = "tbInputText";
            this.tbInputText.Size = new System.Drawing.Size(322, 34);
            this.tbInputText.TabIndex = 2;
            // 
            // btnOpenOriginalPic
            // 
            this.btnOpenOriginalPic.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.btnOpenOriginalPic.Location = new System.Drawing.Point(126, 20);
            this.btnOpenOriginalPic.Margin = new System.Windows.Forms.Padding(4);
            this.btnOpenOriginalPic.Name = "btnOpenOriginalPic";
            this.btnOpenOriginalPic.Size = new System.Drawing.Size(100, 28);
            this.btnOpenOriginalPic.TabIndex = 1;
            this.btnOpenOriginalPic.Text = "Open Image";
            this.btnOpenOriginalPic.UseVisualStyleBackColor = true;
            this.btnOpenOriginalPic.Click += new System.EventHandler(this.btnOpenOriginalPic_Click);
            // 
            // pbOriginalPic
            // 
            this.pbOriginalPic.Location = new System.Drawing.Point(12, 59);
            this.pbOriginalPic.Margin = new System.Windows.Forms.Padding(4);
            this.pbOriginalPic.Name = "pbOriginalPic";
            this.pbOriginalPic.Size = new System.Drawing.Size(324, 213);
            this.pbOriginalPic.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pbOriginalPic.TabIndex = 0;
            this.pbOriginalPic.TabStop = false;
            // 
            // openFileDialog1
            // 
            this.openFileDialog1.FileName = "openFileDialog1";
            // 
            // menuStrip1
            // 
            this.menuStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(1389, 30);
            this.menuStrip1.TabIndex = 2;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1389, 732);
            this.Controls.Add(this.tableLayoutPanel1);
            this.Controls.Add(this.menuStrip1);
            this.MainMenuStrip = this.menuStrip1;
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "frmMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Steganography";
            this.Load += new System.EventHandler(this.frmMain_Load);
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pbOpenedCodedPic)).EndInit();
            this.tableLayoutPanel1.ResumeLayout(false);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.colorImage2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.colorImage1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbCodedPic)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbOriginalPic)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.PictureBox pbOpenedCodedPic;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.OpenFileDialog openFileDialog1;
        private System.Windows.Forms.SaveFileDialog saveFileDialog1;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.Button btnOpenCodedPic;
        private System.Windows.Forms.Button btnReadTextFromPic;
        private System.Windows.Forms.TextBox tbOutputText;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.Button btnSaveCodedPic;
        private System.Windows.Forms.PictureBox pbCodedPic;
        private System.Windows.Forms.Button btnWriteTextInPic;
        private System.Windows.Forms.TextBox tbInputText;
        private System.Windows.Forms.Button btnOpenOriginalPic;
        private System.Windows.Forms.PictureBox pbOriginalPic;
        private System.Windows.Forms.PictureBox colorImage2;
        private System.Windows.Forms.PictureBox colorImage1;
    }
}

