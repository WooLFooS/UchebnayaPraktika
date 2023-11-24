--Практика 2
--1.	Вывести ФИО, специализацию и дату рождения всех академиков.

SELECT a.FIO, a.Specialisation, a.Birthday
FROM dbo.Akademik a

--2.	Создать вычисляемое поле «О присвоении звания», которое содержит информацию об академиках в виде: «Петров Петр Петрович получил звание в 1974».

SELECT a.FIO + ' получил звание в ' + CAST(a.Date_Zvanie AS nvarchar) AS 'Информация'
FROM dbo.Akademik a

--3.	Вывести ФИО академиков и вычисляемое поле «Через 5 лет после присвоения звания».

SELECT a.FIO + ' через 5 лет после присвоения звания ' + CAST((A.Date_Zvanie + 5) AS nvarchar)
FROM dbo.Akademik a

--4.	Вывести список годов присвоения званий, убрав дубликаты.

SELECT DISTINCT a.Date_Zvanie
FROM dbo.Akademik a

--5.	Вывести список академиков, отсортированный по убыванию даты рождения.
 
SELECT a.FIO, a.Birthday
FROM dbo.Akademik a
ORDER BY a.Birthday DESC
 
--6.	Вывести список академиков, отсортированный в обратном алфавитном порядке специализаций, по убыванию года присвоения звания, и в алфавитном порядке ФИО.

SELECT a.FIO, a.Specialisation, a.Date_Zvanie
FROM dbo.Akademik a
ORDER BY a.Specialisation DESC, a.Date_Zvanie DESC, a.FIO ASC

--7.	Вывести первую строку из списка академиков, отсортированного в обратном ал-фавитном порядке ФИО.

SELECT TOP 1 WITH TIES a.FIO
FROM dbo.Akademik a
ORDER BY a.FIO ASC

--8.	Вывести фамилию академика, который раньше всех получил звание.

SELECT TOP 1 WITH TIES a.FIO, a.Date_Zvanie
FROM dbo.Akademik a
ORDER BY a.Date_Zvanie ASC

--9.	Вывести первые 10% строк из списка академиков, отсортированного в алфавитном порядке ФИО.

SELECT TOP 10 PERCENT a.FIO
FROM dbo.Akademik a
ORDER BY a.FIO ASC

--10.	Вывести из таблицы «Академики», отсортированной по возрастанию года присвоения звания, список академиков, у которых год присвоения звания – один из первых пяти в отсортированной таблице.

SELECT TOP 5 WITH TIES a.FIO, a.Date_Zvanie
FROM dbo.Akademik a
ORDER BY a.Date_Zvanie ASC

--11.	Вывести, начиная с десятого, список академиков, отсортированный по возраста-нию даты рождения.

SELECT a.FIO, a.Birthday
FROM dbo.Akademik a
ORDER BY a.Birthday OFFSET 9 ROWS

--12.	Вывести девятую и десятую строку из списка академиков, отсортированного в ал-фавитном порядке ФИО.

SELECT a.FIO
FROM dbo.Akademik a
ORDER BY a.FIO ASC OFFSET 8 ROWS FETCH NEXT 2 ROWS ONLY



--Практика 3
--1.	Вывести названия и столицы пяти наибольших стран по площади.

SELECT c.Names, c.Rectangles
FROM dbo.Country c
WHERE c.Rectangles > 1000000

--2.	Вывести список африканских стран, население которых не превышает 1 млн. чел.

SELECT c.Names, c.Peoples, c.Continent
FROM dbo.Country c
where c.Continent IN ('Африка') AND c.Peoples <= 1000000

--3.	Вывести список стран, население которых больше 5 млн. чел., а площадь меньше 100	тыс. кв. км, и они расположены не в Европе.

SELECT c.Names, c.Peoples, c.Rectangles, c.Continent
FROM dbo.Country c
WHERE c.Peoples > 5000000 and c.Rectangles < 100000 and c.Continent not in('Европа')

--4.	Вывести список стран Северной и Южной Америки, население которых больше 20	млн. чел., или стран Африки, у которых население больше 30 млн. чел.

SELECT c.Names, c.Peoples, c.Continent
FROM dbo.Country c
WHERE (c.Peoples > 20000000 and c.Continent in('Северная Америка', 'Южная Америка'))
or (c.Peoples > 30000000 and c.Continent in('Африка'))

--5.	Вывести список стран, население которых составляет от 10 до 100 млн. чел., а пло-щадь не больше 500 тыс. кв. км.

SELECT c.Names, c.Peoples, c.Rectangles
FROM dbo.Country c
WHERE (c.Peoples BETWEEN 10000000 AND 100000000) AND (c.Rectangles <= 500000)

--6.	Вывести список стран, названия которых не начинаются с буквы «К».

SELECT c.Names
FROM dbo.Country c
WHERE c.Names NOT LIKE 'К%'

--7.	Вывести список стран, в названии которых третья буква – «а», а предпоследняя – «и».

SELECT c.Names
FROM dbo.Country c
WHERE c.Names LIKE '__а%и_'

--8.	Вывести список стран, в названии которых вторая буква – гласная.

SELECT c.Names
FROM dbo.Country c
WHERE c.Names LIKE '_[ауоыиэяюёе]%'

--9.	Вывести список стран, названия которых начинаются с букв от «К» до «П».

SELECT c.Names
FROM dbo.Country c
WHERE c.Names LIKE '[К-П]%'

--10.	Вывести список стран, названия которых начинаются с букв от «А» до «Г», но не с буквы «Б».

SELECT c.Names
FROM dbo.Country c
WHERE c.Names LIKE '[^Б]%'

--11.	Вывести список стран, столицы которых есть в базе.

SELECT c.Names, c.Capital
FROM dbo.Country c
WHERE c.Capital IS NOT NULL

--12.	Вывести список стран Африки, Северной и Южной Америки.

SELECT c.Names, c.Peoples, c.Continent
FROM dbo.Country c
where c.Continent IN ('Африка','Северная Америка', 'Южная Америка')



--Практика 4
--1.	Вывести список академиков, отсортированный по количеству символов в ФИО.

SELECT a.FIO, LEN(a.FIO) as 'Количество символов'
FROM dbo.Akademik a
order by LEN(a.FIO)

--2.	Вывести список академиков, убрать лишние пробелы в ФИО.

select TRIM(a.FIO) as 'ФИО'
From dbo.Akademik a

--3.	Найти позиции «ов» в ФИО каждого академика. Вывести ФИО и номер позиции.

select a.FIO, CHARINDEX('ов', a.FIO) as 'Позиция "ов"'
From dbo.Akademik a

--4.	Вывести ФИО и последние две буквы специализации для каждого академика.

select a.FIO, RIGHT(a.Specialisation, 2) as 'Последние 2 буквы'
From dbo.Akademik a

--5.	Вывести список академиков, ФИО в формате Фамилия и Инициалы.

select a.FIO, SUBSTRING(a.FIO, 1, CHARINDEX(' ', a.FIO) - 1) + SUBSTRING(a.FIO, CHARINDEX(' ', a.FIO), 2)
+ '.' + SUBSTRING(a.FIO, CHARINDEX(' ', a.FIO,CHARINDEX(' ',a.FIO) + 1), 2) + '.' as 'Фамилия инициалы'
From dbo.Akademik a

--6.	Вывести список специализаций в правильном и обратном виде. Убрать дубликаты.

select distinct a.Specialisation, REVERSE(a.Specialisation) as 'В обратном виде'
from dbo.Akademik a

--7.	Вывести свою фамилию в одной строке столько раз, сколько вам лет.

