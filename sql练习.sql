-- 1.查询出至少有一个员工的所有部门
SELECT DISTINCT d.*
FROM emp e,dept d
WHERE e.deptno = d.deptno
SELECT * FROM EMP   
-- 2.查询出部门名称和这些部门的员工信息，同时查询出没有员工的部门
SELECT d.dname,e.*
FROM dept d LEFT JOIN emp e
ON d.deptno = e.deptno
-- 3.查询所有“CLERK"(办事员) 的姓名和部门名称，以及部门人数
SELECT S2.NUM,S1.ENAME,S1.DNAME
FROM(SELECT E.ENAME,D.DNAME,E.DEPTNO FROM EMP E,DEPT D WHERE JOB='CLERK' AND E.DEPTNO=D.DEPTNO) S1,(SELECT COUNT(1) NUM,DEPTNO FROM EMP GROUP BY DEPTNO) S2
WHERE S1.DEPTNO=S2.DEPTNO
-- 4.查询出所有员工的姓名和直接上级的姓名
SELECT e1.ename,e2.ename
FROM emp e1 LEFT JOIN emp e2
ON e1.mgr=e2.empno

-- 5.查询各job的员工工资的最大值，最小值，平均值，总和
SELECT MAX(sal),MIN(SAL),AVG(nvl(SAL,0)),SUM(nvl(SAL,0)),JOB
FROM emp
GROUP BY JOB 
-- 6.选择统计各个job的员工人数(提示:对job进行分组)
SELECT COUNT(1),JOB FROM EMP GROUP BY JOB   
-- 7.查询员工最高工资和最低工资的差距,列名为DIFFERENCE；
SELECT (MAX(SAL)-MIN(SAL)) DIFFERENCE FROM EMP

-- 8.查询各个管理者属下员工的最低工资，其中最低工资不能低于800，没有管理者的员工不计算在内
SELECT e1.empno,MIN(e2.sal)
FROM emp e1,emp e2
WHERE e1.empno = e2.mgr GROUP BY e1.empno HAVING MIN(e2.sal) >= 800

-- 9.查询所有部门的部门名字dname，所在位置loc，员工数量和工资平均值； 
SELECT d2.*,d1.loc
FROM dept d1,(
SELECT COUNT(1) NUM,AVG(NVL(sal,0)) average,e.deptno
FROM emp e,dept d
WHERE e.deptno=d.deptno GROUP BY e.deptno) d2
WHERE d1.deptno=d2.deptno    

-- 10.查询和scott相同部门的员工姓名ename和雇用日期hiredate
SELECT ename,hiredate
FROM emp
WHERE deptno IN (SELECT deptno FROM emp WHERE ename='SCOTT')

--11.查询工资比公司平均工资高的所有员工的员工号empno，姓名ename和工资sal。
SELECT empno,ename,sal FROM emp WHERE sal>(SELECT AVG(NVL(sal,0)) FROM emp)

--12.查询和姓名中包含字母u的员工在相同部门的员工的员工号empno和姓名ename
SELECT empno,ename FROM emp WHERE deptno IN (SELECT deptno FROM emp WHERE ename LIKE '%U%')

--13.查询在部门的loc为newYork的部门工作的员工的员工姓名ename，部门名称dname和岗位名称job

SELECT e.ename,d.dname,e.job
FROM emp e,(SELECT deptno,dname FROM dept WHERE loc='NEW YORK') d
WHERE e.deptno=d.deptno
-- 14.查询管理者是king的员工姓名ename和工资sal
 
SELECT ename,sal
FROM emp
WHERE mgr IN (SELECT empno FROM emp WHERE ename='KING')

--15.显示sales部门有哪些职位
SELECT DISTINCT JOB,DEPTNO
FROM EMP
WHERE DEPTNO IN (SELECT deptno FROM dept WHERE dname='SALES')   

--16.各个部门中工资大于1500的员工人数
SELECT COUNT(1),deptno NUM FROM emp WHERE sal>1500 GROUP BY deptno 

--17.哪些员工的工资，高于整个公司的平均工资，列出员工的名字和工资（降序）
SELECT ename,sal
FROM emp
WHERE sal>(SELECT AVG(NVL(sal,0)) FROM emp ) ORDER BY sal DESC

-- 18.所在部门平均工资高于1500的员工名字
SELECT ename
FROM emp
WHERE deptno IN (SELECT deptno FROM emp GROUP BY deptno HAVING AVG(NVL(sal,0))>1500)
  
--19.列出各个部门中工资最高的员工的信息：名字、部门号、工资 
SELECT ename,deptno,sal
FROM emp
WHERE sal IN (SELECT MAX(sal) FROM emp GROUP BY deptno )

--20.哪个部门的平均工资是最高的，列出部门号、平均工资
SELECT s.* FROM (SELECT AVG(NVL(sal,0)),deptno FROM emp GROUP BY deptno ORDER BY AVG(NVL(sal,0)) DESC) s WHERE ROWNUM =1

--21.列出工资高于本部门平均工资的人的信息！
SELECT e.*
FROM emp e,(SELECT AVG(NVL(sal,0)) s,deptno FROM emp GROUP BY deptno) d
WHERE e.deptno=d.deptno AND e.sal>d.s
