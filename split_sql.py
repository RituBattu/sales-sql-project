import re

# input file
input_file = 'sales_project.sql.sql'

# Output files
table_file = "table.sql"
inserts_file = "inserts.sql"
views_file = "views.sql"
theory_file = "theory.sql"   # all comments and explanation

# read the input file

with open(input_file, "r", encoding="utf-8") as f:
    sql = f.read()

# Split by semicolon but keep the semicolon
statements = re.split(r';\s*', sql)
statements = [stmt.strip() + ";" for stmt in statements if stmt.strip()]


#  Prepare container

table = []
insert = []
views = []
theory = []

for stmt in statements:
    stmt_lower = stmt.lower()

    if stmt_lower.startswith("--") or "/*" in stmt_lower:
        theory.append(stmt)

    elif stmt_lower.startswith("create table"):
        table.append(stmt)

    elif stmt_lower.startswith('insert into'):
        insert.append(stmt)

    elif stmt_lower.startswith("create view"):
        views.append(stmt)

    else:
        theory.append(stmt)  #anything unknown goes to this theory 



     # write files
    with open(table_file, "w", encoding='utf-8') as f:
        f.write("\n\n".join(table))


    with open(inserts_file, "w", encoding='utf-8') as f:
        f.write("\n\n".join(insert))           

    with open(views_file, "w", encoding='utf-8') as f:
        f.write("\n\n".join(views))      

    with open(theory_file, "w", encoding='utf-8') as f:
        f.write("\n\n".join(theory))

    print("Splitting completes succesfully")          