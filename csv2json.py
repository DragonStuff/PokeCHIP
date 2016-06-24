import csv
import sys, getopt

def main(argv):
   inputfile = ''
   outputfile = ''
   try:
      opts, args = getopt.getopt(argv,"hi:o:",["ifile=","ofile="])
   except getopt.GetoptError:
      print 'test.py -i <inputfile> -o <outputfile>'
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print 'test.py -i <inputfile> -o <outputfile>'
         sys.exit()
      elif opt in ("-i", "--ifile"):
         inputfile = arg
      elif opt in ("-o", "--ofile"):
         outputfile = arg
   print 'Input file is "', inputfile
   print 'Output file is "', outputfile
   jsfile = file(inputfile+'.json', 'w')
   jsfile.write('[\r\n')

   with open(inputfile,'r') as f:
       next(f) # skip headings
       reader=csv.reader(f,delimiter='\t')
       # get the total number of rows excluded the heading
       row_count = len(list(reader))
       ite = 0

       # back to first position
       f.seek(0)
       next(f) # skip headings
        
       for id,identifier,generation_id,is_main_series in reader:
           ite+= 1      
           jsfile.write('\t{\r\n') 
           
           n = '\t\t\"id\": \"' + id + '\",\r\n'
           i = '\t\t\"identifier\": \"' + identifier + '\",\r\n'
           d = '\t\t\"generation_id\": \"' + generation_id + '\"\r\n'
           e = '\t\t\"is_main_series\": \"' + is_main_series + '\"\r\n'
           jsfile.write(n)
           jsfile.write(i)
           jsfile.write(d)
           jsfile.write(e)
           jsfile.write('\t}')

           # omit comma for last row item
           if ite < row_count:
               jsfile.write(',\r\n')

           jsfile.write('\r\n')

   jsfile.write(']')
   jsfile.close()

if __name__ == '__main__':
    main(sys.argv[1:])
