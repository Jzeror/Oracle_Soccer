select * From TEAM;
select TEAM_NAME, TEAM_ID From TEAM;
select * from tab;



-- SOCCER_SQL_001
SELECT 
    COUNT(*) "테이블의 수" 
FROM TAB;
-- SOCCER_SQL_002
SELECT 
    TEAM_NAME "전체 축구팀 목록" 
FROM TEAM
ORDER BY TEAM_NAME DESC
;
-- SOCCER_SQL_003
-- 포지션 종류(중복제거,없으면 신입으로 기재)
-- NVL2()
SELECT DISTINCT NVL2(POSITION,POSITION,'신입') "포지션" 
FROM PLAYER;
-- SOCCER_SQL_004
-- 수원팀(ID: K02)골키퍼
SELECT PLAYER_NAME 이름
FROM PLAYER
WHERE TEAM_ID = 'K02'
    AND POSITION = 'GK'
ORDER BY PLAYER_NAME 
;

-- SOCCER_SQL_005
-- 수원팀(ID: K02)키가 170 이상 선수
-- 이면서 성이 고씨인 선수
SELECT POSITION 포지션,PLAYER_NAME 이름
FROM PLAYER
WHERE HEIGHT >= 170
    AND TEAM_ID LIKE 'K02'
    AND SUBSTR(PLAYER_NAME,0,1) LIKE '고'
ORDER BY PLAYER_NAME 
;
-- SUBSTR('홍길동',2,2) 하면
-- 길동이 출력되는데
-- 앞2는 시작위치, 뒤2는 글자수를 뜻함
SELECT SUBSTR(PLAYER_NAME,2,2) 테스트값
FROM PLAYER
;
-- 다른 풀이(권장)
SELECT POSITION 포지션,PLAYER_NAME 이름
FROM PLAYER
WHERE HEIGHT >= 170
    AND TEAM_ID LIKE 'K02'
    AND PLAYER_NAME LIKE '고%'
ORDER BY PLAYER_NAME 
;


-- SOCCER_SQL_006
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 CM 와 KG 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- 키 내림차순
SELECT 
    PLAYER_NAME || '선수' 이름,
    NVL2(HEIGHT,HEIGHT,0) || 'CM' 키,
    NVL2(WEIGHT,WEIGHT,0) || 'KG' 몸무게
FROM PLAYER
WHERE TEAM_ID LIKE 'K02'
ORDER BY HEIGHT DESC
;

-- SOCCER_SQL_007
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 CM 와 KG 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- BMI지수 
-- 키 내림차순
SELECT 
    PLAYER_NAME || '선수' 이름,
    NVL2(HEIGHT,HEIGHT,0) || 'CM' 키,
    NVL2(WEIGHT,WEIGHT,0) || 'KG' 몸무게,
    ROUND(WEIGHT/((HEIGHT/100)*(HEIGHT/100)),2) "BMI 비만지수"
FROM PLAYER
WHERE TEAM_ID = 'K02'
ORDER BY HEIGHT DESC
;

-- SOCCER_SQL_008
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- GK 포지션인 선수
-- 팀명, 사람명 오름차순
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
-- ANSI JOIN 사용(권장)
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
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- 키가 180 이상 183 이하인 선수들
-- 키, 팀명, 사람명 오름차순

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


-- SOCCER_SQL_010
--  모든 선수들 중
-- 포지션을 배정받지 못한 선수들의 팀과 이름
-- 팀명, 사람명 오름차순

SELECT t.team_name, p.player_name 
FROM player p
    Join team t
    ON p.Team_id=t.team_id
WHERE p.position is null
ORDER BY team_name, player_name
;

-- SOCCER_SQL_011
-- 팀이름, 스타디움 이름 출력

SELECT t.team_name 팀명, s.stadium_name 스타디움
FROM stadium s
    JOIN team t
    ON s.stadium_id like t.stadium_id
ORDER BY t.team_name
;


-- SOCCER_SQL_012
-- 2012년 3월 17일에 열린 각 경기의 
-- 팀이름, 스타디움, 어웨이팀 이름 출력

SELECT t.team_name "팀명", st.stadium_name "스타디움", sc.awayteam_id "원정팀ID", sc.sche_date "스케쥴날짜"
FROM stadium st
    JOIN schedule sc
    ON sc.stadium_id like st.stadium_id
    JOIN team t 
    ON  t.stadium_id like st.stadium_id
