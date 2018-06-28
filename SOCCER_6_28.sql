select * From TEAM;
select TEAM_NAME, TEAM_ID From TEAM;
select * from tab;



-- SOCCER_SQL_001
SELECT 
    COUNT(*) "���̺��� ��" 
FROM TAB;
-- SOCCER_SQL_002
SELECT 
    TEAM_NAME "��ü �౸�� ���" 
FROM TEAM
ORDER BY TEAM_NAME DESC
;
-- SOCCER_SQL_003
-- ������ ����(�ߺ�����,������ �������� ����)
-- NVL2()
SELECT DISTINCT NVL2(POSITION,POSITION,'����') "������" 
FROM PLAYER;
-- SOCCER_SQL_004
-- ������(ID: K02)��Ű��
SELECT PLAYER_NAME �̸�
FROM PLAYER
WHERE TEAM_ID = 'K02'
    AND POSITION = 'GK'
ORDER BY PLAYER_NAME 
;

-- SOCCER_SQL_005
-- ������(ID: K02)Ű�� 170 �̻� ����
-- �̸鼭 ���� ���� ����
SELECT POSITION ������,PLAYER_NAME �̸�
FROM PLAYER
WHERE HEIGHT >= 170
    AND TEAM_ID LIKE 'K02'
    AND SUBSTR(PLAYER_NAME,0,1) LIKE '��'
ORDER BY PLAYER_NAME 
;
-- SUBSTR('ȫ�浿',2,2) �ϸ�
-- �浿�� ��µǴµ�
-- ��2�� ������ġ, ��2�� ���ڼ��� ����
SELECT SUBSTR(PLAYER_NAME,2,2) �׽�Ʈ��
FROM PLAYER
;
-- �ٸ� Ǯ��(����)
SELECT POSITION ������,PLAYER_NAME �̸�
FROM PLAYER
WHERE HEIGHT >= 170
    AND TEAM_ID LIKE 'K02'
    AND PLAYER_NAME LIKE '��%'
ORDER BY PLAYER_NAME 
;


-- SOCCER_SQL_006
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� CM �� KG ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- Ű ��������
SELECT 
    PLAYER_NAME || '����' �̸�,
    NVL2(HEIGHT,HEIGHT,0) || 'CM' Ű,
    NVL2(WEIGHT,WEIGHT,0) || 'KG' ������
FROM PLAYER
WHERE TEAM_ID LIKE 'K02'
ORDER BY HEIGHT DESC
;

-- SOCCER_SQL_007
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� CM �� KG ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- BMI���� 
-- Ű ��������
SELECT 
    PLAYER_NAME || '����' �̸�,
    NVL2(HEIGHT,HEIGHT,0) || 'CM' Ű,
    NVL2(WEIGHT,WEIGHT,0) || 'KG' ������,
    ROUND(WEIGHT/((HEIGHT/100)*(HEIGHT/100)),2) "BMI ������"
FROM PLAYER
WHERE TEAM_ID = 'K02'
ORDER BY HEIGHT DESC
;

-- SOCCER_SQL_008
-- ������(ID: K02) �� ������(ID: K10)������ �� ��
-- GK �������� ����
-- ����, ����� ��������
SELECT 
    T.TEAM_NAME,
    P.POSITION,
    P.PLAYER_NAME 
FROM PLAYER P, TEAM T
WHERE T.TEAM_ID = P.TEAM_ID
    AND T.TEAM_ID IN ( 'K02', 'K10')
    AND P.POSITION LIKE 'GK'
ORDER BY T.TEAM_NAME, P.PLAYER_NAME
;
-- ANSI JOIN ���(����)
SELECT 
    T.TEAM_NAME,
    P.POSITION,
    P.PLAYER_NAME 
FROM PLAYER P
INNER JOIN TEAM T
ON T.TEAM_ID LIKE P.TEAM_ID
WHERE T.TEAM_ID IN ( 'K02', 'K10')
    AND P.POSITION LIKE 'GK'
ORDER BY T.TEAM_NAME, P.PLAYER_NAME
;

-- SOCCER_SQL_009
-- ������(ID: K02) �� ������(ID: K10)������ �� ��
-- Ű�� 180 �̻� 183 ������ ������
-- Ű, ����, ����� ��������

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


-- SOCCER_SQL_010
--  ��� ������ ��
-- �������� �������� ���� �������� ���� �̸�
-- ����, ����� ��������

SELECT t.team_name, p.player_name 
FROM player p
    Join team t
    ON p.Team_id=t.team_id
WHERE p.position is null
ORDER BY team_name, player_name
;

-- SOCCER_SQL_011
-- ���̸�, ��Ÿ��� �̸� ���

