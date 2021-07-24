# Docker Miniforge Oracle

This repository provides an example on how to Docker to test the development of a Python application that needs to connect to an Oracle DB.

# Start an Oracle XE container
Start an Oracle XE container to be used for testing purposes:

```sh
docker run --name oracle-xe -d -p 1521:1521 oracleinanutshell/oracle-xe-11g
```
Build a docker image based on condaforge/miniforge3 but extented with the Oracle instant client for the connection libraries.

```sh
docker build -t miniforge-oracle .
```

Start Python from the image
```sh
docker run --user 10000:0 --network host -it oracle python
```

Test the connection to Oracle from the python interpreter:
```python
import cx_Oracle
DB_DSN="localhost/xe"
DB_USER="system"
DB_PASS="oracle"

con = cx_Oracle.connect(DB_USER, DB_PASS, DB_DSN)

cur = con.cursor()
cur.execute("SELECT sysdate FROM dual")
res = cur.fetchall()
for row in res:
    print(row)
```