where sc.sche_date like '20120317'
ORDER BY t.team_name
;


-- SOCCER_SQL_013
-- 2012년 3월 17일 경기에 
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함), 
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오

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

-- SOCCER_SQL_014
-- 홈팀이 3점이상 차이로 승리한 경기의 
-- 경기장 이름, 경기 일정
-- 홈팀 이름과 원정팀 이름을
-- 구하시오

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


-- SOCCER_SQL_015
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록

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
-- 소속이 삼성 블루윙즈 팀인 선수들과
-- 전남 드래곤즈팀인 선수들의 선수 정보
---- UNION VERSION
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

-- SOCCER_SQL_017
-- 소속이 삼성 블루윙즈 팀인 선수들과
-- 전남 드래곤즈팀인 선수들의 선수 정보
---- SUBQUERY VERSION




-- 018
-- 최호진 선수의 소속팀과 포지션, 백넘버는 무엇입니까

SELECT 
    p.player_name 이름, t.team_name 소속팀, p.position 포지션, p.back_no 백넘버
FROM 
    player p
    JOIN team t
        ON t.team_id like p.team_id
WHERE 
    p.player_name like '최호진'
;


-- 019
-- 대전시티즌의 MF 평균키는 얼마입니까? 174.87

SELECT 
    round(AVG(p.height), 2) "평균 키"
fROM 
    player p
    JOIN team t
        ON t.team_id like p.team_id
WHERE 
    p.position like 'MF'
    AND t.team_name like '시티즌'
;


-- 020
-- 2012년 월별 경기수를 구하시오


--일단 2012년 1월 경시구를 구하시오로 생각하고 코딩할 것.
SELECT  
        (select count(*) from schedule sc where sc.sche_date like '201201%') AS"1월",
        (select count(*) from schedule sc where sc.sche_date like '201202%') AS"2월",
        (select count(*) from schedule sc where sc.sche_date like '201203%') AS"3월", 
        (select count(*) from schedule sc where sc.sche_date like '201204%') AS"4월",
        (select count(*) from schedule sc where sc.sche_date like '201205%') AS"5월",
        (select count(*) from schedule sc where sc.sche_date like '201206%') AS"6월",
        (select count(*) from schedule sc where sc.sche_date like '201207%') AS"7월",
        (select count(*) from schedule sc where sc.sche_date like '201208%') AS"8월",
        (select count(*) from schedule sc where sc.sche_date like '201209%') AS"9월",
        (select count(*) from schedule sc where sc.sche_date like '201210%') AS"10월",
        (select count(*) from schedule sc where sc.sche_date like '201211%') AS"11월",
        (select count(*) from schedule sc where sc.sche_date like '201212%') AS"12월"
               
from 
    dual

;



SELECT 
    DISTINCT SUBSTR(sc.sche_date, 5, 2) 월 ,
    count( SUBSTR(sc.sche_date, 5, 2) ) 경기수
FROM 
    schedule sc
GROUP BY 
    SUBSTR(sc.sche_date, 5, 2)
ORDER BY 
    SUBSTR(sc.sche_date, 5, 2)
;









-- 021
-- 2012년 월별 진행된 경기수(GUBUN IS YES)를 구하시오
-- 출력은 1월:20경기 이런식으로...


SELECT  
                (select count(*) from schedule sc where sc.sche_date like '201201%' AND sc.gubun like 'Y') AS"1월",
                (select count(*) from schedule sc where sc.sche_date like '201202%'AND sc.gubun like 'Y') AS"2월",
                (select count(*) from schedule sc where sc.sche_date like '201203%'AND sc.gubun like 'Y') AS"3월", 
                (select count(*) from schedule sc where sc.sche_date like '201204%'AND sc.gubun like 'Y') AS"4월",
                (select count(*) from schedule sc where sc.sche_date like '201205%'AND sc.gubun like 'Y') AS"5월",
                (select count(*) from schedule sc where sc.sche_date like '201206%'AND sc.gubun like 'Y') AS"6월",
                (select count(*) from schedule sc where sc.sche_date like '201207%'AND sc.gubun like 'Y') AS"7월",
                (select count(*) from schedule sc where sc.sche_date like '201208%'AND sc.gubun like 'Y') AS"8월",
                (select count(*) from schedule sc where sc.sche_date like '201209%'AND sc.gubun like 'Y') AS"9월",
                (select count(*) from schedule sc where sc.sche_date like '201210%'AND sc.gubun like 'Y') AS"10월",
                (select count(*) from schedule sc where sc.sche_date like '201211%'AND sc.gubun like 'Y') AS"11월",
                (select count(*) from schedule sc where sc.sche_date like '201212%'AND sc.gubun like 'Y') AS"12월"
                
