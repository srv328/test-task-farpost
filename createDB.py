from config import authorSQL, authorDB, logsDB, logsSQL 
from work_with_DB import execute_queries


if __name__ == '__main__':
    execute_queries(authorDB, authorSQL, True)
    execute_queries(logsDB, logsSQL, True)
