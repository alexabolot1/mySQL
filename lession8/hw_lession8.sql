-- 3.Определить кто больше поставил лайков (всего) - мужчины или женщины?
select count(likes.id) as likes, gender
	from users
		join profiles
			on users.id = profiles.user_id
		join likes
			on users.id = likes.user_id
	group by gender
	order by likes desc
	limit 1;

-- 4.Вывести для каждого пользователя количество созданных сообщений, постов, загруженных медиафайлов и поставленных лайков.
select concat(first_name, ' ', last_name) as user,
	count(distinct(messages.id)) as messages, 
	count(distinct(posts.id)) as posts,
	count(distinct(likes.id)) as likes,
	count(distinct(media.id)) as media
	from users
		left join messages
			on users.id = messages.from_user_id 
		left join posts	
			on users.id = posts.user_id
		left join likes
			on users.id = likes.user_id
		left join media 
			on users.id = media.user_id
	group by user
	order by user;	
	
-- 5.Подсчитать количество лайков которые получили 10 самых последних сообщений.
select count(*) as total_likes 
	from likes
		join (select * from messages order by created_at desc limit 10) as messages
			on likes.target_id = messages.id and target_type = 'messages';

 