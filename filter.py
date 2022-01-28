import sys
file = sys.argv[1]
lines = open(file, 'r').readlines()
fd = open(file, 'w')
for line in lines:
	# skip directives
	if line[0] == '\t' and line[1] == '.':
		continue
	# skip comments
	if line[0] == '#':
		continue
	# skip unused label
	if line.startswith('.Lfunc_end'):
		continue
	print(line, end='', file=fd)