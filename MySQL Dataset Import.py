import pandas as pd
from sqlalchemy import create_engine

# MySQL connection string
conn_string = 'mysql+pymysql://username:manimaran@localhost:3306/painting'

# Create the engine
db = create_engine(conn_string)
conn = db.connect()

# List of CSV files to be imported
files = ['artist', 'canvas_size', 'image_link', 'museum_hours', 'museum', 'product_size', 'subject', 'work']

# Load and write each CSV file into the MySQL database
for file in files:
    # Use the file name to dynamically read the correct CSV
    df = pd.read_csv(f'C:\\Users\\avina.AVINASH\\Downloads\\archive\\{file}.csv')
    df.to_sql(file, con=conn, if_exists='replace', index=False)

# Close the connection
conn.close()
