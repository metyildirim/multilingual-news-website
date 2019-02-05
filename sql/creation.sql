IF DB_ID('dbNews') IS NOT NULL
	BEGIN
		ALTER DATABASE [dbNews] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
		USE master
		DROP DATABASE dbNews
	END
GO

CREATE DATABASE dbNews
ON PRIMARY(
		NAME = 'dbNews',
		FILENAME = 'c:\database\dbNews.mdf',
		SIZE = 50MB,
		MAXSIZE	= 1024MB,
		FILEGROWTH = 20MB
)
LOG ON(
		NAME = 'dbNews_log',
		FILENAME = 'c:\database\dbNews_log.ldf',
		SIZE = 15MB,
		MAXSIZE = 100MB,
		FILEGROWTH = 5MB
)
GO

USE dbNews

------------------------------------------

CREATE TABLE tblAdmin
(
	id INT PRIMARY KEY NOT NULL,
	usrname VARCHAR(30),
	pwd VARCHAR(30)
)

CREATE TABLE tblLang
(
	lid INT PRIMARY KEY NOT NULL,
	lname VARCHAR(15) --English Turkish French
)

CREATE TABLE tblUser
(
	usrid INT PRIMARY KEY NOT NULL,
	usrname VARCHAR(30) UNIQUE,
	pwd VARCHAR(30),
	email VARCHAR(30),
	membershipDate DATETIME DEFAULT GETDATE() NOT NULL,
	isBlocked INT, -- 0-active, 1-blocked
)

CREATE TABLE tblCfg
(
	cid INT PRIMARY KEY NOT NULL,
	usrid INT FOREIGN KEY REFERENCES tblUser(usrid)
)

CREATE TABLE tblEditor
(
	eid INT PRIMARY KEY NOT NULL,
	--
	usrid INT FOREIGN KEY REFERENCES tblUser(usrid) NOT NULL,
)

CREATE TABLE tblCat
(
	cid INT PRIMARY KEY NOT NULL,
	cname VARCHAR(13) UNIQUE
)

CREATE TABLE tblSource
(
	srcid INT PRIMARY KEY NOT NULL,
	sname VARCHAR(30) UNIQUE NOT NULL
)

CREATE TABLE tblNews
(
	nid INT PRIMARY KEY NOT NULL,
	headln VARCHAR (70),
	descr VARCHAR(500),
	contxt VARCHAR (8000),
	imgUrl VARCHAR(250),
	tm DATETIME DEFAULT GETDATE() NOT NULL,
	--
	srcid INT FOREIGN KEY REFERENCES tblSource(srcid) NOT NULL
)

CREATE TABLE tblTranslation
(
	tid INT PRIMARY KEY NOT NULL,
	tHeadln VARCHAR(70),
	tDescr VARCHAR(500),
	tContxt VARCHAR(8000),
	--
	nid INT FOREIGN KEY REFERENCES tblNews(nid) NOT NULL,
	lid INT FOREIGN KEY REFERENCES tblLang(lid) NOT NULL
)

CREATE TABLE tblComment
(
	cid INT PRIMARY KEY NOT NULL,
	txt VARCHAR(400),
	tm DATETIME DEFAULT GETDATE() NOT NULL,
	--
	usrid INT FOREIGN KEY REFERENCES tblUser(usrid) NOT NULL,
	nid INT FOREIGN KEY REFERENCES tblNews(nid) NOT NULL
)

------------------------------------------------------------

CREATE TABLE tblCatCfg -- config category
(
	PRIMARY KEY (caid,cfid),
	caid INT FOREIGN KEY REFERENCES tblCat(cid) NOT NULL,
	cfid INT FOREIGN KEY REFERENCES tblCfg(cid) NOT NULL,
)

CREATE TABLE tblLangCfg(
	PRIMARY KEY(lid,cfid),
	lid INT FOREIGN KEY REFERENCES tblLang(lid) NOT NULL,
	cfid INT FOREIGN KEY REFERENCES tblCfg(cid) NOT NULL
)

