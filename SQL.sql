SELECT * FROM SHOHIN ORDER BY SHOHIN_ID;

UPDATE shohin 
SET hanbai_tanka = hanbai_tanka / 10,
    shiire_tanka = shiire_tanka * 2
WHERE shohin_bunrui = '�L�b�`���p�i';

UPDATE Shohin
SET hanbai_tanka = hanbai_tanka - 1000
WHERE shohin_mei = '�t�H�[�N';

UPDATE Shohin
SET hanbai_tanka = hanbai_tanka + 1000
WHERE shohin_mei = 'T�V���c';

ROLLBACK;

CREATE TABLE ShohinSaeki
(shohin_id CHAR(4) NOT NULL,
shohin_mei VARCHAR(100) NOT NULL,
hanbai_tanka INTEGER,
shiire_tanka INTEGER,
saeki INTEGER,
PRIMARY KEY(shohin_id));

INSERT INTO ShohinSaeki (shohin_id, shohin_mei, hanbai_tanka, shiire_tanka, saeki)
SELECT shohin_id, shohin_mei, hanbai_tanka, shiire_tanka, hanbai_tanka - shiire_tanka
FROM Shohin;

INSERT INTO ShohinSaeki VALUES ('0003', '�J�b�^�[�V���c', 4000, 2800, 1200);

SELECT * FROM SHOHINSAEKI;

UPDATE shohinsaeki
SET hanbai_tanka = 3000
WHERE shohin_mei = '�J�b�^�[�V���c';

UPDATE shohinsaeki
SET saeki = hanbai_tanka - shiire_tanka;

DELETE FROM Shohin;

INSERT INTO Shohin VALUES ('0001', 'T�V���c' ,'�ߕ�', 1000, 500, '2009-09-20');
INSERT INTO Shohin VALUES ('0002', '�������p���`', '�����p�i', 500, 320, '2009-09-11');
INSERT INTO Shohin VALUES ('0003', '�J�b�^�[�V���c', '�ߕ�', 4000, 2800, NULL);
INSERT INTO Shohin VALUES ('0004', '�', '�L�b�`���p�i', 3000, 2800, '2009-09-20');
INSERT INTO Shohin VALUES ('0005', '���͓�', '�L�b�`���p�i', 6800, 5000, '2009-01-15');
INSERT INTO Shohin VALUES ('0006', '�t�H�[�N', '�L�b�`���p�i', 500, NULL, '2009-09-20');
INSERT INTO Shohin VALUES ('0007', '���낵����', '�L�b�`���p�i', 880, 790, '2008-04-28');
INSERT INTO Shohin VALUES ('0008', '�{�[���y��', '�����p�i', 100, NULL, '2009-11-11');

COMMIT;

SELECT * FROM Shohin;

CREATE VIEW ShohinSum (shohin_bunrui, cnt_shohin)
AS
SELECT shohin_bunrui, COUNT(*)
FROM Shohin
GROUP BY shohin_bunrui;

SELECT shohin_bunrui, cnt_shohin
FROM ShohinSum;

CREATE VIEW ShohinSumJim (shohin_bunrui, cnt_shohin)
AS
SELECT shohin_bunrui, cnt_shohin
FROM ShohinSum
WHERE shohin_bunrui = '�����p�i';

DROP VIEW ShohinSumJim;

SELECT shohin_bunrui, cnt_shohin
FROM ShohinSumJim;

CREATE VIEW ShohinJim (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi)
AS
SELECT * FROM Shohin
WHERE shohin_bunrui = '�����p�i';

INSERT INTO ShohinJim VALUES ('0009', '���', '�����p�i', 95, 10, '2009-11-30');

SELECT * FROM ShohinJim;

SELECT * FROM Shohin;

DELETE FROM Shohin WHERE Shohin_id = '0009';

SELECT shohin_bunrui, cnt_shohin
FROM ShohinSum;

SELECT shohin_bunrui, cnt_shohin
FROM (SELECT shohin_bunrui, COUNT(*) AS cnt_shohin
FROM Shohin
GROUP BY shohin_bunrui);

SELECT shohin_bunrui, cnt_shohin
FROM (SELECT * 
FROM(SELECT shohin_bunrui, COUNT(*) AS cnt_shohin
FROM Shohin
GROUP BY shohin_bunrui) ShohinSum
WHERE cnt_shohin = 4) ShohinSum2;

SELECT AVG(hanbai_tanka)
FROM Shohin;

SELECT shohin_id, shohin_mei, hanbai_tanka
FROM shohin
WHERE hanbai_tanka >= (SELECT AVG(hanbai_tanka)
FROM Shohin);

SELECT shohin_id,
shohin_mei,
hanbai_tanka,
(SELECT AVG(hanbai_tanka)
    FROM Shohin) AS avg_tanka
FROM Shohin;

SELECT shohin_bunrui, AVG(hanbai_tanka)
FROM shohin
GROUP BY shohin_bunrui
HAVING AVG(hanbai_tanka) > (SELECT AVG(hanbai_tanka) FROM Shohin);