SELECT t.team_name ����, s.stadium_name ��Ÿ���
FROM stadium s
    JOIN team t
    ON s.stadium_id like t.stadium_id
ORDER BY t.team_name
;


-- SOCCER_SQL_012
-- 2012�� 3�� 17�Ͽ� ���� �� ����� 
-- ���̸�, ��Ÿ���, ������� �̸� ���

SELECT t.team_name "����", st.stadium_name "��Ÿ���", sc.awayteam_id "������ID", sc.sche_date "�����쳯¥"
FROM stadium st
    JOIN schedule sc
    ON sc.stadium_id like st.stadium_id
    JOIN team t 
    ON  t.stadium_id like st.stadium_id
where sc.sche_date like '20120317'
ORDER BY t.team_name
;


-- SOCCER_SQL_013
-- 2012�� 3�� 17�� ��⿡ 
-- ���� ��ƿ���� �Ҽ� ��Ű��(GK)
-- ����, ������,���� (����������), 
-- ��Ÿ���, ��⳯¥�� ���Ͻÿ�
-- �������� ���̸��� ������ ���ÿ�

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

-- SOCCER_SQL_014
-- Ȩ���� 3���̻� ���̷� �¸��� ����� 
-- ����� �̸�, ��� ����
-- Ȩ�� �̸��� ������ �̸���
-- ���Ͻÿ�

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


-- SOCCER_SQL_015
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������

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


-- SOCCER_SQL_016
-- �Ҽ��� �Ｚ ������� ���� �������
-- ���� �巡�������� �������� ���� ����
---- UNION VERSION
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

-- SOCCER_SQL_017
-- �Ҽ��� �Ｚ ������� ���� �������
-- ���� �巡�������� �������� ���� ����
---- SUBQUERY VERSION




-- 018
-- ��ȣ�� ������ �Ҽ����� ������, ��ѹ��� �����Դϱ�

SELECT 
    p.player_name �̸�, t.team_name �Ҽ���, p.position ������, p.back_no ��ѹ�
FROM 
    player p
    JOIN team t
        ON t.team_id like p.team_id
WHERE 
    p.player_name like '��ȣ��'
;


-- 019
-- ������Ƽ���� MF ���Ű�� ���Դϱ�? 174.87

SELECT 
    round(AVG(p.height), 2) "��� Ű"
fROM 
    player p
    JOIN team t
        ON t.team_id like p.team_id
WHERE 
    p.position like 'MF'
    AND t.team_name like '��Ƽ��'
;


-- 020
-- 2012�� ���� ������ ���Ͻÿ�


--�ϴ� 2012�� 1�� ��ñ��� ���Ͻÿ��� �����ϰ� �ڵ��� ��.
SELECT  
        (select count(*) from schedule sc where sc.sche_date like '201201%') AS"1��",
        (select count(*) from schedule sc where sc.sche_date like '201202%') AS"2��",
        (select count(*) from schedule sc where sc.sche_date like '201203%') AS"3��", 
        (select count(*) from schedule sc where sc.sche_date like '201204%') AS"4��",
        (select count(*) from schedule sc where sc.sche_date like '201205%') AS"5��",
        (select count(*) from schedule sc where sc.sche_date like '201206%') AS"6��",
        (select count(*) from schedule sc where sc.sche_date like '201207%') AS"7��",
        (select count(*) from schedule sc where sc.sche_date like '201208%') AS"8��",
        (select count(*) from schedule sc where sc.sche_date like '201209%') AS"9��",
        (select count(*) from schedule sc where sc.sche_date like '201210%') AS"10��",
        (select count(*) from schedule sc where sc.sche_date like '201211%') AS"11��",
        (select count(*) from schedule sc where sc.sche_date like '201212%') AS"12��"
               
from 
    dual

;



SELECT 
    DISTINCT SUBSTR(sc.sche_date, 5, 2) �� ,
    count( SUBSTR(sc.sche_date, 5, 2) ) ����
FROM 
    schedule sc
GROUP BY 
    SUBSTR(sc.sche_date, 5, 2)
ORDER BY 
    SUBSTR(sc.sche_date, 5, 2)
;









-- 021
-- 2012�� ���� ����� ����(GUBUN IS YES)�� ���Ͻÿ�
-- ����� 1��:20��� �̷�������...


