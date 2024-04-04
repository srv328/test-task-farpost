import csv
import sqlite3


def execute_queries(database_path, path_or_query, is_file, *params):
    connection = sqlite3.connect(database_path)
    cursor = connection.cursor()
    try:
        if is_file:
            with open(path_or_query, 'r', encoding='utf-8') as file:
                queries = file.read().split(';')
            for query in queries:
                cursor.execute(query)
            connection.commit()
            return
        else:
            cursor.execute(path_or_query, params)
        connection.commit()
        return cursor.fetchall()
    finally:
        connection.close()


def check_user_exists_author(author_path, author) -> bool:
    query = 'SELECT id FROM author WHERE login = ?'
    result = execute_queries(author_path, query, False, author)
    if result and len(result) > 0 and result[0][0] > 0:
        return True
    return False


def check_user_exists_logs(logs_path, author_path, author) -> bool:
    query_to_authors = 'SELECT id FROM author WHERE login = ?'
    user_id = execute_queries(author_path, query_to_authors, False, author)
    if user_id and len(user_id) > 0:
        query_to_logs = 'SELECT COUNT(*) FROM logs WHERE user_id = ?'
        result = execute_queries(logs_path, query_to_logs, False, user_id[0][0])
        if result and len(result) > 0 and result[0][0] > 0:
            return True
    return False


def create_comments_csv(author_path, author) -> bool:
    query_to_comment = '''SELECT 
                              author.login AS author_login,
                              post.header AS post_header,
                              (SELECT author.login FROM author WHERE author.id = post.author_id) AS post_author_login,
                              COUNT(*) AS comment_count
                          FROM post
                          JOIN author_comment ON post.id = author_comment.post_id
                          JOIN author ON author_comment.author_id = author.id
                          WHERE author.login = ?
                          GROUP BY post.id'''
    
    data = execute_queries(author_path, query_to_comment, False, author)
    headers = ['логин', 'заголовок поста', 'логин автора поста', 'кол-во комментариев пользователя на этом посте']
    return write_to_csv('comments.csv', data, headers)


def create_general_csv(author_path, logs_path, author) -> bool:
    query_to_authors = 'SELECT id FROM author WHERE login = ?'
    user_id = execute_queries(author_path, query_to_authors, False, author)[0][0]
    query_to_logs = '''SELECT
                           DATE(date_time) AS date,
                           SUM(CASE WHEN event_type.name = 'login' THEN 1 ELSE 0 END) AS login_count,
                           SUM(CASE WHEN event_type.name = 'logout' THEN 1 ELSE 0 END) AS logout_count,
                           SUM(CASE WHEN space_type.name = 'blog' THEN 1 ELSE 0 END) AS blog_action_count
                       FROM logs
                       JOIN event_type ON event_type_id = event_type.id
                       JOIN space_type ON space_type_id = space_type.id
                       WHERE user_id = ?
                       GROUP BY DATE(date_time)'''

    data = execute_queries(logs_path, query_to_logs, False, user_id)
    headers = ['дата', 'кол-во входов на сайт', 'кол-вы выходов с сайта', 'кол-во действий внутри блога']
    return write_to_csv('general.csv', data, headers)


def write_to_csv(file_path, data, headers) -> bool:
    try:
        with open(file_path, 'w', newline='') as csvfile:
            writer = csv.writer(csvfile)
            writer.writerow(headers)
            for row in data:
                writer.writerow(row)
        return True
    except PermissionError:
        print(f'Не удалось записать данные в файл {file_path}!\nВозможно, он открыт.')
        return False