select REPLICATE('Когорев_Фаизрахманов', 18) as 'Фамилии'

--8.	Вывести абсолютное значение функций2 (2) −   (3  2) с точностью два знака после десятичной запятой.
--Сказали пропустить
--9.	Вывести количество дней до конца семестра.

select DATEDIFF(day, GETDATE(), '20231229') as 'Количество дней до конца сессии'

--10.	Вывести количество месяцев от вашего рождения.

select DATEDIFF(MONTH, '20050826', GETDATE()) as 'Количество месяцев от даты рождения Когорев'
select DATEDIFF(MONTH, '20050919', GETDATE()) as 'Количество месяцев от даты рождения Файзрахманов'

--11.	Вывести ФИО и високосность года рождения каждого академика.

select a.FIO, a.Birthday, iif(YEAR(a.Birthday) %4 = 0, 'Высокосный', 'Не высокосный') as 'Высокосность' 
from dbo.Akademik a

--12.	Вывести список специализаций без повторений. Для каждой специализации выве-сти «длинный» или «короткий»,
--		в зависимости от количества символов.

select distinct a.Specialisation, LEN(a.Specialisation) as 'Количество символов',
iif(LEN(a.Specialisation) >= 10, 'длинный', 'короткий') as 'Размер'
from dbo.Akademik a



--Практика 5
--1.	Вывести минимальную площадь стран.

SELECT C.Names, C.Rectangles FROM dbo.Country C
WHERE C.Rectangles = (SELECT MIN(c.Rectangles) FROM dbo.Country c)

--2.	Вывести наибольшую по населению страну в Северной и Южной Америке.

select MAX(c.Peoples) as 'наибольшая по населению странa', c.Continent
from dbo.Country c
where c.Continent = 'Северная Америка' or c.Continent = 'Южная Америка'
GROUP BY c.Continent

--3.	Вывести среднее население стран. Результат округлить до одного знака.

select ROUND(AVG(CAST(c.Peoples as float)), 1) as 'Среднее население стран'
from dbo.Country c

--4.	Вывести количество стран, у которых название заканчивается на «ан», кроме стран, у которых название заканчивается на «стан».

select COUNT(*) as 'Количество'
from dbo.Country c
where RIGHT(c.Names,2) = 'ан' and not RIGHT (c.Names,4) = 'стан'

--5.	Вывести количество континентов, где есть страны, название которых начинается с буквы «Р».

select COUNT(c.Continent) as 'Количество'
from dbo.Country c
where LEFT(c.Names,1) = 'Р'

--6.	Во сколько раз страна с наибольшей площадью больше, чем страна с наименьшей площадью?

select MAX(c.Rectangles)/MIN(c.Rectangles)
from dbo.Country c

--7.	Вывести количество стран с населением больше, чем 100 млн. чел. на каждом кон-тиненте.
--		Результат отсортировать по количеству стран по возрастанию.

SELECT c.Continent, c.Peoples, COUNT(*)
FROM dbo.Country c
where c.Peoples > 100000000
GROUP BY c.Continent, c.Peoples
ORDER BY COUNT(*) ASC

--8.	Вывести количество стран по количеству букв в названии. Результат отсортировать по убыванию.

SELECT COUNT(*), len(c.Names)
FROM dbo.Country c
group by len(c.Names)
order by COUNT(*) DESC

--9.	Ожидается, что через 20 лет население мира вырастет на 10%. Вывести список континентов с прогнозируемым населением:

SELECT c.Continent, FLOOR(SUM(c.Peoples)*1.1) AS 'Через 20 лет'
FROM dbo.Country c
GROUP BY c.Continent

--10.	Вывести список континентов, где разница по площади между наибольшими и наименьшими странами не более в 10000 раз:

SELECT c.Continent, c.Peoples
FROM dbo.Country c
GROUP BY c.Continent, c.Peoples
HAVING MAX(cast(c.Peoples as bigint)) <= 10000*MIN(cast(c.Peoples as bigint))

--11.	Вывести среднюю длину названий Африканских стран.

SELECT avg(len(c.Names))
FROM dbo.Country c
WHERE c.Continent = 'Африка'
GROUP BY len(c.Names)
--12.	Вывести список континентов, у которых средняя плотность среди стран с населе-нием более 1 млн. чел. больше,
--		чем 30 чел. на кв. км.

SELECT c.Continent, AVG(c.Peoples)
FROM dbo.Country c
where c.Peoples > 1000000
GROUP BY c.Continent
HAVING AVG(c.Peoples/c.Rectangles) > 30



--Практика 6
--1.	Вывести из таблиц «Кафедра», «Специальность» и «Студент» данные о студентах, которые обучаются на данном факультете (например, «ит»).

SELECT s.Reg_Number, s.Number_Specialization, s.FIO
FROM Kafedra k
INNER JOIN Specialization sp ON k.Shifr_Kafedra = sp.Shifr_Kafedra
INNER JOIN Student s ON sp.Number_Specialization = s.Number_Specialization
WHERE k.Name = 'ит'

--2.	Вывести из таблиц «Кафедра», «Специальность» и «Сотрудник» данные о выпус-кающих кафедрах (факультет, шифр, название, фамилию заведующего).
--		Выпускающей счита-ется та кафедра, на которую есть ссылки в таблице «Специальность».

SELECT k.Name
FROM dbo.Kafedra k
INNER JOIN dbo.Employee e ON k.Shifr_Kafedra = e.Shifr_Kafedra
INNER JOIN dbo.Specialization s ON k.Shifr_Kafedra = s.Shifr_Kafedra

--3.	Вывести в запросе для каждого сотрудника номер и фамилию его непосредствен-ного руководителя. Для заведующих кафедрами поле руководителя оставить пустым.

SELECT *
FROM dbo.Employee e
WHERE e.Dolgnost != 'зав. кафедрой'

--4.	Вывести список студентов, сдавших минимум два экзамена.

SELECT s.FIO
FROM dbo.Student s
INNER JOIN dbo.Exam e ON s.Reg_Number = e.Reg_Number
GROUP BY s.FIO
HAVING COUNT(e.Code_Discipline) >= 2

--5.	Вывести список инженеров с зарплатой, меньшей 20000 руб.

SELECT *
FROM dbo.Engineer er
INNER JOIN dbo.Employee e ON er.Tab_Number = e.Tab_Number
WHERE e.Zarplata < 20000

--6.	Вывести список студентов, сдавших экзамены в заданной аудитории.

SELECT s.FIO, e.Auditoriya
FROM dbo.Student s
INNER JOIN dbo.Exam e ON s.Reg_Number = e.Reg_Number

--7.	Вывести из таблиц «Студент» и «Экзамен» учетные номера и фамилии студентов, а также количество сданных экзаменов и
--		средний балл для каждого студента только для тех студентов, у которых средний балл не меньше заданного 3 (например, 4).

SELECT s.FIO, COUNT(e.Ocenka) AS 'Кол-во экзаменов', AVG(e.Ocenka) AS 'Средний балл'
FROM dbo.Student s
INNER JOIN dbo.Exam e ON s.Reg_Number = e.Reg_Number
GROUP BY s.FIO
HAVING AVG(e.Ocenka) >=3

--8.	Вывести список заведующих кафедрами и их зарплаты, и степень.

SELECT e.Surname, e.Zarplata, p.Stepen
FROM dbo.Employee e
INNER JOIN dbo.Prepodavatel p ON e.Tab_Number = p.Tab_Number

--9.	Вывести список профессоров.

