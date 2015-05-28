create table comments (
id serial8 primary key,
video_id varchar(255),
username varchar(255),
content text
);