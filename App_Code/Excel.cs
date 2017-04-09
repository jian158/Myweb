using OfficeOpenXml;
using System;
using System.IO;
using System.Linq;

public interface IExcel
{
    /// <summary> 打开文件 </summary>  
    bool Open();
    /// <summary> 文件版本 </summary>  
    ExcelVersion Version { get; }
    /// <summary> 文件路径 </summary>  
    string FilePath { get; set; }
    /// <summary> 文件是否已经打开 </summary>  
    bool IfOpen { get; }
    /// <summary> 文件包含工作表的数量 </summary>  
    int SheetCount { get; }
    /// <summary> 当前工作表序号 </summary>  
    int CurrentSheetIndex { get; set; }
    /// <summary> 获取当前工作表中行数 </summary>  
    int GetRowCount();
    /// <summary> 获取当前工作表中列数 </summary>  
    int GetColumnCount();
    /// <summary> 获取当前工作表中某一行中单元格的数量 </summary>  
    /// <param name="Row">行序号</param>  
    int GetCellCountInRow(int Row);
    /// <summary> 获取当前工作表中某一单元格的值（按字符串返回） </summary>  
    /// <param name="Row">行序号</param>  
    /// <param name="Col">列序号</param>  
    string GetCellValue(int Row, int Col);
    /// <summary> 关闭文件 </summary>  
    void Close();
}

public enum ExcelVersion
{
    /// <summary> Excel2003之前版本 ,xls </summary>  
    Excel03,
    /// <summary> Excel2007版本 ,xlsx  </summary>  
    Excel07
}
public class Excel07 : IExcel
{
    public Excel07()
    { }

    public Excel07(string path)
    { filePath = path; }

    private string filePath = "";
    private ExcelWorkbook book = null;
    private int sheetCount = 0;
    private bool ifOpen = false;
    private int currentSheetIndex = 0;
    private ExcelWorksheet currentSheet = null;
    private ExcelPackage ep = null;

    public bool Open()
    {
        try
        {
            ep = new ExcelPackage(new FileInfo(filePath));

            if (ep == null) return false;
            book = ep.Workbook;
            sheetCount = book.Worksheets.Count;
            currentSheetIndex = 0;
            currentSheet = book.Worksheets[1];
            ifOpen = true;
        }
        catch (Exception ex)
        {
            return false;
        }
        return true;
    }

    public void Close()
    {
        if (!ifOpen || ep == null) return;
        ep.Dispose();
    }

    public ExcelVersion Version
    { get { return ExcelVersion.Excel07; } }

    public string FilePath
    {
        get { return filePath; }
        set { filePath = value; }
    }

    public bool IfOpen
    { get { return ifOpen; } }

    public int SheetCount
    { get { return sheetCount; } }

    public int CurrentSheetIndex
    {
        get { return currentSheetIndex; }
        set
        {
            if (value != currentSheetIndex)
            {
                if (value >= sheetCount)
                    throw new Exception("工作表序号超出范围");
                currentSheetIndex = value;
                currentSheet = book.Worksheets[currentSheetIndex + 1];
            }
        }
    }

    public int GetRowCount()
    {
        if (currentSheet == null) return 0;
        return currentSheet.Dimension.Rows;
        //return currentSheet.Dimension.End.Row;
    }

    public int GetColumnCount()
    {
        if (currentSheet == null) return 0;
        return currentSheet.Dimension.End.Column;
    }

    public int GetCellCountInRow(int Row)
    {
        if (currentSheet == null) return 0;
        if (Row >= currentSheet.Dimension.End.Row) return 0;
        return currentSheet.Dimension.End.Column;
    }

    public string GetCellValue(int Row, int Col)
    {
        if (currentSheet == null) return "";
        if (Row >= currentSheet.Dimension.End.Row || Col >= currentSheet.Dimension.End.Column) return "";
        object tmpO = currentSheet.GetValue(Row + 1, Col + 1);
        if (tmpO == null) return "";
        return tmpO.ToString();
    }
}