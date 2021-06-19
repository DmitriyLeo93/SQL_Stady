CREATE TABLE IF NOT EXISTS orders
(
ИДЕНТИФИКАТОР SERIAL PRIMARY KEY,
orders_id INT NOT NULL,
promocode_id INT,
CHECK ("orders_id" > 0)
);

CREATE TABLE IF NOT EXISTS promocodes
(
ИДЕНТИФИКАТОР SERIAL PRIMARY KEY,
promocode_id INT NOT NULL,
"name" VARCHAR(100) NOT NULL,
discount SMALLINT NOT NULL,
CHECK ("discount" > 0)
)

/*Запрос SQL_1 (Доля заказов с промокодами)*/

SELECT ((SELECT COUNT(*) FROM Orders WHERE promocode_id !=0) * 100 /(SELECT COUNT(*) FROM Orders))

/*Запрос SQL_2 (Самый популярный промокод (название) и число его использований)*/

SELECT promocodes.name, COUNT(orders.promocode_id) FROM orders
INNER JOIN promocodes ON orders.promocode_id = promocodes.promocode_id
GROUP BY promocodes.name
ORDER BY COUNT(orders.promocode_id) DESC
LIMIT 1;


CREATE TABLE IF NOT EXISTS consumption
(
ИДЕНТИФИКАТОР SERIAL PRIMARY KEY,
coffee_point_id INT NOT NULL,
cookies INT,
CHECK (coffee_point_id > 0)
);

CREATE TABLE IF NOT EXISTS buildings
(
ИДЕНТИФИКАТОР SERIAL PRIMARY KEY,
coffee_point_id INT NOT NULL,
coffee_point_name VARCHAR(32) NOT NULL,
office_id INT NOT NULL,
office_name VARCHAR(32) NOT NULL,
CHECK (coffee_point_id > 0)
);

/*Запрос SQL (Топ-10 офисов по потреблению печенек среди офисов, которые потребляют менее 1000 печенек)*/

SELECT buildings.office_name, SUM(cookies)
FROM consumption
INNER JOIN buildings ON consumption.coffee_point_id = buildings.coffee_point_id
GROUP BY buildings.office_name
HAVING SUM(cookies)<1000
ORDER BY SUM(cookies) DESC
LIMIT 10;