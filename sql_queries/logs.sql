CREATE TABLE IF NOT EXISTS space_type (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(6) NOT NULL
);

CREATE TABLE IF NOT EXISTS event_type(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date_time DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    user_id INTEGER NOT NULL,
    space_type_id INTEGER,
    event_type_id INTEGER,
    FOREIGN KEY (space_type_id) REFERENCES space_type(id) ON DELETE CASCADE,
    FOREIGN KEY (event_type_id) REFERENCES event_type(id) ON DELETE CASCADE
);

INSERT INTO space_type (name) VALUES
	('global'),
	('blog'),
	('post');

INSERT INTO event_type (name) VALUES
	('login'),
	('comment'),
	('create_post'),
	('delete_post'),
	('logout');
    
INSERT INTO logs (date_time, user_id, space_type_id, event_type_id) VALUES 
	-- логин
    ('2024-03-16 08:00:10', 1, 1, 1),
    ('2024-03-16 08:05:47', 2, 1, 1),
    ('2024-03-16 08:05:49', 3, 1, 1),
    ('2024-03-16 08:10:23', 4, 1, 1),
    -- выход
    ('2024-03-16 08:10:24', 1, 1, 5),
    ('2024-03-16 08:10:25', 2, 1, 5),
    ('2024-03-16 08:10:26', 3, 1, 5),
    ('2024-03-16 08:10:27', 4, 1, 5),
    -- логин
    ('2024-03-17 08:00:10', 1, 1, 1),
    ('2024-03-17 08:05:47', 2, 1, 1),
    ('2024-03-17 08:05:49', 3, 1, 1),
    ('2024-03-17 08:10:23', 4, 1, 1),
    -- создание постов
    ('2024-03-17 09:11:38', 1, 2, 3),
    ('2024-03-17 09:25:24', 2, 2, 3),
    ('2024-03-17 09:49:02', 3, 2, 3),
    ('2024-03-17 09:49:03', 3, 2, 3),
    ('2024-03-17 09:49:04', 3, 2, 3),
    -- комментирование
    ('2024-03-17 09:50:01', 1, 3, 2),
    ('2024-03-17 09:50:12', 1, 3, 2),
    ('2024-03-17 09:51:23', 2, 3, 2),
    ('2024-03-17 10:52:32', 2, 3, 2),
    ('2024-03-18 11:12:12', 2, 3, 2),
    ('2024-03-18 11:13:32', 2, 3, 2),
    ('2024-03-18 11:14:47', 2, 3, 2),
    ('2024-03-18 12:03:49', 3, 3, 2),
    ('2024-03-19 13:45:51', 3, 3, 2),
    ('2024-03-19 13:46:21', 3, 3, 2),
    ('2024-03-19 13:47:24', 3, 3, 2),
    ('2024-03-19 15:11:26', 3, 3, 2),
    ('2024-03-20 15:13:42', 4, 3, 2),
    ('2024-03-21 20:21:12', 4, 3, 2),
    ('2024-03-21 21:30:49', 4, 3, 2),
    ('2024-03-21 22:10:59', 4, 3, 2),
    -- удаление постов
    ('2024-03-22 22:12:28', 1, 2, 4),
    ('2024-03-23 22:21:42', 2, 2, 4),
    ('2024-03-23 22:44:32', 3, 2, 4),
    ('2024-03-23 23:10:32', 2, 2, 4),
    ('2024-03-23 23:11:42', 3, 2, 4),
    -- выход
    ('2024-03-24 23:24:12', 1, 1, 5),
    ('2024-03-24 23:26:32', 2, 1, 5),
    ('2024-03-24 23:39:49', 3, 1, 5),
    ('2024-03-24 23:47:24', 4, 1, 5);
