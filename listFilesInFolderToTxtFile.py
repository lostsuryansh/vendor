#listing all the files in the current directory and storing the results
#into a file_list.txt file

import os

with open("file_list.txt", "w") as outputFile:
	for path, subdirs, files in os.walk(os.path.dirname(os.path.realpath(__file__))):
		for filename in files:
			f = os.path.join(path, filename)
			outputFile.write(str(f) + os.linesep)
