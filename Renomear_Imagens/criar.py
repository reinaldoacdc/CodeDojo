import os
import sys
import xlrd
import logging
import shutil
from datetime import datetime

workbook = xlrd.open_workbook('C:/Temp/excel.xlsx')
sheet = workbook.sheet_by_index(0)

data = [[sheet.cell_value(r, c) for c in range(sheet.ncols)] for r in range(sheet.nrows)]

i=2
while i < len(data):
  open(str('C:/Temp/Images/' + data[i][0]), 'a').close()
  i+=1