SELECT e.Surname
FROM dbo.Employee e
INNER JOIN dbo.Prepodavatel p ON e.Tab_Number = p.Tab_Number
WHERE p.Title = 'профессор'

--10.	Вывести название дисциплины, фамилию, должность и степень преподавателя, дату и место проведения экзаменов в хронологическом порядке в заданном интервале даты.

SELECT DISTINCT d.Name, em.Surname, em.Dolgnost, p.Stepen, e.Data, e.Auditoriya
FROM Exam e
INNER JOIN Discipline d ON e.Code_Discipline = d.Code_Discipline
INNER JOIN Employee em ON e.Tab_Number = em.Tab_Number
INNER JOIN Prepodavatel p ON  e.Tab_Number = p.Tab_Number
ORDER BY e.Data

--11.	Вывести фамилию преподавателей, принявших более трех экзаменов.

SELECT em.Surname, COUNT(e.Data) as 'КОЛ-ВО ЭКЗАМЕНОВ'
FROM Exam e
INNER JOIN Employee em ON e.Tab_Number = em.Tab_Number
GROUP BY em.Surname
HAVING COUNT(e.Data) > 3

--12.	Вывести список студентов, не сдавших ни одного экзамена в указанной дате.

SELECT s.FIO FROM Student s
LEFT OUTER JOIN	Exam e ON e.Reg_Number = s.Reg_Number AND e.Data = '12.06.2015'
WHERE e.Reg_Number IS NULL



--Практика 7
--1.	Вывести объединенный результат выполнения запросов, которые выбирают страны с площадью меньше 500 кв. км и с площадью больше 5 млн. кв. км:

SELECT c.Names, c.Rectangles
FROM dbo.Country c
WHERE c.Rectangles < 500
Union
SELECT c.Names, c.Rectangles
FROM dbo.Country c
WHERE c.Rectangles > 5000000

--2.	Вывести список стран с площадью больше 1 млн. кв. км, исключить страны с насе-лением меньше 100 млн. чел.:

SELECT c.Names, c.Peoples, c.Rectangles
FROM dbo.Country c
WHERE c.Rectangles > 1000000
EXCEPT
SELECT c.Names, c.Peoples, c.Rectangles
FROM dbo.Country c
WHERE c.Peoples < 100000000

--3.	Вывести список стран с площадью меньше 500 кв. км и с населением меньше 100	тыс. чел.

SELECT c.Names, c.Peoples, c.Rectangles
FROM dbo.Country c
WHERE c.Rectangles < 500
UNION
SELECT c.Names, c.Peoples, c.Rectangles
FROM dbo.Country c
WHERE c.Peoples < 100000



--Практика 8
--Вывести список стран и процентное соотношение площади каждой из них к общей площади всех стран мира.

SELECT c.Names, c.Rectangles, ROUND(CAST(c.Rectangles AS float) * 100/
							  (SELECT sum(c2.Rectangles) FROM dbo.Country c2),3) AS 'Процент'
FROM dbo.Country c
ORDER BY [Процент]

--2.	Вывести список стран мира, плотность населения которых больше, чем средняя плотность населения всех стран мира.

SELECT c.[Names], c.Peoples
FROM dbo.Country c
WHERE c.Peoples > (
SELECT AVG(c2.Peoples) FROM dbo.Country c2)

--3.	С помощью подзапроса вывести список европейских стран, население которых меньше 5 млн. чел.

SELECT *
FROM dbo.Country c
WHERE c.Continent='Африка' AND c.Peoples<5000000

--4.	Вывести список стран и процентное соотношение их площади к суммарной пло-щади той части мира, где они находятся.

SELECT c.Names, c.Rectangles, ROUND(CAST(c.Rectangles AS float) * 100/
							  (SELECT sum(c2.Rectangles) FROM dbo.Country c2 WHERE c2.Continent=c.Continent),3) AS 'Процент'
FROM dbo.Country c
ORDER BY [Процент]

--5.	Вывести список стран мира, площадь которых больше, чем средняя площадь стран той части света, где они находятся.

SELECT c.[Names], c.Rectangles
FROM dbo.Country c
WHERE c.Rectangles > (SELECT AVG(c2.Rectangles) FROM dbo.Country c2 WHERE c2.Continent=c.Continent)

--6.	Вывести список стран мира, которые находятся в тех частях света, средняя плот-ность населения которых превышает общемировую.
 
 SELECT *
 FROM dbo.Country c
 WHERE c.Continent IN(SELECT c2.Continent FROM dbo.Country c2 GROUP BY c2.Continent HAVING AVG(c2.Peoples) > (SELECT AVG(c3.Peoples) FROM dbo.Country c3))

--7.	Вывести список южноамериканских стран, в которых живет больше людей, чем в любой африканской стране.

SELECT *
FROM dbo.Country c
WHERE c.Continent='Южная Америка' AND c.Peoples>ALL(SELECT c2.Peoples FROM dbo.Country c2 WHERE c2.Continent='Африка')

--8.	Вывести список африканских стран, в которых живет больше людей, чем хотя бы в	одной южноамериканской стране.

SELECT *
FROM dbo.Country c
WHERE c.Continent='Африка' AND c.Peoples>ANY(SELECT c2.Peoples FROM dbo.Country c2 WHERE c2.Continent='Южная Америка')

--9.	Если в Африке есть хотя бы одна страна, площадь которой больше 2 млн. кв. км, вывести список всех африканских стран.

SELECT *
FROM dbo.Country c
WHERE c.Continent = 'Африка'
AND EXISTS (SELECT * FROM dbo.Country c2 WHERE c2.Continent='Африка' AND c2.Rectangles > 2000000)

--10.	Вывести список стран той части света, где находится страна «Фиджи».

SELECT *
FROM dbo.Country c
WHERE c.Continent = (SELECT c2.Continent FROM dbo.Country c2 WHERE c2.[Names]='Фиджи')

---11.	Вывести список стран, население которых не превышает население страны «Фи-джи».

SELECT *
FROM dbo.Country c
WHERE c.Peoples !> (SELECT c2.Peoples FROM dbo.Country c2 WHERE c2.[Names]='Фиджи')

--12.	Вывести название страны с наибольшим населением среди стран с наименьшей площадью на каждом континенте.

SELECT c.Continent, c.[Names] AS Country
FROM dbo.Country c
INNER JOIN (
    SELECT Continent, MIN(Rectangles) AS MinArea
    FROM Country
    GROUP BY Continent
) c2 ON c.Continent = c2.Continent AND c.Rectangles = c2.MinArea
WHERE c.Peoples = (
    SELECT MAX(Peoples)
    FROM Country 
    WHERE Continent = c.Continent AND Rectangles = c.Rectangles
)



--Практика 9
--1.	Создать таблицу «Управление_ВашаФамилия». Определить основной ключ, иден-тификатор, значение по умолчанию

CREATE TABLE Managament_Faiz_Kog
(
	ID_MFK int IDENTITY PRIMARY KEY,
	Vid varchar(20) DEFAULT 'NULL'
)

--2.	Создать таблицу «Страны_ВашаФамилия». Определить основной ключ, разреше-ние / запрет на NULL, условие на вводимое значение.

CREATE TABLE Countries_Faiz_Kog
(
	ID_MFK int PRIMARY KEY,
	Vid varchar(20) NOT NULL
)

--3.	Создать таблицу «Цветы_ВашаФамилия». Определить основной ключ, значения столбца «ID» сделать уникальными, для столбца «Класс» установить значение по умолчанию «Двудольные».

CREATE TABLE Flower_Faiz_Kog
(
	ID_FFK int PRIMARY KEY IDENTITY,
	Title nvarchar(100),
	Class nvarchar(50) DEFAULT 'Двудвольные',
	Colour  nvarchar(50)
)

