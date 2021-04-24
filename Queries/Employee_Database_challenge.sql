-- Retiring employees by title
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Unique titles
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- Retiring titles
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT(ut.emp_no) DESC;

-- Mentorship eligibility
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
	INNER JOIN dept_emp as de
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles as t
		ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no;

-- Mentors by departments
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	t.title,
	d.dept_name
INTO mentor_dept
FROM employees AS e
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no)
WHERE e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no;

-- Count of mentors by department
SELECT COUNT(md.emp_no), md.dept_name
INTO count_mentors
FROM mentor_dept AS md
GROUP BY md.dept_name
ORDER BY COUNT(md.emp_no) DESC;

-- Employees by department
SELECT de.emp_no,
	d.dept_name
INTO emp_dept_name
FROM dept_emp AS de
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no)
ORDER BY d.dept_name;

-- Count of employees by department name
SELECT COUNT(edn.emp_no), edn.dept_name
INTO count_dept
FROM emp_dept_name AS edn
GROUP BY edn.dept_name
ORDER BY COUNT(edn.emp_no) DESC;