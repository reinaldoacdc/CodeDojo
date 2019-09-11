import os
import sys
import xlrd
import logging
import shutil
from datetime import datetime

def main():

  print("**************************************************")
  print("*                                                *")
  print("*                                                *")
  print("*                                                *")
  print("*         RENOMEADOR DE IMAGENS                  *")
  print("*                                                *")
  print("*  Desenvolvido por: REINALDO ACDC               *")
  print("*  Email: reinaldoacdc@gmail.com                 *")
  print("*  Contato: (11) 96838-9078                      *")
  print("*                                                *")
  print("*                                                *")
  print("*                                                *")
  print("**************************************************")


  logging.basicConfig(filename='test.log',  level=logging.DEBUG)

  file_location = raw_input("Digite o caminho do arquivo Excel: ")
  print(file_location)
  if not os.path.isfile(file_location):
    print("Arquivo nao encontrado")
    sys.exit(0)

  diretorio = raw_input("Digite o caminho da pasta Raiz das Imagens: ")
  if not os.path.isdir(diretorio):
    print("Diretorio nao encontrado.")
    sys.exit(0)

  dst = raw_input("Digite o caminho da pasta para salvas as Imagens: ")
  if not os.path.isdir(diretorio):
    print("Diretorio nao encontrado.")
    sys.exit(0)

  workbook = xlrd.open_workbook(file_location)
  sheet = workbook.sheet_by_index(0)

  data = [[sheet.cell_value(r, c) for c in range(sheet.ncols)] for r in range(sheet.nrows)]

  print( "Registros: " + str(len(data)) )
  i=2
  renomeados = 0
  notfound = 0
  found = False;

  while i < len(data):
    try:
      arquivo = str(data[i][0])
      found = False;
      for root, dirs, files in os.walk(diretorio):
        for filename in files:
          if filename == arquivo:
            found = True;
            arq_dst = root + '//' + str(int(data[i][1])) + ".jpg"
            print( "Renomeando: " + str(data[i][0]) +" para: " + str(data[i][1]) )			
            os.rename( root + '//' + str(data[i][0]), arq_dst)
            shutil.move(arq_dst, dst )
            renomeados += 1
            break
      if found == False:
        notfound +=1
        logging.warning("Linha: " + str(i) + " Arquivo: " + str(data[i][0]) )
      i=i+1
    except ValueError:
      print( "EXCECAO DE CONVERSAO - " + str(data[i][1])  )	  
      os.rename( root + '//' + str(data[i][0]), root + '//' + str(data[i][1]) + ".jpg")
      shutil.move(root + '//' + str(data[i][1]) + ".jpg", dst)
      print("Renomeando: " + str(data[i][0]) + " para: " + str(data[i][1]))
      renomeados+=1
      i+=1
      continue
    except OSError:
      print (" EXCECAO - ARQUIVO NAO ENCONTRADO: " + str(data[i][0]) )
      i+=1
      continue
  i+=1

  print(5*"-" + "RESULTADO" + 5*"-")

  print( str(datetime.now()) + " Arquivos renomeados: " + str(renomeados))
  logging.info(str(datetime.now()) +" Arquivos renomeados: " + str(renomeados))
  print(str(datetime.now()) + " Arquivos nao encontrados: " + str(notfound))
  logging.info(str(datetime.now()) + " Arquivos nao encontrados: " + str(notfound))
  if notfound > 0:
    print("Verifique o Log para possiveis arquivos nao renomeados.")
  input("Pressione ENTER para sair")

if __name__ == "__main__":
    main()
