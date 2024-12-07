-- Создание таблицы Books
CREATE TABLE Books (
    book_id INTEGER PRIMARY KEY, -- Уникальный идентификатор книги
    title VARCHAR(255) NOT NULL, -- Название книги
    author VARCHAR(255) NOT NULL, -- Автор книги
    price DECIMAL(10, 2) NOT NULL, -- Цена книги
    quantity INT NOT NULL -- Количество книг в наличии
);

INSERT INTO Books(book_id, title, author, price, quantity)
VALUES (1, 'Number', 'David', 100, 20);

-- Создание таблицы Customers
CREATE TABLE Customers (
    customer_id INTEGER PRIMARY KEY, -- Уникальный идентификатор клиента
    name VARCHAR(255) NOT NULL, -- Имя клиента
    email VARCHAR(255) NOT NULL -- Email клиента
);

-- Создание таблицы Orders
CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY, -- Уникальный идентификатор заказа
    book_id INTEGER NOT NULL, -- ID книги (внешний ключ)
    customer_id INTEGER NOT NULL, -- ID клиента (внешний ключ)
    order_date DATE NOT NULL, -- Дата заказа
    quantity INT NOT NULL, -- Количество заказанных книг
    FOREIGN KEY (book_id) REFERENCES Books (book_id), -- Связь с таблицей Books
    FOREIGN KEY (customer_id) REFERENCES Customers (customer_id) -- Связь с таблицей Customers
);

BEGIN;
INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
VALUES (1, 1, 101, CURRENT_DATE, 2);
UPDATE Books
SET quantity = quantity - 2
WHERE book_id = 1;
COMMIT;


BEGIN;
DO $$
BEGIN
    IF (SELECT quantity FROM Books WHERE book_id = 3) >= 10 THEN
        INSERT INTO Orders (customer_id, book_id, quantity, order_date)
        VALUES (101, 1, 2, CURRENT_DATE);
        UPDATE Books
        SET quantity = quantity - 10
        WHERE book_id = 3;
    ELSE
        RAISE EXCEPTION 'Недостаточно книг на складе';
    END IF;
END $$;
COMMIT;


SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN;
UPDATE Books
SET price = price + 10
WHERE book_id = 1;
COMMIT;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN;
SELECT price FROM Books WHERE book_id = 1;
COMMIT;


BEGIN;
UPDATE Customers
SET email = 'newemail@example.com'
WHERE customer_id = 101;
COMMIT;
SELECT * FROM Customers WHERE customer_id = 101;
