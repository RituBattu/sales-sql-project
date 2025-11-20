import sys
import os

# Check input file
# Hard-coded SQL file name
input_file = r"C:\Users\erpr2\OneDrive\Documents\sales-sql-project\sales_project.sql.sql"


if not os.path.exists(input_file):
    print("File not found:", input_file)
    sys.exit(1)

# Containers
schema = []
data = []
views = []
analysis = []
misc = []

current_block = []
current_type = "misc"

def flush_block(block, block_type):
    if not block:
        return
    if block_type == "schema":
        schema.extend(block)
    elif block_type == "data":
        data.extend(block)
    elif block_type == "views":
        views.extend(block)
    elif block_type == "analysis":
        analysis.extend(block)
    else:
        misc.extend(block)

with open(input_file, "r", encoding="utf-8") as f:
    for line in f:
        lower = line.strip().lower()

        # Detect beginning of new block
        if lower.startswith("create table"):
            flush_block(current_block, current_type)
            current_block = [line]
            current_type = "schema"

        elif lower.startswith("insert into"):
            flush_block(current_block, current_type)
            current_block = [line]
            current_type = "data"

        elif lower.startswith("create view"):
            flush_block(current_block, current_type)
            current_block = [line]
            current_type = "views"

        elif lower.startswith("select"):
            flush_block(current_block, current_type)
            current_block = [line]
            current_type = "analysis"

        else:
            current_block.append(line)

# Flush leftover block
flush_block(current_block, current_type)

# File writing helper
def write_file(name, content):
    with open(name, "w", encoding="utf-8") as f:
        f.write("".join(content))
    print("Created:", name)

# Write output files
write_file("01_schema.sql", schema)
write_file("02_data.sql", data)
write_file("03_views.sql", views)
write_file("04_analysis.sql", analysis)
write_file("99_misc.sql", misc)

print("\nDone! Files created successfully.")
