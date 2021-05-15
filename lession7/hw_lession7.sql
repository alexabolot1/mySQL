-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
select 
	orders.id,
	users.name 
from 
	orders
join 
	users
on users.id = orders.user_id;

-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.
select 
	products.name,
	catalogs.name
from
	products
join
	catalogs
on products.catalog_id = catalogs.id;

/*3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
Поля from, to и label содержат английские названия городов, поле name — русское.
 Выведите список рейсов flights с русскими названиями городов. */

-- Создание БД с таблицами
create database flights;

DROP TABLE IF exists flights;
CREATE TABLE flights(
id SERIAL PRIMARY KEY,
`from` VARCHAR(50) NOT NULL COMMENT 'en', 
`to` VARCHAR(50) NOT null) COMMENT 'en';

CREATE TABLE  IF NOT EXISTS cities(
label VARCHAR(50) PRIMARY KEY, 
name VARCHAR(50));

ALTER TABLE flights
ADD CONSTRAINT fk_from_label
FOREIGN KEY(`from`)
REFERENCES cities(label);

ALTER TABLE flights
ADD CONSTRAINT fk_to_label
FOREIGN KEY(`to`)
REFERENCES cities(label);

INSERT INTO cities VALUES
('Moscow', 'Москва'),
('Irkutsk', 'Иркутск'),
('Novgorod', 'Новгород'),
('Kazan', 'Казань'),
('Omsk', 'Омск');

INSERT INTO flights VALUES
(NULL, 'Moscow', 'Omsk'),
(NULL, 'Novgorod', 'Kazan'),
(NULL, 'Irkutsk', 'Moscow'),
(NULL, 'Omsk', 'Irkutsk'),
(NULL, 'Moscow', 'Kazan');

-- Решение задачи
select
	id as flight_id,
	(select name from cities where label = `from`) as `from`,
	(select name from cities where label = `to`) as `to`
from
	flights
join
	cities
group by
	flight_id
order by flight_id;