from dual
;

desc schedule



-- 022
-- 2012년 9월 14일에 벌어질 경기는 어디와 어디입니까
-- 홈팀: ?   원정팀: ? 로 출력
SELECT 
    ht.team_name 홈팀, at.team_name 원정팀
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
-- GROUP BY 사용
--팀별 선수의 수
--아이파크 20명
--드래곤즈 19명
-- ...
SELECT 
    (select team_name from team where team_id = T.team_id) 팀이름,
    COUNT(P.PLAYER_ID) 선수인원
from PLAYER P
    JOIN TEAM T
        ON T.TEAM_ID = P.TEAM_ID       
GROUP BY 
    T.TEAM_ID
ORDER BY 
    T.TEam_id
;       


--024
--팀별 골키퍼의 평균키
--아이파크 180cm
--드래곤즈 178cm
--    ....

SELECT 
    t.team_name 팀명, round(avg(p.height),0)||'cm' 평균키
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


select * from teamw;


select    ROWNUM "NO." ,a.*
FROM (SELECT 
    t.team_name 팀명,
    p.position 포지션,
    p.back_no 백넘버,
    p.height "키(cm)"
    FROM player p
    JOIN team t
        ON t.TEAM_ID like p.Team_id
    WHERE
    t.team_ID LIKE(
    select team_id 
    from team 
    where team_name like '삼성블루윙즈')
    ORDER BY p.height desc) a
;



--가상테이블 기존에 있던 테이블을 가져다가 가상으로 조합. 그러나 공간 점유는 함. 연산이 끝나면 제거됨.
(SELECT 
    t.team_name 팀명,
    p.position 포지션,
    p.back_no 백넘버,
    p.height "키(cm)"
FROM player p
    JOIN team t
    ON t.TEAM_ID like p.Team_id
WHERE
    t.team_ID LIKE(
    select team_id 
    from team 
    where team_name like '삼성블루윙즈')
ORDER BY p.height desc) 
;


--키가 널 값인 사람은 제외

select    ROWNUM "NO." ,a.*
FROM (SELECT 
    t.team_name 팀명,
    p.position 포지션,
    p.back_no 백넘버,
    p.height "키(cm)"
    FROM player p
    JOIN team t
        ON t.TEAM_ID like p.Team_id
    WHERE
    t.team_ID LIKE(
    select team_id 
    from team 
    where team_name like '삼성블루윙즈')
        AND NOT p.height is null
    ORDER BY p.height desc) a
;


select    
    ROWNUM "NO." ,
    a.*
FROM (SELECT 
    t.team_name 팀명,
    p.position 포지션,
    p.back_no 백넘버,
    p.height "키(cm)"
    FROM player p
    JOIN team t
        ON t.TEAM_ID like p.Team_id
    WHERE
    t.team_ID LIKE(
    select team_id 
    from team 
    where team_name like '삼성블루윙즈')
        AND NOT p.height is null        
    ORDER BY p.height desc) a
WHERE ROWNUM <= 10
;

--026
--삼성블루윙즈에서 키 10위부터 20위까지 찾기.

SELECT
     b.*
FROM (
    SELECT    
        ROWNUM NO ,
        a.*
    FROM (
        SELECT 
            t.team_name 팀명,
            p.position 포지션,
            p.back_no 백넘버,
            p.height "키(cm)"
        FROM player p
        JOIN team t
            ON t.TEAM_ID like p.Team_id
        WHERE
            t.team_ID LIKE(
                            SELECT team_id 
                            FROM team 
                            WHERE team_name like '삼성블루윙즈')
                                AND NOT p.height IS NULL        
    ORDER BY p.height DESC) a) b
WHERE 
    b.NO BETWEEN 10 AND 20
;




SELECT (select team_name from team where team_id = T.team_id) 팀이름, round(avg(p.weight),1) "몸무게" 
FROM team t
  JOIN player p
    ON p.team_id like t.team_id
