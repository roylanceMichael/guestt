-- populate blogs and blog owners with me (roylance.michael@gmail.com)
delete from guestt.blog_statuses where blog_id = (select id from guestt.blogs where name = 'ichi');
delete from guestt.blog_statuses where blog_id = (select id from guestt.blogs where name = 'ni');
delete from guestt.blog_statuses where blog_id = (select id from guestt.blogs where name = 'san');

delete from guestt.blogs where name = 'ichi';
delete from guestt.blogs where name = 'ni';
delete from guestt.blogs where name = 'san';

insert into guestt.blogs (name, url, user_email)
select 'ichi', 'http://something.com', 'roylance.michael@gmail.com';

insert into guestt.blogs (name, url, user_email)
select 'ni', 'http://something.com', 'roylance.michael@gmail.com';

insert into guestt.blogs (name, url, user_email)
select 'san', 'http://something.com', 'roylance.michael@gmail.com';

insert into guestt.blog_statuses(blog_id, status, date)
select id as blog_id, 'pending', now() from guestt.blogs where name = 'ichi';

insert into guestt.blog_statuses(blog_id, status, date)
select id as blog_id, 'approved', now() from guestt.blogs where name = 'ichi';

insert into guestt.blog_statuses(blog_id, status, date)
select id as blog_id, 'pending', now() from guestt.blogs where name = 'ni';

insert into guestt.blog_statuses(blog_id, status, date)
select id as blog_id, 'rejected', now() from guestt.blogs where name = 'ni';

insert into guestt.blog_statuses(blog_id, status, date)
select id as blog_id, 'pending', now() from guestt.blogs where name = 'san';