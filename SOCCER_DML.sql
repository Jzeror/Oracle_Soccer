select * From TEAM;
select TEAM_NAME, TEAM_ID From TEAM;
select * from tab;



SELECT team_name "전체 축구팀 목록"
FROM team
order by team_name
;
--select from order by ;

SELECT DISTINCT NV12(position, position ,'신입') "포지션"
from player;

SELECT player_name
"이름"
From player
WHERE team_id ='K02'
    AND position = 'GK'
ORDER BY player_name
; 

SELECT position as "포지션", player_name as"이름"
From player
WHERE substr(player_name,1,1) like '고'
    AND team_id like 'K02'
    AND height>=170
ORDER BY player_name
;

SELECT position as "포지션", player_name as"이름"
From player
WHERE player_name like '%고%'
    AND team_id like 'K02'
    AND height>=170
ORDER BY player_name
;

SELECT player_name|| '선수' 이름, NVL2(height,height,0)||'cm' 키, NVL2(weight,weight,0)||'kg' as 몸무게
From player
WHERE team_id like 'K02'
ORDER BY height desc
;

--7
SELECT player_name|| '선수' 이름, NVL2(height,height,0)||'cm' "키", NVL2(weight,weight,0)||'kg' as "몸무게", round(weight/power((height/100),2),2) as"bmi지수"
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
SELECT height||'cm' 키 , team_name 팀명, player_name 이름
FROM team t, player p
WHERE t.team_id = p.team_id
    AND t.team_id IN('K02','K10')
    AND height BETWEEN 180 and 183
ORDER BY height , team_name, player_name
;
--inner join
SELECT p.height||'cm' 키 , t.team_name 팀명, p.player_name 이름
FROM player p
INNER JOIN team t
ON p.team_id IN('K02','K10')
WHERE t.team_id like p.team_id
    AND p.height BETWEEN 180 and 183
ORDER BY p.height , t.team_name, p.player_name
;

SELECT p.height||'cm' 키 , t.team_name 팀명, p.player_name 이름
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
SELECT t.team_name 팀명, s.stadium_name 스타디움
FROM stadium s
    JOIN team t
    ON s.stadium_id like t.stadium_id
ORDER BY t.team_name
;


--12
SELECT t.team_name "팀명", st.stadium_name "스타디움", sc.awayteam_id "원정팀ID", sc.sche_date "스케쥴날짜"
FROM stadium st
    JOIN schedule sc
    ON sc.stadium_id like st.stadium_id
    JOIN team t 
    ON  t.stadium_id like st.stadium_id
where sc.sche_date like '20120317'
ORDER BY t.team_name
;

--13
SELECT p.player_name 선수명, p.position 포지션,t.REGION_NAME||' '||t.team_name 팀명,
       st.stadium_name 스타디움, sc.sche_date "스케쥴날짜"
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
    st.stadium_name 스타디움, sc.sche_date "경기날짜",
    t1.region_name|| ' '||t1.team_name as "홈팀",
    t2.region_name|| ' '||t2.team_name 원정팀,
    sc.home_score "홈팀 점수", sc.away_Score AS "원정팀 점수"
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
    t.team_name 팀명,
    p.position 포지션,
    p.back_no 백넘버,
    p.height 키
FROM player p
    JOIN team t
    ON t.TEAM_ID like p.Team_id
WHERE
    t.team_ID IN(
    select team_id 
     from team 
     where team_name IN('삼성블루윙즈','드래곤즈'))
ORDER BY t.team_name
;


--18
SELECT p.player_name 이름, t.team_name 소속팀, p.position 포지션, p.back_no 백넘버
FROM player p
    JOIN team t
        ON t.team_id like p.team_id
WHERE p.player_name like '최호진'
;


--19
SELECT round(AVG(p.height), 2) "평균 키"
fROM player p
    JOIN team t
        ON t.team_id like p.team_id
WHERE p.position like 'MF'
    AND t.team_name like '시티즌'
;


--20
SELECT DISTINCT SUBSTR(sc.sche_date, 5, 2) 월 , count( SUBSTR(sc.sche_date, 5, 2) ) 경기수
FROM schedule sc
GROUP BY SUBSTR(sc.sche_date, 5, 2)
ORDER BY SUBSTR(sc.sche_date, 5, 2)
;