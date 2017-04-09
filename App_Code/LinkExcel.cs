using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Ado;

namespace Ado
{
public class LinkExcel
{
    private Excel07 x;
    public bool IsOpen;
    public LinkExcel(string path)
    {
        x = new Excel07(path);
        IsOpen = x.Open();
    }
      public  string  readpkr()
      {
            int i = 0;
            using (var ado = new Adodata())
            {
                
                int row = 1;
                int col = 1;
                while (x.GetCellValue(row, 0) != "")
                {
                    PkrInfo r = new PkrInfo();
                    r.PkrID = Convert.ToInt32(x.GetCellValue(row, 0));
                    r.PkrName = x.GetCellValue(row, 1);
                    r.PkzID = Convert.ToInt32(x.GetCellValue(row, 2));
                    r.PkcID = Convert.ToInt32(x.GetCellValue(row, 3));
                    r.HZID = Convert.ToInt32(x.GetCellValue(row, 4));
                    r.Gender = x.GetCellValue(row, 5);
                    r.Age = Convert.ToInt32(x.GetCellValue(row, 6));
                    r.Education = x.GetCellValue(row, 7);
                    r.IsDisabled = x.GetCellValue(row, 8);
                    r.Home = x.GetCellValue(row, 9);
                    r.IsHuzhu = x.GetCellValue(row, 10);
                    r.Relationship = x.GetCellValue(row, 11);

                    r.TotalNumberR = Convert.ToInt32(x.GetCellValue(row, 12));
                    r.TpYear = x.GetCellValue(row, 13);
                    r.YtpYear = x.GetCellValue(row, 14);
                    r.IsTp = x.GetCellValue(row, 15);
                    r.TpReason = x.GetCellValue(row, 16);
                    r.BbrInfo = x.GetCellValue(row, 17);

                    r.PhotovoltaicIncome = Convert.ToInt32(x.GetCellValue(row, 18));
                    r.CultureIncome = Convert.ToInt32(x.GetCellValue(row, 19));
                    r.BasicIncome = Convert.ToInt32(x.GetCellValue(row, 20));
                    r.subsidyIncome = Convert.ToInt32(x.GetCellValue(row, 21));
                    ado.PkrInfo.Add(r);
                   
                    row = row + 1;
                    //Console.Out.WriteLine("添加一个" + row);
                    try
                    {
                        ado.SaveChanges();
                    }
                    catch (DbUpdateException exception)
                    {
                        i++;
                    }
                }
                
                //Console.Out.WriteLine("添加成功");
                //Console.ReadKey();
            }
           

          string msg = "导入成功" + Convert.ToString(x.GetRowCount() - i - 1) + "个,失败" + Convert.ToString(i) + "个";
            x.Close();
            return msg;
          //Console.ReadKey();
        }

        public string readpkc()
        {
            int i = 0;
            using (var ado = new Adodata())
            {

                int row = 1;
                int col = 1;
                while (x.GetCellValue(row, 0) != "")
                {
                    PkcInfo c = new PkcInfo();
                    c.PkcID = Convert.ToInt32(x.GetCellValue(row, 0));
                    c.PkcName = x.GetCellValue(row, 1);
                    c.PkzID = Convert.ToInt32(x.GetCellValue(row, 2));
                    c.PkcYear = x.GetCellValue(row, 3);
                    c.PkcIndustry = x.GetCellValue(row, 4);
                    c.PkcMember = x.GetCellValue(row, 5);
                    c.TotalNumberH = Convert.ToInt32(x.GetCellValue(row, 6));
                    c.TotalNumberR = Convert.ToInt32(x.GetCellValue(row, 7));
                    c.PhotovoltaicIncome = Convert.ToInt32(x.GetCellValue(row, 8));
                    c.CultureIncome = Convert.ToInt32(x.GetCellValue(row, 9));
                    c.BasicIncome = Convert.ToInt32(x.GetCellValue(row, 10));
                    c.subsidyIncome = Convert.ToInt32(x.GetCellValue(row, 11));
                    ado.PkcInfo.Add(c);
                    row = row + 1;

                    try
                    {
                        ado.SaveChanges();
                    }
                    catch (DbUpdateException exception)
                    {
                        i++;
                    }
                }
            }
           
            string msg = "导入成功" + Convert.ToString(x.GetRowCount() - i - 1) + "个,失败" + Convert.ToString(i) + "个";
            x.Close();
            return msg;
        }

    }


}
