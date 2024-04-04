# test_task_farpost
this repository includes a test assignment for Farpost for a Python developer position for a summer internship.

# Test task for Python developer direction

During the task execution, it was realized that there is insufficient data for generating the comments.csv file.

The first file comment.csv contains the following information (columns of the final table are listed below):

 - user login,
 - header of the post to which the comment was left,
 - author's login of the post,
 - number of comments

It is impossible to determine which post the comment was left on based on the action in the log from the provided two databases. The first database does not contain any mentions of comments on posts at all.

As an alternative solution, the following ideas arose:

1) Add a comments table, which will contain:
id int (primary key),
text varchar (comment content),
time timestamp (comment writing time),
author_id int (id of the person who left the comment, foreign key),
post_id int (id of the post to which the comment was left, foreign key).

This solution is preferable as it does not disrupt the structure of existing tables.

2) Add the post_id attribute to the logs table from the second database in order to determine which post the comment was left on when the user performs the comment action in the post space.

This solution is less preferable as it restricts the use of the post_id attribute only to comments.

Ideally, it would have been necessary to add not only the post_id field to the logging, but also the blog_id and comment_id fields. They would be used only one at a time for a specific user action (the rest would be NULL). However, there was no task to expand the database, so the decision was made to create the comments table.

The new ER diagram can be seen in the db_scheme_modified file.

Implementation:
The csv and sqlite3 libraries were used to solve the problem.
The config.py file contains variables indicating the path to the sql files for creating the database and the resulting files for the 1st and 2nd databases.
SQL scripts for creating databases are stored in the sql_queries folder, encrypted database files are stored in the db folder.

The CreateDB file is used to create databases and populate them with test data. It is run once, reads queries from the file, splits them by the ';' delimiter, and executes them.
The work_with_DB.py file contains the necessary functions to send queries to the database and work with .csv files.

The main.py file is the main executable file and includes functions described in the work_with_DB.py file. 
The input is a string: user login.
If the user does not exist in the author database, the message "User is not in the author base!" will be displayed.
If the user does not exist in the logs database (the person registered on the site but has not performed any actions, not even "login", this can also happen), the message "User is not in the logs base!" will be displayed.
If an error occurs while writing to either the comments.csv or general.csv file (the file is being used by another application), the message "Failed to write data to the {file_path} file!\nPerhaps it is open." will be displayed, where file_path is the name of the corresponding file.
If records are found in both tables for the user, the message "'Files comments.csv and general.csv for user {author} successfully created!" will be displayed, where author is the entered user's login.

During testing, questions may arise regarding the dates in the logs (for task 2, general.csv), for example: 
user with id 1 (roman) logged into the site on March 17 and logged out on the 24th. It will be considered that there was no need to log in again during this time because the login was made with still active "cookies".
The data for the logs tried to be selected in accordance with the actions of users in the 1st database (tables post, comment), as much as possible.

Usage:
1) Run the CreateDB.py file.
2) Run the main.py file.
3) Enter the user's login (files will be available for roman, kirill, olga, ivan, denis users (a file will not be created for this user since they did not perform any actions)).
4) Obtain two files comments.csv and general.csv.
5) Enjoy the result!