--4.	Создать таблицу «Животные_ВашаФамилия». Определить основной ключ, значе-ния столбца «ID» сделать уникальными, для столбца «Отряд» установить значение по умол-чанию «Хищные».

CREATE TABLE Animal_Faiz_Kog
(
	ID_AFK int IDENTITY PRIMARY KEY,
	Title nvarchar(50),
	Detachment nvarchar(50) DEFAULT 'Хищные'
)



--Пратика 10
--1.	В таблицу «Ученики» внести новую запись для ученика школы № 18 Трошкова, оценка которого по химии неизвестна.

INSERT INTO dbo.Students
(
    Id_Students, -- column value is auto-generated
    Surname,
    Subjecs,
    School,
    Scores
)
VALUES
(
    11,-- Id_Students - int
    'Трошкова', -- Surname - varchar
    'Химия', -- Subjecs - varchar
    'Школа №18', -- School - varchar
    NULL -- Scores - float
)

--2.	В таблицу «Ученики» внести три строки.

INSERT INTO dbo.Students
(
    Surname,
    Subjecs,
    School,
    Scores
)
VALUES
('Когорев', 'Математика', 'Гимназия', 99), ('Файзрахманов','Химия','Гимназия',100), ('Семёнова','Иннформатика','Гимназия', 52)

--3.	В таблице «Ученики» изменить данные Трошкова, школу исправить на № 21, пред-мет на математику, а оценку на 56.

UPDATE
	dbo.Students
SET
    dbo.Students.Subjecs = 'Математика', -- varchar
    dbo.Students.School = 'Школа №21', -- varchar
    dbo.Students.Scores = 56 -- float
WHERE dbo.Students.Surname='Трошкова'

--4.	В таблице «Ученики» изменить данные всех учеников по химии, оценку увеличить на 10%, если она ниже 60 баллов.

UPDATE
	dbo.Students
SET
    dbo.Students.Surname = '', -- varchar
    dbo.Students.Subjecs = '', -- varchar
    dbo.Students.School = '', -- varchar
    dbo.Students.Scores = dbo.Students.Scores + (Scores * 0.1) -- float
WHERE dbo.Students.Subjecs ='Химия'

--5.	В таблице «Ученики» удалить данные всех учеников из школы №21.

delete from dbo.Students
where dbo.Students.School = 'Школа №21'

--6.	Создать таблицу «Гимназисты» и скопировать туда данные всех гимназистов, кроме тех, которые набрали меньше 60 баллов.

select *
into Gimnazisty
from dbo.Students s
where s.School = 'Гимназия' and s.Scores >= 60

--7.	Очистить таблицу «Гимназисты».

truncate table Gimnazisty



 --Практика 11
 --1.	Даны числа A и B. Найти и вывести их произведение.

DECLARE @a INT, @b INT, @c INT
SET @a = 5
SET @b = 10
SET @c = @a * @b
PRINT @c

--2.	В таблице «Ученики» найти разницу между средними баллами лицеистов и гимназистов.

DECLARE @licey FLOAT, @gimn FLOAT, @diff FLOAT
SET @licey = (
	SELECT avg(s.Scores)
	FROM dbo.Students s
	where s.School = 'Лицей'
	)
SET @gimn = (
	SELECT avg(s.Scores)
	FROM dbo.Students s
	where s.School = 'Гимназия'
	)
SET @diff = ABS(@licey - @gimn)
print @diff

--3.	В таблице «Ученики» проверить на четность количество строк.

DECLARE @RowCount INT
SELECT @RowCount = COUNT(*) FROM Students
IF @RowCount % 2 = 0
    PRINT 'Количество строк в таблице четное'
ELSE
    PRINT 'Количество строк в таблице нечетное'

--4.	Дано четырехзначное число. Вывести сумму его цифр.

DECLARE @number INT = 8456;
DECLARE @sum INT = 0;

WHILE @number > 0
BEGIN
    SET @sum = @sum + (@number % 10);
    SET @number = @number / 10;
END

SELECT @sum AS SumOfDigits

--5.	Даны случайные целые числа a, b и c. Найти наименьшее из них.

DECLARE @d INT = RAND() * 100, @f INT = RAND() * 100, @g INT = RAND() * 100
IF @d < @f and @d < @g
 PRINT CAST(@d AS VARCHAR(3)) +' '+ CAST(@f AS VARCHAR(3)) +' '+ CAST(@g AS VARCHAR(3)) + ' Наименьшее @a = ' + CAST(@d AS VARCHAR(3))
ELSE IF @f < @d and @f < @g
 PRINT CAST(@d AS VARCHAR(3)) +' '+ CAST(@f AS VARCHAR(3)) +' '+ CAST(@g AS VARCHAR(3)) + ' Наименьшее @b = ' + CAST(@f AS VARCHAR(3))
ELSE
 PRINT CAST(@d AS VARCHAR(3)) +' '+ CAST(@f AS VARCHAR(3)) +' '+ CAST(@g AS VARCHAR(3)) + ' Наименьшее @c = ' + CAST(@g AS VARCHAR(3))

--6.	Дано случайное целое число a. Проверить, делится ли данное число на 11.

DECLARE @h INT = RAND() * 100
IF @h % 11 = 0
PRINT CAST(@h AS VARCHAR(3)) + ' делится на 11'
ELSE
PRINT CAST(@h AS VARCHAR(3)) + ' не делится на 11'

--7.	Дано случайное целое число N (N < 1000). Если оно является степенью числа 3, то вывести «Да», если не является – вывести «Нет».

DECLARE @n INT = RAND() * 1000
        WHILE @n % 3 = 0
        SET @n = @n / 3
        IF @n = 1
           PRINT 'Да'
        ELSE
           PRINT 'Нет'

--8.	Даны случайные целые числа a и b. Найти наименьший общий кратный (НОК).

CREATE FUNCTION dbo.GreatestCommonDivisor(@a INT, @b INT) RETURNS INT
AS
BEGIN
    WHILE @b != 0
    BEGIN
        DECLARE @temp INT
        SET @temp = @b
        SET @b = @a % @b
        SET @a = @temp
    END

    RETURN @a
END
GO

CREATE FUNCTION dbo.LeastCommonMultiple(@a INT, @b INT) RETURNS INT
AS
BEGIN
    DECLARE @gcd INT
    SET @gcd = dbo.GreatestCommonDivisor(@a, @b)

    DECLARE @lcm INT
    SET @lcm = (@a * @b) / @gcd

    RETURN @lcm
END
GO

DECLARE @a INT, @b INT
SET @a = 12
SET @b = 18

SELECT dbo.LeastCommonMultiple(@a, @b) AS NOK

--9.	Даны два целых числа A и B (A<B). Найти сумму квадратов всех целых чисел от A до B включительно.

DECLARE @d INT = 852, @e INT = 8596, @s INT = 0 
    WHILE @d <= @e 
 BEGIN 
 SET @s = @s + @d 
 SET @d = @d + 1 
 END 
 PRINT 'Сумма = ' + CAST(@s AS VARCHAR(10))

--10.	Найти первое натуральное число, которое при делении на 2, 3, 4, 5, и 6 дает остаток 1, но делится на 7.

DECLARE @num INT 
SET @num = 1 
 
WHILE (1=1) 
BEGIN 
    IF (@num % 2 = 1 AND @num % 3 = 1 AND @num % 4 = 1 AND @num % 5 = 1 AND @num % 6 = 1 AND @num % 7 = 0) 
    BEGIN 
        PRINT 'Первое число: ' + CAST(@num AS NVARCHAR(10)) 
        BREAK 
    END 
 
    SET @num += 1 