SELECT  
                (select count(*) from schedule sc where sc.sche_date like '201201%' AND sc.gubun like 'Y') AS"1��",
                (select count(*) from schedule sc where sc.sche_date like '201202%'AND sc.gubun like 'Y') AS"2��",
                (select count(*) from schedule sc where sc.sche_date like '201203%'AND sc.gubun like 'Y') AS"3��", 
                (select count(*) from schedule sc where sc.sche_date like '201204%'AND sc.gubun like 'Y') AS"4��",
                (select count(*) from schedule sc where sc.sche_date like '201205%'AND sc.gubun like 'Y') AS"5��",
                (select count(*) from schedule sc where sc.sche_date like '201206%'AND sc.gubun like 'Y') AS"6��",
                (select count(*) from schedule sc where sc.sche_date like '201207%'AND sc.gubun like 'Y') AS"7��",
                (select count(*) from schedule sc where sc.sche_date like '201208%'AND sc.gubun like 'Y') AS"8��",
                (select count(*) from schedule sc where sc.sche_date like '201209%'AND sc.gubun like 'Y') AS"9��",
                (select count(*) from schedule sc where sc.sche_date like '201210%'AND sc.gubun like 'Y') AS"10��",
                (select count(*) from schedule sc where sc.sche_date like '201211%'AND sc.gubun like 'Y') AS"11��",
                (select count(*) from schedule sc where sc.sche_date like '201212%'AND sc.gubun like 'Y') AS"12��"
                
from dual
;

desc schedule



-- 022
-- 2012�� 9�� 14�Ͽ� ������ ���� ���� ����Դϱ�
-- Ȩ��: ?   ������: ? �� ���
SELECT 
    ht.team_name Ȩ��, at.team_name ������
FROM 
    schedule sc
    JOIN team ht
        ON ht.TEAM_id like sc.hometeam_id
    Join team at
        ON at.team_id like sc.awayteam_id
WHERE 
    sc.sche_date = '20120914'
ORDER BY 
    ht.team_name
;
--023
-- GROUP BY ���
--���� ������ ��
--������ũ 20��
--�巡���� 19��
-- ...
SELECT 
    (select team_name from team where team_id = T.team_id) ���̸�,
    COUNT(P.PLAYER_ID) �����ο�
from PLAYER P
    JOIN TEAM T
        ON T.TEAM_ID = P.TEAM_ID       
GROUP BY 
    T.TEAM_ID
ORDER BY 
    T.TEam_id
;       
 
--024
--���� ��Ű���� ���Ű
--������ũ 180cm
--�巡���� 178cm
--    ....

SELECT 
    t.team_name ����, round(avg(p.height),0)||'cm' ���Ű
FROM 
    player p
    JOIN team t
        ON t.team_id = p.team_id
WHERE p.position like 'GK'        
GROUP BY 
    t.team_name
ORDER BY 
    t.team_name
;    

CREATE TABLE teamz(
    TEAM_ID VARCHAR2(20) PRIMARY KEY,
    TEAM_NAME VARCHAR2(20)
);

CREATE TABLE teamw(
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    TEAM_ID VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    MEM_AGE DECIMAL
);

update teamw set mem_name = '����'
where mem_id like (select mem_id from teamw where mem_name like '�¿�');

update teamw set mem_age = '27'
where mem_id like (select mem_id from teamw where mem_name like'����' AND mem_AGE like '26');

alter table teamw add constraint teamz_fk_team_id foreign key (team_id) references teamz(team_id);

ALTER TABLE teamw
add roll VARCHAR2(20);

select * from teamw;



select (select team_name from teamz where team_id = w.team_id) ����,
    count(*) ������,
    SUM(w.mem_age) ������,
    MAX(w.mem_age) �ִ볪��,
    MIN(w.mem_age) �ּҳ���,
    AVG(w.mem_age) ��տ���
FROM teamw w
GROUP BY w.team_id
ORDER BY MAX(w.mem_age)
;


SELECT
    PLAYER_NAME,
    CASE
        WHEN POSITION IS NULL THEN '����'
        WHEN POSITION LIKE 'GK' THEN '��Ű��'
        WHEN POSITION LIKE 'MF' THEN '�̵��ʴ�'
        WHEN POSITION LIKE 'DF' THEN '�����'
        WHEN POSITION LIKE 'FW' THEN '���ݼ�'
        ELSE POSITION
    END ������
FROM PLAYER
WHERE
    TEAM_ID='K08'
;

select (select team_name from teamz where team_id = w.team_id) ����,
    count(*) ������,
    SUM(w.mem_age) ������,
    MAX(w.mem_age) �ִ볪��,
    MIN(w.mem_age) �ּҳ���,
    AVG(w.mem_age) ��տ���
FROM teamw w
GROUP BY w.team_id
HAVING AVG(w.mem_age) >=28
ORDER BY w.team_id
;


UPDATE teamw 
    SET roll = 
        case 
            WHEN mem_id in('1','6','11','16') THEN '����'
            ELSE '����'
        END;
    


select * from teamw;

