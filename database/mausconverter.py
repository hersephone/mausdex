filename = 'abilities'
with open(filename + '.csv', 'r') as srcfile:
    columns = srcfile.readline().strip()
    rows = []
    for line in srcfile:
        rows.append("\nINSERT INTO " + filename + " (" + columns + ") VALUES (" + line.strip() + ");")
with open('insertion script.sql', 'a') as destfile:
    for row in rows:
        destfile.write(row);