END 

--11.	Вывести свою фамилию на экран столько раз, сколько в нем букв.

DECLARE @L INT, @M CHAR(100) = 'ФайзрахмановКогорев' 
   SET @L = LEN(@M) 
   WHILE @L > 0 
   BEGIN 
   PRINT @M 
   SET @L=@L-1 
   END

--12.	Напишите код для вывода на экран с помощью цикла:
--            Н
--           иНи
--          жиНиж
--         нжиНижн
--        енжиНижне
--       венжиНижнев
--      авенжиНижнева
--     равенжиНижневар
--    травенжиНижневарт
--   отравенжиНижневарто
--  вотравенжиНижневартов
-- свотравенжиНижневартовс
--ксвотравенжиНижневартовск

DECLARE @Text NVARCHAR(50) = 'Нижневартовск'
DECLARE @Length INT = LEN(@Text)
DECLARE @i INT = 1
DECLARE @output NVARCHAR(50) = ''

WHILE @i <= @Length
BEGIN
    SET @output = SPACE(@Length - @i) + REVERSE(SUBSTRING(@Text, 1, @i)) + SUBSTRING(@Text, 2 , @i - 1)
    PRINT @output
    SET @i = @i + 1
END



--Практика 12
--1.	Напишите функцию для вывода названия страны с заданной столицей, и вызовите ее.

CREATE FUNCTION Задание1
(
@Столица AS VARCHAR(50)
)
RETURNS VARCHAR(50)
AS
BEGIN
DECLARE @S AS VARCHAR(50)
SELECT @S = c.Names
FROM dbo.Country c
WHERE c.Capital = @Столица
RETURN @S
END

SELECT dbo.Задание1('Баку') as 'Страна'

--2.	Напишите функцию для перевода населения в млн. чел. и вызовите ее.

CREATE FUNCTION Пример2
(
@Население AS FLOAT
)
RETURNS FLOAT
AS
BEGIN
DECLARE @P AS FLOAT
SET @P = ROUND(@Население / 1000000, 2)
RETURN @P
END

SELECT c.Names, c.Peoples, dbo.Пример2(c.Peoples) AS 'Население млн. чел.'
FROM dbo.Country c

--3.	Напишите функцию для вычисления плотности населения заданной части света и вызовите ее.

CREATE FUNCTION Пример3
(
@Население AS INT,
@Площадь AS FLOAT
)
RETURNS FLOAT
AS
BEGIN
DECLARE @P AS FLOAT
SET @P = ROUND(CAST(@Население AS FLOAT) / @Площадь, 2)
RETURN @P
END

SELECT c.Names, c.Peoples, c.Rectangles as 'Площадь', dbo.Пример3(c.Peoples, c.Rectangles) AS 'Плотность населения Азербайджана'
FROM dbo.Country c
where c.Names =  'Азербайджан'
ORDER BY
'Плотность населения Азербайджана' DESC

--4.	Напишите функцию для поиска страны, третьей по населению и вызовите ее.

CREATE FUNCTION Пример4()
RETURNS NVARCHAR(50)
AS
BEGIN
DECLARE @P AS VARCHAR(50)
DECLARE @M1 AS FLOAT
DECLARE @M2 AS FLOAT
DECLARE @M3 AS FLOAT

SELECT
@M1 = MAX(c.Peoples)
FROM dbo.Country c

SELECT
@M2 = MAX(c.Peoples) 
FROM dbo.Country c
WHERE
c.Peoples < @M1

SELECT
@M3 = MAX(c.Peoples) 
FROM dbo.Country c
WHERE
c.Peoples < @M2

SELECT
@P = c.Names
FROM
dbo.Country c
WHERE
c.Peoples = @M3

RETURN @P
END

SELECT dbo.Пример4() AS 'Третья по населению страна'

--5.	Напишите функцию для поиска страны с максимальным населением в заданной ча-сти света и вызовите ее. Если часть света не указана, выбрать Азию.

CREATE FUNCTION Пример5
(
@Конт AS VARCHAR(50) = 'Азия'
)
RETURNS VARCHAR(50)
AS
BEGIN
DECLARE @P AS VARCHAR(50)
DECLARE @N AS FLOAT

SELECT @N = max(c.Peoples)
FROM dbo.Country c
WHERE c.Continent = @Конт

SELECT @P = c.Names
FROM dbo.Country c
WHERE c.Continent = @Конт AND c.Peoples = @N

RETURN @P
END

SELECT dbo.Пример5(DEFAULT) AS [Наибольшая по населению страна в Азии]

--6.	Напишите функцию для замены букв в заданном слове от третьей до предпослед-ней на “тест” и примените ее для столицы страны.

CREATE FUNCTION Пример6
(
@A AS NVARCHAR(50)
)
RETURNS NVARCHAR(50)
AS
BEGIN
RETURN LEFT(@A, 2) + REPLICATE('тест', LEN(@A) - 1) + RIGHT(@A, 1)
END

SELECT c.Names, dbo.Пример6(c.Names) AS [Скрытое название]
FROM
dbo.Country c

--7.	Напишите функцию, которая возвращает количество стран, не содержащих в назва-нии заданную букву.

CREATE FUNCTION Пример7
(
@C AS CHAR(1)
)
RETURNS INT
AS
BEGIN
DECLARE @K AS INT

SELECT
@K = COUNT(*)
FROM
dbo.Country c
WHERE
CHARINDEX(@C, c.Names) > 0

RETURN @K
END

select dbo.Пример7('о')

--8.	Напишите функцию для возврата списка стран с площадью меньше заданного числа и вызовите ее.

CREATE FUNCTION Пример8
(
@N AS INT
)
RETURNS TABLE
AS
RETURN (
SELECT c.Names, c.Rectangles
FROM dbo.Country c
WHERE c.Rectangles < @N
)

SELECT
*
FROM
dbo.Пример8(100000)

--9.	Напишите функцию для возврата списка стран с населением в интервале заданных значений и вызовите ее.

CREATE FUNCTION Пример9 
(
@J AS FLOAT,
@B AS FLOAT
)
RETURNS TABLE
AS
RETURN (
SELECT c.Names, c.Peoples
FROM dbo.Country c
WHERE c.Peoples BETWEEN @J AND @B
)

SELECT *
FROM dbo.Пример9(2000000, 3000000)

--10.	Напишите функцию для возврата таблицы с названием континента и суммарным населением и вызовите ее.

CREATE  FUNCTION Пример10()
RETURNS @St__SUM TABLE( Continent nvarchar(50), Peoples float)
as
BEGIN
	INSERT
		@St__SUM
	SELECT
		c.Continent, sum(c.People)
	FROM dbo.Countries c
	GROUP BY c.Continent
	RETURN
END

SELECT *
FROM Пример10()

--11.	Напишите функцию IsPalindrom(P) целого типа, возвращающую 1, если целый па-раметр P (P > 0) является палиндромом, и 0 в противном случае.
CREATE FUNCTION IsPalindrom(@P INT)
RETURNS INT
AS
BEGIN
    DECLARE @NumberString VARCHAR(10);
    SET @NumberString = CAST(@P AS VARCHAR(10));

    DECLARE @IsPalindrom INT;
    SET @IsPalindrom = 1;

    DECLARE @Length INT;
    SET @Length = LEN(@NumberString); 

    DECLARE @Counter INT;
    SET @Counter = 1;

    WHILE @Counter <= @Length / 2
    BEGIN
        IF SUBSTRING(@NumberString, @Counter, 1) <> SUBSTRING(@NumberString, @Length - @Counter + 1, 1)
        BEGIN
            SET @IsPalindrom = 0; 
            BREAK;
        END
        SET @Counter = @Counter + 1;
    END
    RETURN @IsPalindrom;
