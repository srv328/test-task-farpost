CREATE TABLE IF NOT EXISTS author (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email VARCHAR(255) UNIQUE,
    login VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS blog (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    owner_id INTEGER,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES author(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS post (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    header VARCHAR(255) NOT NULL,
    text VARCHAR(255) NOT NULL,
    author_id INTEGER,
    blog_id INTEGER,
    FOREIGN KEY (author_id) REFERENCES author(id) ON DELETE CASCADE,
    FOREIGN KEY (blog_id) REFERENCES blog(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS author_comment (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    text VARCHAR(255) NOT NULL,
    date_time DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    author_id INTEGER,
    post_id INTEGER,
    FOREIGN KEY (author_id) REFERENCES author(id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES post(id) ON DELETE CASCADE
);

INSERT INTO author (email, login) VALUES
	('почта1@пример.ру', 'roman'),
	('почта2@пример.ру', 'kirill'),
	('почта3@пример.ру', 'olga'),
	('почта4@пример.ру', 'ivan'),
	('почта5@пример.ру', 'denis');

INSERT INTO blog (owner_id, name, description) VALUES
	(1, 'блог 1 автора 1', 'описание 1'),
	(1, 'блог 2 автора 1', 'описание 2'),
	(2, 'блог 1 автора 2', 'описание 3'),
	(3, 'блог 1 автора 3', 'описание 4');

INSERT INTO post (header, text, author_id, blog_id) VALUES
	('Заголовок поста 1', 'Текст поста 1', 1, 1),
	('Заголовок поста 2', 'Текст поста 2', 2, 2),
	('Заголовок поста 3', 'Текст поста 3', 3, 3),
	('Заголовок поста 4', 'Текст поста 4', 2, 2),
	('Заголовок поста 5', 'Текст поста 5', 3, 4);

INSERT INTO author_comment (text, author_id, post_id) VALUES
	('Комментарий 1', 1, 2),
	('Комментарий 2', 1, 1),
	('Комментарий 3', 2, 1),
	('Комментарий 4', 2, 1),
	('Комментарий 5', 2, 2),
	('Комментарий 6', 2, 2),
	('Комментарий 7', 2, 2),
	('Комментарий 8', 3, 3),
	('Комментарий 9', 3, 2),
	('Комментарий 10', 3, 2),
	('Комментарий 11', 3, 2),
	('Комментарий 12', 3, 2),
	('Комментарий 13', 4, 3),
	('Комментарий 14', 4, 3),
	('Комментарий 15', 4, 3),
	('Комментарий 16', 4, 4);
