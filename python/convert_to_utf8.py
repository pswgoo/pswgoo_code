# convert files to utf-8 coding
import os
import codecs
import chardet

filenames = os.listdir(os.getcwd())
utf8path = "utf8/"

if not os.path.exists(utf8path): 
	os.makedirs(utf8path)

errorlist = []
for i in xrange(len(filenames)):
	if (i & 63) == 0:
		print '\r' + str(i) + " converting"
	filename = filenames[i]
	if os.path.isfile(filename) and filename[-4:] == ".txt":
		input = open(filename)
		data = input.read()
		input.close()
		try:
			codetype = chardet.detect(data)["encoding"]
			if type(codetype) == type(None):
				codetype = "gb2312"
			data = data.decode(codetype)
		except UnicodeDecodeError or TypeError:
			print filename + " error"
			errorlist.append(filename)
			data = ""
		if len(data) > 0:
			out = file(utf8path + filename,"w")
			out.write(data.encode("utf-8")) # .decode("gb2312")
			out.close()

print '\n' + "completed"
print "there ",len(errorlist), " occur error"
out = file("errorlist.list", "w")
for l in errorlist: 
	out.write(l + '\n')
out.close()
