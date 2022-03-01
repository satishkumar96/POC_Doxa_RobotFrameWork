import openpyxl


def fetch_login_excel(sheetname, row, col):
    file_path = './customLibrary/getdata.xlsx'
    workbook = openpyxl.load_workbook(file_path)
    worksheet = workbook.get_sheet_by_name(sheetname)
    cell = worksheet.cell(row, col)
    return cell.value
