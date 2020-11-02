use quanlynhansu;

-- 1. Lập danh sách tên phòng ban và đếm số nhân viên của phòng ban

SELECT a.department_name  , count(b.employee_id) AS 'tongsonhanvien'
FROM departments a JOIN  employees b    -- Lấy những giá trị chung của 2 bảng
ON a.department_id = b.department_id	-- Tham chiếu 2 id của 2 bảng với nhau
GROUP BY a.department_name;				-- Lấy theo tên phòng ban

-- 2.Lập danh sách tên phòng ban và luong trung bình của nhân viên trong phòng

SELECT a.department_name , AVG(b.salary) AS 'Lương trung binh'
FROM departments a JOIN employees b
ON a.department_id=b.department_id
GROUP BY a.department_name;

-- 3. Lập danh sách tên nhân viên và tên phòng ban mà nhân viên dó làm việc với INNER JOIN

SELECT a.first_name, a.last_name , b.department_name
FROM departments b INNER JOIN employees a
ON b.department_id=a.department_id;

-- 4.Đưa ra danh sách tên phòng ban và tên quốc gia phòng ban đang mở ở đó

SELECT a.department_name , b.country_name
FROM departments a JOIN locations c 
ON a.location_id=c.location_id
JOIN countries b
ON c.country_id=b.country_id;

-- 5.Lập danh sách tên các phòng ban có số nhân viên > 10

SELECT a.department_name  , count(b.employee_id) AS tongsonhanvien
FROM departments a JOIN  employees b 
ON a.department_id = b.department_id
GROUP BY a.department_name
HAVING count(b.employee_id) >10 ;

-- 6.Đưa ra tên các phòng ban có văn phòng mở ít nhất ở 3 quốc gia

SELECT  b.country_name , COUNT(a.department_name) AS 'tong so van phong'
FROM departments a JOIN locations c 
ON a.location_id=c.location_id
JOIN countries b
ON c.country_id=b.country_id
GROUP BY b.country_name
HAVING COUNT(a.department_name) >1;

-- 7.Đưa ra tên phòng ban và tên nhân viên có lương cao nhất trong phòng 

SELECT b.department_name, a.first_name, a.last_name , MAX(a.salary) AS 'Luong cao nhat'
FROM employees a JOIN departments b
ON a.department_id=b.department_id
GROUP BY b.department_name;

-- 8.Đưa ra danh sách tên các nhân viên có lương lớn hơn lương của mỗi nhân viên phòng 

-- SELECCT đầu tiên lấy tất cả luong nhân viên , SECLECT 2 lấy luong cao nhat cua phong iT
SELECT a.first_name, a.last_name , a.salary AS'Luong cao hon IT'
FROM employees a 
WHERE a.salary> (SELECT MAX(a.salary) 
FROM employees a JOIN departments b
ON a.department_id=b.department_id
GROUP BY b.department_name
HAVING b.department_name='IT');

SELECT a.first_name, a.last_name,b.department_name, a.salary AS'Luong cao hon IT'
FROM employees a JOIN departments b
ON a.department_id=b.department_id
GROUP BY a.first_name, a.last_name , b.department_name
HAVING a.salary > (MAX(a.salary) AND b.department_name='IT');


-- 9.Liệt kê tên các phòng ban có số nhân viên nhiều nhất

SELECT a.department_name  , count(b.employee_id) AS 'Tong nhan vien'
FROM departments a JOIN  employees b 
ON a.department_id = b.department_id
GROUP BY a.department_name
ORDER BY count(b.employee_id) DESC  -- sắp xếp tổng nhân viên từ cao đến thấp
LIMIT 1;

-- 10.Liệt kê tên các phòng ban có số nhân viên bằng 0

SELECT a.department_name  , count(b.employee_id) AS 'Tong nhan vien'
FROM departments a JOIN  employees b 
ON a.department_id = b.department_id
GROUP BY a.department_name
HAVING count(b.employee_id)=0;