WHERE p.position like 'GK'
GROUP BY t.team_id
ORDER BY avg(p.weight) DESC
;

-- 026
-- 팀별 골키퍼의 평균 키에서
-- 가장 평균키가 큰 팀명은

SELECT ROWNUM NO,a.*
FROM (SELECT (select team_name from team where team_id = T.team_id) 팀이름, round(avg(p.height),1) 키
        FROM team t
            JOIN player p
                ON p.team_id like t.team_id
        WHERE p.position like 'GK'
        GROUP BY t.team_id
        ORDER BY avg(p.height) DESC) a
WHERE ROWNUM <=1
;





-- 027
-- 각 구단별 선수들 평균키가 삼성 블루윙즈팀의
-- 평균키보다 작은 팀의 이름과 해당 팀의 평균키를 
-- 구하시오

SELECT 
    (select team_name from team where team_id = T.team_id) 팀이름,
    round(avg(p.height),1) 키
FROM team t
    JOIN player p
        ON p.team_id like t.team_id
GROUP BY t.team_id
    Having avg(p.height)<((select avg(p.height) 삼성키
        FROM team t
            JOIN player p
                ON p.team_id like t.team_id
        WHERE p.team_id like (select team_id from team where team_name ='삼성블루윙즈')
        GROUP BY t.team_id))
ORDER BY avg(p.height) DESC;

--
--
--(select round(avg(p.height),1) 삼성키
--        FROM team t
--        JOIN player p
--        ON p.team_id like t.team_id
--WHERE p.team_id like (select team_id from team where team_name ='삼성블루윙즈')
--GROUP BY t.team_id
--ORDER BY avg(p.height) DESC)




-- 028
-- 2012년 경기 중에서 점수차가 가장 큰 경기 전부


SELECT ROWNUM NO,a.*
FROM (
        SELECT sc.sche_date 날짜 , ABS(sc.HOME_SCORE-sc.AWAY_SCORe) "점수차", (select team_name from team a where a.team_id like sc.hometeam_id) "홈팀", (select team_name from team a where a.team_id like sc.awayteam_id) "어웨이팀"
        FROM schedule sc
            JOIN team ht
                ON ht.team_id = sc.hometeam_id
            JOIN team at
                ON at.team_id = sc.awayteam_id
        WHERE sc.HOME_SCORE IS NOT NULL
        ORDER BY ABS(sc.HOME_SCORE-sc.AWAY_SCOre) desc) a
where ROWNUM<=1;


--SELECT sc.sche_date 날짜 , ABS(sc.HOME_SCORE-sc.AWAY_SCORe) "점수차", (select team_name from team a where a.team_id like sc.hometeam_id) "홈팀", (select team_name from team a where a.team_id like sc.awayteam_id) "어웨이팀"
--FROM schedule sc
--    JOIN team ht
--        ON ht.team_id = sc.hometeam_id
--    JOIN team at
--        ON at.team_id = sc.awayteam_id
--WHERE sc.HOME_SCORE IS NOT NULL
--ORDER BY ABS(sc.HOME_SCORE-sc.AWAY_SCOre) desc
;


-- 029
-- 좌석수대로 스타디움 순서 매기기

SELECT ROWNUM NO,a.*
from  (select team_name AS"팀명", seat_count "좌석수"
        from stadium st
        join team t
            on t.stadium_id = st.stadium_id
        order by seat_count desc) a
;



--
--
--(select team_name AS"팀명", seat_count "좌석수"
--from stadium st
--    join team t
--        on t.stadium_id = st.stadium_id
--order by seat_count desc)



-- 030
-- 2012년 구단 승리 순으로 순위매기기
--

SeLeCt rOwNum no, (select team_name from team where t.team_id like team_id),count(승리) 승리횟수
fRom(
    SELECT sc.sche_date 날짜, case when sc.HOME_SCORE-sc.AWAY_SCORE>0 then ht.team_id when sc.Away_score-sc.Home_Score >0 then at.team_id end 승리
    fRoM sCHEDULE sc
        jOiN teAm ht
            ON ht.TEAM_ID like sc.homeTEAM_id
        jOiN teAm at
            ON at.TEAM_ID like sc.awayTEAM_id
     WHERE sc.sche_date like '2012%') a
GROUP BY a.승리
ORDER BY count(승리) DESC
;