END

--12.	Напишите функцию Quarter(x, y) целого типа, определяющую номер координатной четверти, содержащей точку с ненулевыми вещественными координатами (x, y).
CREATE FUNCTION Quarter(@x FLOAT, @y FLOAT)
RETURNS INT
AS
BEGIN
    DECLARE @Quadrant INT;
    IF @x > 0 AND @y > 0
        SET @Quadrant = 1;
    ELSE IF @x < 0 AND @y > 0
        SET @Quadrant = 2;
    ELSE IF @x < 0 AND @y < 0
        SET @Quadrant = 3
    ELSE IF @x > 0 AND @y < 0
        SET @Quadrant = 4;
    ELSE
        SET @Quadrant = 0;

    RETURN @Quadrant;
END;
--13.	Напишите функцию IsPrime(N) целого типа, возвращающую 1, если целый пара-метр N (N > 1) является простым числом, и 0 в противном случае.
CREATE FUNCTION IsPrime(@N INT)
RETURNS INT
AS
BEGIN
    IF @N <= 1
        RETURN 0;

    DECLARE @IsPrime INT;
    SET @IsPrime = 1;

    DECLARE @Divisor INT;
    SET @Divisor = 2;

    WHILE @Divisor <= SQRT(@N)
    BEGIN
        IF @N % @Divisor = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END

        SET @Divisor = @Divisor + 1;
    END
    RETURN @IsPrime;
END;
--14.	Напишите код для удаления созданных вами функций 
DROP FUNCTION Задание1, Пример2, Пример3, Пример4, Пример5, Пример6, Пример7, Пример8, Пример9, Пример10, IsPalindrom, Quarter, IsPrime



--Практика 13
--1.	Создайте представление, содержащее список африканских стран, население которых больше 10 млн. чел., а площадь больше 500 тыс. кв. км, и используйте его.

CREATE VIEW Primer1
AS
SELECT c.[Names], c.Continent, c.People, c.Rectangles, c.Capital
FROM dbo.Countries c
WHERE c.People > 10000000 AND c.Rectangles < 500000 AND c.Continent = 'Африка'

SELECT *
FROM dbo.Primer1 p

--2.	Создайте представление, содержащее список континентов, среднюю площадь стран, которые находятся на нем, среднюю плотность населения, и используйте его.

CREATE VIEW Primer2
AS
SELECT c.Continent, avg(c.Rectangles) as 'Средняя площадь', avg(c.Peoples) as 'Средняя численность населения'
FROM dbo.Country c
GROUP BY c.Continent

SELECT *
FROM
dbo.Primer2 p

--3.	Создайте представление, содержащее фамилии преподавателей, их должность, зва-ние, степень, место работы, количество их экзаменов, и используйте его.

drop VIEW Primer3

CREATE VIEW Primer3
AS
SELECT e.Surname, e.Dolgnost, p.Title, p.Stepen, count(ex.Tab_Number) as 'Количество экзаменов'
FROM
dbo.Employee e
INNER JOIN dbo.Prepodavatel p on p.Tab_Number = e.Tab_Number
INNER JOIN dbo.Exam ex on ex.ID_Exam = p.ID_Prepodavatel
Group by e.Surname, e.Dolgnost, p.Title, p.Stepen

SELECT *
FROM
Primer3

--4.	Создайте табличную переменную, содержащую три столбца («Номер месяца», «Название месяца», «Количество дней»), заполните ее для текущего года, и используйте ее.

DECLARE @Primer4 TABLE
(
[Номер месяца] INT,
[Название месяца] nvarchar(50),
[Количество дней] int
)

DECLARE @YearNow INT
SET @YearNow = YEAR(GETDATE())

DECLARE @NumMonth INT
SET @NumMonth = 1

while @NumMonth <= 12
Begin
	DECLARE @Date4 DATE
    SET @Date4 = DATEFROMPARTS(@YearNow, @NumMonth, 1)

    DECLARE @Month_name NVARCHAR(50)
    SET @Month_name = DATENAME(MONTH, @Date4)

    DECLARE @Month_days_count INT
    SET @Month_days_count = DAY(EOMONTH(@Date4))

    INSERT INTO @Primer4 ([Номер месяца], [Название месяца], [Количество дней])
    VALUES (@NumMonth, @Month_name, @Month_days_count)

    SET @NumMonth += 1
END

SELECT
[Номер месяца],
[Название месяца],
[Количество дней]
FROM
@Primer4

--5.Создайте табличную переменную, содержащую список стран, площадь которых в 100 раз меньше, чем средняя площадь стран на континенте, где они находятся, и используйте ее.

Declare @NameConti nvarchar(50) = 'Азия'
Declare @Number5_12 TABLE
(
 CountyName nvarchar(50),
 CapitalName nvarchar(50),
 Area int,
 Continent nvarchar(50)
)
insert into @Number5_12
select c.Names, c.Capital, c.Rectangles, c.Continent
from dbo.Countries c
where c.Rectangles *100 < (Select avg(c.Rectangles) from Countries c) and c.Continent = @NameConti

Select * from @Number5_12
--6.Создайте локальную временную таблицу, имеющую три столбца («Номер недели», «Количество экзаменов», «Количество студентов»), заполните и используйте ее.

Select 
 DATENAME(WEEK,e.Data) as Number_week,
 COUNT(DISTINCT e.ID_Exam) AS [Count_exasm],
 COUNT(DISTINCT e.Reg_Number) AS [Count_studs]
 into #Number6_12
 from dbo.Exam e
 Group by DATENAME(WEEK,e.Data)
 Select * from #Number6_12
 Drop table #Number6_12

--7.Создайте глобальную временную таблицу, содержащую название континентов, наибольшую и наименьшую площадь стран на них, заполните и используйте ее.

Create table #Number7_12
(
 NameConti nvarchar(50),
 MaxRectangles int,
 MinRectangles int
)
insert into #Number7_12
(NameConti,MaxRectangles,MinRectangles)
Select c.Continent, Max(c.Rectangles), min(c.Rectangles)  from Countries c
group by c.Continent
Select *
from #Number7_12
Drop table #Number7_12

--8.С помощью обобщенных табличных выражений напишите запрос для вывода списка сотрудников, чьи зарплаты меньше, чем средняя зарплата по факультету, их зарплаты и название факультета.

WITH EmployeeSalaries 
AS 
(
    SELECT e.Surname, e.Zarplata, e.Dolgnost
    FROM Employee e
),
 AverageSalariesByFaculty AS (
    SELECT Dolgnost, AVG(Zarplata) AS AvgSalary
    FROM EmployeeSalaries
    GROUP BY Dolgnost
)
SELECT * FROM EmployeeSalaries em
JOIN AverageSalariesByFaculty a ON  em.Dolgnost= a.Dolgnost
WHERE em.Zarplata < a.AvgSalary
--9.Напишите команды для удаления всех созданных вами представлений.

DROP VIEW Primer1, Primer2, Primer3
DROP TABLE #Number6_12, #Number7_12

--Практика 14
--1.	Создайте курсор, содержащий отсортированные по баллам фамилии и баллы учеников, откройте его,
--		выведите первую строку, закройте и освободите курсор.

DECLARE @Cursor CURSOR