CREATE TABLE tblCatNews
(
	PRIMARY KEY (cid,nid),
	cid INT FOREIGN KEY REFERENCES tblCat(cid) NOT NULL,
	nid INT FOREIGN KEY REFERENCES tblNews(nid) NOT NULL,
)

CREATE TABLE tblLangNews
(
	PRIMARY KEY (lid,nid),
	lid INT FOREIGN KEY REFERENCES tblLang(lid) NOT NULL,
	nid INT FOREIGN KEY REFERENCES tblNews(nid) NOT NULL,
)

CREATE TABLE tblEdtNews
(
	PRIMARY KEY (eid,nid),
	etdHeadln VARCHAR (70),
	etdDescr VARCHAR(500),
	etdContxt VARCHAR (8000),
	etdImgUrl VARCHAR(250),
	etdTm DATETIME DEFAULT GETDATE() NOT NULL,
	--
	eid INT FOREIGN KEY REFERENCES tblEditor(eid) NOT NULL,
	nid INT FOREIGN KEY REFERENCES tblNews(nid) NOT NULL
)

-----------------------EXTRA-------------------------
use dbNews
CREATE TABLE tblMessages
(
	mid INT PRIMARY KEY NOT NULL,
	msg VARCHAR(500),
	usrid INT FOREIGN KEY REFERENCES tblUser(usrid) NOT NULL	
)

CREATE TABLE tblEditorshipRequests
(
	rid INT PRIMARY KEY NOT NULL,
	usrid INT FOREIGN KEY REFERENCES tblUser(usrid) NOT NULL
)

CREATE TABLE tblOtherMessages
(
	mid INT PRIMARY KEY NOT NULL,
	msg VARCHAR(500),
	nm VARCHAR(15),
	srname VARCHAR(15),
	email VARCHAR(30)
)

------------------PROCEDURES-VIEWS----------------------------

CREATE VIEW VUsrMessages AS
	SELECT
		U.usrname,
		M.msg
		FROM tblUser U
	INNER JOIN tblMessages M ON U.usrid = M.usrid
GO

CREATE VIEW VEditors AS
	SELECT
		U.usrname
		FROM tblUser U
		INNER JOIN tblEditor E ON U.usrid = E.usrid
	GO

CREATE VIEW VEditorRequests AS
	SELECT
		U.usrname
		FROM tblUser U
		INNER JOIN tblEditorshipRequests ER ON ER.usrid = U.usrid
	GO

CREATE FUNCTION getUid(@username VARCHAR(30))
RETURNS INT
AS
	BEGIN
		RETURN 
		(
			SELECT usrid FROM tblUser WHERE @username = usrname
		)
	END
GO

CREATE PROCEDURE spAddEditor @username VARCHAR(30)
AS 
	BEGIN
		DECLARE @usrid INT
		SET @usrid = dbo.getUid(@username)
		IF @usrid = NULL
			BEGIN
				print('error')
			END
		ELSE
			BEGIN
				DECLARE @usrid2 INT
				SELECT @usrid2 = usrid from tblEditor where @usrid = usrid
				IF @usrid2 = @usrid
					BEGIN
						print('error2')
					END
				ELSE
					BEGIN
						DECLARE @eid int
						SELECT @eid = MAX(eid) from tblEditor
						SET @eid += 1
						INSERT INTO tblEditor VALUES(@eid, @usrid)
						DELETE FROM tblEditorshipRequests WHERE usrid = @usrid
					END
			END
END

CREATE PROCEDURE spRemoveEditor @username VARCHAR(30)
AS
	BEGIN
		DECLARE @usrid INT
		SET @usrid = dbo.getUid(@username)
		DELETE FROM tblEditor WHERE @usrid = usrid
	END
GO

CREATE PROCEDURE spSelectUser @username VARCHAR(30)
AS
	BEGIN
		SELECT usrname FROM tblUser WHERE usrname LIKE ('%'+@username+'%')
	END
GO

CREATE PROCEDURE spInsertOtherMessage @msg VARCHAR(500), @nm VARCHAR(15), @srname VARCHAR(15), @email VARCHAR(30)
AS
	BEGIN
		DECLARE @mid INT
		SELECT @mid = MAX(mid) FROM tblOtherMEssages
		SET @mid += 1
		INSERT INTO tblOtherMessages VALUES (@mid,@msg,@nm,@srname,@email)
	END
