select * From TEAM;
select TEAM_NAME, TEAM_ID From TEAM;
select * from tab;



SELECT team_name "��ü �౸�� ���"
FROM team
order by team_name
;
--select from order by ;

SELECT DISTINCT NV12(position, position ,'����') "������"
from player;

SELECT player_name
"�̸�"
From player
WHERE team_id ='K02'
    AND position = 'GK'
ORDER BY player_name
; 

SELECT position as "������", player_name as"�̸�"
From player
WHERE substr(player_name,1,1) like '��'
    AND team_id like 'K02'
    AND height>=170
ORDER BY player_name
;

SELECT position as "������", player_name as"�̸�"
From player
WHERE player_name like '%��%'
    AND team_id like 'K02'
    AND height>=170
ORDER BY player_name
;

SELECT player_name|| '����' �̸�, NVL2(height,height,0)||'cm' Ű, NVL2(weight,weight,0)||'kg' as ������
From player
WHERE team_id like 'K02'
ORDER BY height desc
;

--7
SELECT player_name|| '����' �̸�, NVL2(height,height,0)||'cm' "Ű", NVL2(weight,weight,0)||'kg' as "������", round(weight/power((height/100),2),2) as"bmi����"
From player
WHERE team_id like 'K02'
ORDER BY height desc
;


--8
select team_name , player_name
from team t, player p
where t.team_id=p.team_id
       And position is null
order by team_name asc, player_name asc
;

--8
select team_name , player_name
from player p
inner join team t
on t.team_id like p.team_id

where position is null
order by team_name asc, player_name asc
;

--9
SELECT height||'cm' Ű , team_name ����, player_name �̸�
FROM team t, player p
WHERE t.team_id = p.team_id
    AND t.team_id IN('K02','K10')
    AND height BETWEEN 180 and 183
ORDER BY height , team_name, player_name
;
--inner join
SELECT p.height||'cm' Ű , t.team_name ����, p.player_name �̸�
FROM player p
INNER JOIN team t
ON p.team_id IN('K02','K10')
WHERE t.team_id like p.team_id
    AND p.height BETWEEN 180 and 183
ORDER BY p.height , t.team_name, p.player_name
;

SELECT p.height||'cm' Ű , t.team_name ����, p.player_name �̸�
FROM player p
    JOIN team t
    ON t.team_id like p.team_id
WHERE t.team_id IN('K02','K10')
    AND p.height BETWEEN 180 and 183
ORDER BY p.height , t.team_name, p.player_name
;


--10
SELECT t.team_name, p.player_name 
FROM player p
    Join team t
    ON p.Team_id=t.team_id
WHERE p.position is null
ORDER BY team_name, player_name
;

--11
SELECT t.team_name ����, s.stadium_name ��Ÿ���
FROM stadium s
    JOIN team t
    ON s.stadium_id like t.stadium_id
ORDER BY t.team_name
;


--12
SELECT t.team_name "����", st.stadium_name "��Ÿ���", sc.awayteam_id "������ID", sc.sche_date "�����쳯¥"
FROM stadium st
    JOIN schedule sc
    ON sc.stadium_id like st.stadium_id
    JOIN team t 
    ON  t.stadium_id like st.stadium_id
where sc.sche_date like '20120317'
ORDER BY t.team_name
;

--13
SELECT p.player_name ������, p.position ������,t.REGION_NAME||' '||t.team_name ����,
       st.stadium_name ��Ÿ���, sc.sche_date "�����쳯¥"
FROM player p
    JOIN team t
    ON t.team_id like p.team_id
    JOIN stadium st
    ON st.stadium_id like t.stadium_id
    JOIN schedule sc
    ON sc.stadium_id like st.stadium_id
WHERE p.team_ID like 'K03'
    AND p.position like 'GK'
    AND sc.SCHE_DATE like '20120317'
ORDER BY p.player_name
;

--14
SELECT
    st.stadium_name ��Ÿ���, sc.sche_date "��⳯¥",
    t1.region_name|| ' '||t1.team_name as "Ȩ��",
    t2.region_name|| ' '||t2.team_name ������,
    sc.home_score "Ȩ�� ����", sc.away_Score AS "������ ����"
FROM
    StAdIuM st
    join schedule sc
        ON st.stadium_id like sc.stadium_id
    JOIN team t1
        ON t1.team_id like sc.hometeam_id
    JOIN team t2
        ON t2.team_id like sc.awayteam_id
WHERE 
    (sc.home_score - sc.away_score) >= 3
ORDER BY 
    sc.sche_date
;


--15
SELECT 
    st.stadium_name,
    t.stadium_id,
    st.seat_count,
    st.hometeam_id,
    t.e_team_name
FROM 
    sTaDiUm st
    LEFT JOIN team t
        ON t.stadium_id = st.stadium_id
ORDER BY 
    st.hometeam_id
;


--17
SELECT 
    t.team_name ����,
    p.position ������,
    p.back_no ��ѹ�,
    p.height Ű
FROM player p
    JOIN team t
    ON t.TEAM_ID like p.Team_id
WHERE
    t.team_ID IN(
    select team_id 
     from team 
     where team_name IN('�Ｚ�������','�巡����'))
ORDER BY t.team_name
;


--18
SELECT p.player_name �̸�, t.team_name �Ҽ���, p.position ������, p.back_no ��ѹ�
FROM player p
    JOIN team t
        ON t.team_id like p.team_id
WHERE p.player_name like '��ȣ��'
;


--19
SELECT round(AVG(p.height), 2) "��� Ű"
fROM player p
    JOIN team t
        ON t.team_id like p.team_id
WHERE p.position like 'MF'
    AND t.team_name like '��Ƽ��'
;


--20
SELECT DISTINCT SUBSTR(sc.sche_date, 5, 2) �� , count( SUBSTR(sc.sche_date, 5, 2) ) ����
FROM schedule sc
GROUP BY SUBSTR(sc.sche_date, 5, 2)
ORDER BY SUBSTR(sc.sche_date, 5, 2)
;