SET @Cursor = CURSOR FOR
SELECT s.Surname, s.Scores
FROM dbo.Students s
ORDER BY s.Scores DESC

OPEN @Cursor

FETCH NEXT FROM @Cursor

CLOSE @Cursor
DEALLOCATE @Cursor

--2.	Создайте курсор с прокруткой, содержащий список учеников, откройте его, выве-дите пятую, предыдущую,
--		с конца четвертую, следующую, первую строку, закройте и освобо-дите курсор.

DECLARE Cursor2 CURSOR SCROLL
FOR
SELECT *
FROM dbo.Students

OPEN Cursor2

FETCH ABSOLUTE 5 FROM Cursor2 -- Вывести пятую строку
FETCH PRIOR FROM Cursor2 -- Вывести предыдущую строку
FETCH LAST FROM Cursor2 -- Вывести четвертую строку с конца
FETCH NEXT FROM Cursor2 -- Вывести следующую строку
FETCH FIRST FROM Cursor2 -- Вывести первую строку

CLOSE Cursor2
DEALLOCATE Cursor2

--3.	Создайте курсор с прокруткой, содержащий список учеников, откройте его, выве-дите последнюю,
--		шесть позиций назад находящуюся, четыре позиций вперед находящуюся строку, закройте и освободите курсорю

DECLARE @Cursor3 CURSOR
SET @Cursor3 = CURSOR SCROLL FOR
SELECT *
FROM dbo.Students

OPEN @Cursor3
FETCH LAST FROM @Cursor3
FETCH PRIOR FROM @Cursor3
FETCH NEXT FROM @Cursor3
CLOSE @Cursor3
DEALLOCATE @Cursor3

--4.	С помощью курсора, вычислите сумму баллов у учеников с наибольшим и наименьшим баллом.

DECLARE MyCursor_4 CURSOR SCROLL
FOR
SELECT s.Scores FROM Students s
ORDER BY s.Scores DESC
DECLARE @F FLOAT = 0, @B4 FLOAT
OPEN MyCursor_4
FETCH FIRST FROM MyCursor_4 INTO @B4
SET @F=@F+@B4
FETCH LAST FROM MyCursor_4 INTO @B4
SET @F=@F+@B4
print 'Сумма = ' + CAST(@F as Nvarchar(20))
CLOSE MyCursor_4
DEALLOCATE MyCursor_4

--5.	С помощью курсора, сгенерируйте строку вида «Ученики <список фамилий и названий предметов,
--		разделенных запятыми> участвовали в олимпиаде».

DECLARE @students NVARCHAR(MAX)

SELECT @students = COALESCE(@students + ', ', '') + s.Surname + ' (' + s.Subjecs + ')'
FROM dbo.Students s
ORDER BY s.Id_Students

SELECT 'Ученики ' + @students + ' участвовали в олимпиаде'

--6.	Создайте курсор, содержащий список учеников, с его помощью выведите учеников с нечетной позицией.

DECLARE MyCursor_6 CURSOR SCROLL--здесь 12 строка равна 11, а 14 равна 13
FOR
SELECT * FROM Students s
OPEN MyCursor_6
FETCH ABSOLUTE 1 FROM MyCursor_6
WHILE @@FETCH_STATUS = 0
BEGIN
FETCH RELATIVE 2 FROM MyCursor_6
END
CLOSE MyCursor_6
DEALLOCATE MyCursor_6

--7.	Создайте курсор, содержащий отсортированный по убыванию баллов список уче-ников, откройте его,
--		для каждого ученика выведите фамилию, предмет, школу, баллы и про-центное соотношение баллов с предыдущим учеником.

DECLARE MyCursor_7 CURSOR SCROLL FOR
SELECT s.Surname, s.Subjecs, s.School, s.Scores
FROM Students s
DECLARE @F7 VARCHAR(50)
DECLARE @P7 VARCHAR(50)
DECLARE @S7 VARCHAR(50)
DECLARE @B7 FLOAT
DECLARE @O7 FLOAT = 0
OPEN MyCursor_7
FETCH NEXT FROM MyCursor_7 INTO @F7, @P7, @S7, @B7
WHILE @@FETCH_STATUS = 0
BEGIN
SELECT
@F7 AS Фамилия
,@P7 AS Предмет
,@S7 AS Школа
,@B7 AS Баллы
,ABS(@B7 - @O7) AS Разница
SET @O7 = @B7
FETCH NEXT FROM MyCursor_7 INTO @F7, @P7, @S7, @B7
END
CLOSE MyCursor_7
DEALLOCATE MyCursor_7

--Практика 15
--1.	Вывести список учеников и разницу между баллами ученика и максимальным бал-лом в каждой строке.

SELECT *, s.Scores - MAX(s.Scores) OVER() AS 'Разница'
FROM
dbo.Students s

--2.	Вывести список учеников и процентное соотношение к среднему баллу в каждой строке.

SELECT *, s.Scores * 100 / avg(s.Scores) OVER() AS Процент
FROM
dbo.Students s

--3.	Вывести список учеников и минимальный балл в школе в каждой строке.

SELECT *, min(s.Scores) OVER(PARTITION BY s.School) AS 'Мин_Шк'
FROM
dbo.Students s

--4.	Вывести список учеников и суммарный балл в школе в каждой строке, отсортиро-вать по школам в оконной функции.

SELECT *, SUM(s.Scores) OVER (PARTITION BY s.School) AS 'Суммарный_балл_в_школе'
FROM 
    dbo.Students s
ORDER BY 
    s.School ASC;

--5.	Вывести список учеников и номер строки при сортировке по фамилиям в обратном алфавитном порядке.

SELECT s.Surname, ROW_NUMBER() OVER (ORDER BY s.Surname DESC) AS 'НомерСтроки'
FROM dbo.Students s
ORDER BY s.Surname DESC;

--6.	Вывести список учеников, номер строки внутри школы и количество учеников в школе при сортировке по баллам по убыванию.

SELECT
    ROW_NUMBER() OVER (PARTITION BY s.School ORDER BY s.Scores DESC) AS 'Номер_Строки',
    s.Surname, s.Scores,
    s.School,
    COUNT(*) OVER (PARTITION BY s.School) AS 'Количество_Учеников'
FROM dbo.Students s
ORDER BY
    s.Scores DESC
 
--7.	Вывести список учеников и ранг по баллам.

SELECT *, RANK() OVER (ORDER BY s.Scores DESC) AS 'Ранг'
FROM dbo.Students s

--8.	Вывести список учеников и сжатый ранг по баллам. Результат отсортировать по фамилии в алфавитном порядке.

SELECT s.Surname, DENSE_RANK() OVER(ORDER BY s.Surname) AS 'Ранг'
FROM dbo.Students s
ORDER BY s.Surname

--9.	Вывести список учеников, распределенных по пяти группам по фамилии.

SELECT *, NTILE(5) OVER(ORDER BY s.Surname) AS 'Гр_Фам'
FROM dbo.Students s

--10.	Вывести список учеников, распределенных по трем группам по баллам внутри школы.

SELECT s.Surname, s.Subjecs, s.School, s.Scores,
NTILE(3) OVER(PARTITION BY s.School ORDER BY s.Surname) AS 'Гр_Фам'
FROM Students s
--11.	Вывести список учеников и разницу с баллами ученика, находящегося выше на три позиции при сортировке по возрастанию баллов.

SELECT *, s.Scores - LAG(s.Scores, 3) OVER (ORDER BY s.Scores) AS 'Разница'
FROM dbo.Students s
ORDER BY s.Scores

--12.	Вывести список учеников и разницу с баллами следующего ученика при сортировке по убыванию баллов, значение по умолчанию использовать 0.