GO

CREATE PROCEDURE spInsertMessage @msg VARCHAR(500), @id INT
AS
	BEGIN
		DECLARE @mid INT
		SELECT @mid = MAX(mid) FROM tblMEssages
		SET @mid += 1
		INSERT INTO tblMessages VALUES (@mid,@msg,@id)
	END
GO

CREATE PROCEDURE spInsertUser @usrname VARCHAR(30), @pwd VARCHAR(30), @email VARCHAR(30)
AS
	BEGIN
		DECLARE @usrid INT
		SELECT @usrid = MAX(usrid) FROM tblUser
		SET @usrid += 1
		INSERT INTO tblUser VALUES(@usrid,@usrname,@pwd,@email,GETDATE(),0)
		DECLARE @cid INT
		SELECT @cid = MAX(cid) FROM tblCfg
		SET @cid += 1
		INSERT INTO tblCfg VALUES(@cid,@usrid)
		INSERT INTO tblCatCfg VALUES(1,@cid),(2,@cid),(3,@cid),(4,@cid),(5,@cid),(6,@cid),(7,@cid)
		INSERT INTO tblLangCfg VALUES(1,@cid),(2,@cid),(3,@cid)
	END
GO

CREATE PROCEDURE spInsertNews @headln VARCHAR(70),@descr VARCHAR(500),@contxt VARCHAR(8000), @url VARCHAR(250), @srcid INT, @langid INT, @catid INT
AS
	BEGIN
		DECLARE @nid INT
		SELECT @nid = MAX(nid) FROM tblNews
		SET @nid += 1
		INSERT INTO tblNews VALUES(@nid,@headln,@descr,@contxt,@url,GETDATE(),@srcid)
		INSERT INTO tblLangNews VALUES(@langid,@nid)
		INSERT INTO tblCatNews VALUES(@catid,@nid)
	END
GO

CREATE PROCEDURE spViewNewsByCat @catName VARCHAR(13)
AS
	BEGIN
		SELECT * FROM tblNews N
		INNER JOIN tblCat C ON C.cname = @catName
		INNER JOIN tblCatNews CC ON CC.nid = N.nid AND CC.cid = C.cid
		ORDER BY tm DESC
		OFFSET 0 ROWS
		FETCH NEXT 20 ROWS ONLY
	END
GO

CREATE PROCEDURE spViewNewsSlider @langName VARCHAR(15)
AS
	BEGIN
		SELECT * FROM tblNews N
		INNER JOIN tblLang L ON L.lname = @langName
		INNER JOIN tblLangNews LN ON LN.nid = N.nid AND LN.lid = L.lid
		ORDER BY tm DESC
		OFFSET 0 ROWS
		FETCH NEXT 15 ROWS ONLY
	END
GO

