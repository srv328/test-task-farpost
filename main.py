from config import authorDB, logsDB
from work_with_DB import check_user_exists_author, check_user_exists_logs, create_comments_csv, create_general_csv


if __name__ == '__main__':
    author = str(input('Введите login юзера для формирования файлов: '))
    if check_user_exists_author(authorDB, author):
        if check_user_exists_logs(logsDB, authorDB, author):
            if create_comments_csv(authorDB, author) and create_general_csv(authorDB, logsDB, author):
                print(f'Файлы comments.csv и general.csv для пользователя "{author}" успешно созданы!')
        else:
            print(f'Пользователя "{author}" нет в базе logs!')
    else:
        print(f'Пользователя "{author}" нет в базе author!')