SELECT *, LAG(s.Scores, 1, 0) OVER (ORDER BY s.Scores DESC) - s.Scores AS 'Разница'
FROM dbo.Students s



--Практика 16
--1.	Напишите запрос, который выводит максимальный балл учеников по школам, по каждому предмету по каждой школе и промежуточные итоги.

SELECT s.Subjecs, s.School, MAX(s.Scores) AS 'Максимальный_балл'
FROM dbo.Students s
GROUP BY s.Subjecs, s.School
WITH ROLLUP

--2.	Напишите запрос, который выводит минимальный балл учеников по школам и по предметам, и промежуточные итоги.

SELECT s.School, s.Subjecs, MIN(s.Scores) AS 'Минимальный_балл'
FROM dbo.Students s
GROUP BY s.School, s.Subjecs
WITH CUBE
--3.	Напишите запрос, который выводит средний балл учеников по школам и по предметам.

SELECT s.School, s.Subjecs, avg(s.Scores) AS 'Средний_балл'
FROM dbo.Students s
GROUP BY GROUPING SETS (s.School, s.Subjecs)

--4.	Напишите запрос, который выводит количество учеников по каждой школе по предметам и промежуточные итоги. NULL значения заменить на соответствующий текст.

SELECT COALESCE(s.Subjecs, 'ИТОГО') AS Предмет,
COALESCE(s.School, 'Итого')  AS Школа,
COUNT(s.Surname) AS Количество
FROM Students s
GROUP BY 
ROLLUP (s.Subjecs, s.School)

--5.	Напишите запрос, который выводит суммарный балл учеников по школам и по пред-метам, и промежуточные итоги. В итоговых строках NULL значения заменить на соответствующий текст в зависимости от группировки.

SELECT
IIF(GROUPING(s.Subjecs)=1, 'ИТОГО',s.Subjecs ) AS Предмет,
IIF(GROUPING(s.School)=1, 'Итого',s.School) AS Школа,
SUM(s.Scores) AS Сумма
FROM
Students s
GROUP BY
CUBE(s.Subjecs, s.School)

--6.	Напишите запрос, который выводит максимальный балл учеников по школам и по предметам. В итоговых строках NULL значения заменить на соответствующий текст в зависимости от уровней группировки.

SELECT
CASE GROUPING_ID(s.Subjecs, s.School)
WHEN 1 THEN 'Итого по предметам'
WHEN 3 THEN 'Итого'
ELSE ''
END AS Итого,
ISNULL(s.Subjecs, '') AS Предмет,
ISNULL(s.School, '') AS Школа,
MAX(s.Scores) AS Количество
FROM
Students s
GROUP BY
ROLLUP(s.Subjecs, s.School)


--7.	Напишите запрос, который выводит средний балл учеников по школам в столбцы.

SELECT
'Средний балл' AS [Средний балл учеников по школам], Лицей, Гимназия
FROM
(
SELECT
School, Scores
FROM Students 
) AS SOURCE_TABLE
PIVOT
(
AVG(Scores)
FOR School IN (Лицей, Гимназия)) AS PIVOT_TABLE

--8.	Напишите запрос, который выводит средний балл учеников по школам в столбцы и по предметам в строки.
SELECT
  School, Математика, Физика, Химия
FROM
(
	SELECT
	School, Subjecs, Scores
	FROM
	Students 
) AS SOURCE_TABLE
PIVOT
(
	AVG(Scores)
	FOR Subjecs IN (Математика, Физика, Химия)
) AS PIVOT_TABLE
--9.	Напишите запрос, который выводит названия предметов, фамилии учеников и школы в один столбец.
SELECT
				Surname, [Предмет или школа]
				FROM Students
				UNPIVOT (
				[Предмет или школа] FOR Значение IN (Subjecs, School)
				) unpvt



--Практика 17

--1.Создайте и запустите динамический SQL-запрос, выбирающий первые N строк из заданной таблицы.

DECLARE @DSQL VARCHAR(100)
DECLARE @TN VARCHAR(50)
SET @TN = 'Students'
SET @DSQL = 'SELECT TOP 5 * FROM ' + @TN
EXECUTE (@DSQL)

--2.Создайте и запустите динамический SQL-запрос, выбирающий все страны из таблицы «Страны», 
--последняя буква названия которых расположена в заданном диапазоне.

DECLARE @DSQL NVARCHAR(100)
DECLARE @TN NVARCHAR(50)
SET @TN = N'[а-я]'
SET @DSQL = N'SELECT Names FROM Countries WHERE Names LIKE N''%'+@TN+'''';
EXECUTE (@DSQL)

--3.Создайте временную таблицу #Temp и добавьте к ней название столбцов таблицы «Страны». 
--Создайте курсор, который, построчно читая таблицу #Temp, выбирает каждый раз соответствующий столбец из таблицы «Страны».

CREATE TABLE #TEMP
(
columnname NVARCHAR(50)
)

INSERT INTO #TEMP
VALUES
('Id_Countries'), ('Names'),
('Capital'), ('Rectangles'), ('Continent')

DECLARE TC CURSOR
FOR SELECT columnname FROM #TEMP
	OPEN TC
	DECLARE @TNN VARCHAR(50)
	FETCH FROM TC INTO @TNN
	WHILE @@FETCH_STATUS = 0
		BEGIN
		EXECUTE ('SELECT '+@TNN+' FROM Countries')
		FETCH FROM TC INTO @TNN
	END
	CLOSE TC
DEALLOCATE TC
DROP TABLE #TEMP

--4.Создайте процедуру, которая принимает как параметр список столбцов, название таблицы и выбирает 
--заданные столбцы из заданной таблицы.

CREATE PROCEDURE Primer4P
    @columns NVARCHAR(MAX),
    @table NVARCHAR(128)
AS
BEGIN
    DECLARE @query NVARCHAR(MAX);
    SET @query = 'SELECT ' + @columns + ' FROM ' + @table
    EXEC sp_executesql @query
END
EXEC Primer4P 'Id_Countries, Names', 'Countries'
DROP PROCEDURE Primer4P
--5.Создайте процедуру, принимающую как параметр список столбцов, название таб-лицы, название 
--проверяемого столбца, знак сравнения, значение проверки и выбирающую заданные столбцы из заданной таблицы в заданных условиях.

CREATE PROCEDURE Primer5P
    @columns_list NVARCHAR(MAX),
    @table_name NVARCHAR(128),
	@check_column NVARCHAR(128),
	@check_op NVARCHAR(128),
	@check_arg NVARCHAR(50)
AS
BEGIN
    DECLARE @query NVARCHAR(MAX)
    SET @query = 'SELECT ' + @columns_list + ' FROM ' + @table_name + ' WHERE ' + @check_column + ' '+ @check_op + ' ' + @check_arg
    EXEC sp_executesql @query
END

EXEC Primer5P 'Id_Countries, Names', 'Countries', 'Names', 'like', '''%н'''

--6.Выберите список европейских стран из таблицы «Страны» и экспортируйте в RAW формате XML.

SELECT * FROM Countries c
WHERE c.Continent = N'Европа'
FOR XML  RAW

--7.Выберите список стран с населением больше 100 млн. чел. из таблицы «Страны» и экспортируйте в PATH формате XML.

SELECT * FROM Countries c
WHERE c.People >100000000
FOR XML  PATH

--8.Выберите список учеников из школы «Лицей» из таблицы «Ученики» и экспорти-руйте в PATH формате JSON

SELECT * FROM Students s
WHERE s.School = 'Лицей'
FOR JSON  PATH