CREATE PROCEDURE spViewNewsCatLangBeginAmount @catName VARCHAR(13), @LangsStr VARCHAR(30), @begin INT, @amount INT
AS
	BEGIN
		IF @LangsStr LIKE '%English%' AND @LangsStr LIKE '%Turkish%' AND @LangsStr LIKE '%French%'
		BEGIN
			SELECT DISTINCT * FROM tblNews N
			INNER JOIN tblCatNews CN ON CN.nid = N.nid
			INNER JOIN tblCat C On C.cid = CN.cid AND C.cname = @catName
			ORDER BY tm DESC
			OFFSET @begin ROWS
			FETCH NEXT @amount ROWS ONLY
		END
		ELSE IF @LangsStr LIKE '%English%' AND @LangsStr LIKE '%Turkish%'
		BEGIN
			SELECT DISTINCT * FROM tblNews N
			INNER JOIN tblCatNews CN ON CN.nid = N.nid
			INNER JOIN tblCat C On C.cid = CN.cid AND C.cname = @catName
			INNER JOIN tblLangNews LN ON LN.nid = n.nid
			INNER JOIN tblLang L ON L.lid = LN.lid AND (L.lname = 'English' OR L.lname = 'Turkish')
			ORDER BY tm DESC
			OFFSET @begin ROWS
			FETCH NEXT @amount ROWS ONLY
		END
		ELSE IF @LangsStr LIKE '%English%' AND @LangsStr LIKE '%French%'
		BEGIN
			SELECT DISTINCT * FROM tblNews N
			INNER JOIN tblCatNews CN ON CN.nid = N.nid
			INNER JOIN tblCat C On C.cid = CN.cid AND C.cname = @catName
			INNER JOIN tblLangNews LN ON LN.nid = n.nid
			INNER JOIN tblLang L ON L.lid = LN.lid AND (L.lname = 'English' OR L.lname = 'French')
			ORDER BY tm DESC
			OFFSET @begin ROWS
			FETCH NEXT @amount ROWS ONLY
		END
		ELSE IF @LangsStr LIKE '%Turkish%' AND @LangsStr LIKE '%French%'
		BEGIN
			SELECT DISTINCT * FROM tblNews N
			INNER JOIN tblCatNews CN ON CN.nid = N.nid
			INNER JOIN tblCat C On C.cid = CN.cid AND C.cname = @catName
			INNER JOIN tblLangNews LN ON LN.nid = n.nid
			INNER JOIN tblLang L ON L.lid = LN.lid AND (L.lname = 'Turkish' OR L.lname = 'French')
			ORDER BY tm DESC
			OFFSET @begin ROWS
			FETCH NEXT @amount ROWS ONLY
		END
		ELSE IF @LangsStr LIKE '%English%'
		BEGIN
			SELECT DISTINCT * FROM tblNews N
			INNER JOIN tblCatNews CN ON CN.nid = N.nid
			INNER JOIN tblCat C On C.cid = CN.cid AND C.cname = @catName
			INNER JOIN tblLangNews LN ON LN.nid = n.nid
			INNER JOIN tblLang L ON L.lid = LN.lid AND L.lname = 'English'
			ORDER BY tm DESC
			OFFSET @begin ROWS
			FETCH NEXT @amount ROWS ONLY
		END
		ELSE IF @LangsStr LIKE '%Turkish%'
		BEGIN
			SELECT DISTINCT * FROM tblNews N
			INNER JOIN tblCatNews CN ON CN.nid = N.nid
			INNER JOIN tblCat C On C.cid = CN.cid AND C.cname = @catName
			INNER JOIN tblLangNews LN ON LN.nid = n.nid
			INNER JOIN tblLang L ON L.lid = LN.lid AND L.lname = 'Turkish'
			ORDER BY tm DESC
			OFFSET @begin ROWS
			FETCH NEXT @amount ROWS ONLY
		END
		ELSE IF @LangsStr LIKE '%French%'
		BEGIN
			SELECT DISTINCT * FROM tblNews N
			INNER JOIN tblCatNews CN ON CN.nid = N.nid
			INNER JOIN tblCat C On C.cid = CN.cid AND C.cname = @catName
			INNER JOIN tblLangNews LN ON LN.nid = n.nid
			INNER JOIN tblLang L ON L.lid = LN.lid AND L.lname = 'French'
			ORDER BY tm DESC
			OFFSET @begin ROWS
			FETCH NEXT @amount ROWS ONLY
		END
	END
GO

CREATE PROCEDURE spReadNews @nid INT
AS
	BEGIN
		SELECT headln, descr, contxt, imgUrl, tm, sname FROM tblNews N
		INNER JOIN tblSource S ON S.srcid = N.srcid AND N.nid = @nid
	END
GO

CREATE PROCEDURE spSelectComments @nid INT
AS
	BEGIN
		SELECT usrname, txt, tm FROM tblComment C
		INNER JOIN tblUser U ON U.usrid = C.usrid AND @nid = C.nid 
		ORDER BY tm DESC
	END
GO

CREATE PROCEDURE spMakeComment @usrid INT, @nid INT, @txt VARCHAR(400)
AS
	BEGIN
		DECLARE @cid INT
		SELECT @cid = MAX(cid) FROM tblComment
		SET @cid += 1
		INSERT INTO tblComment VALUES(@cid, @txt, GETDATE(), @usrid, @nid)
	END
GO