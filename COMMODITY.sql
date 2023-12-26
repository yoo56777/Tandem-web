USE testmall;

DROP TABLE IF EXISTS dbo.orderlists;
DROP TABLE IF EXISTS dbo.userorder;
DROP TABLE IF EXISTS dbo.carts;
DROP TABLE IF EXISTS dbo.userinfo;
DROP TABLE IF EXISTS dbo.commodities;
DROP TABLE IF EXISTS dbo.commodity_tags;

CREATE TABLE dbo.commodity_tags (						/*�ӫ~������*/
	CommoditySubTag VARCHAR(20) NOT NULL PRIMARY KEY,	/*�p��*/
	CommodityMainTag VARCHAR(20) NOT NULL				/*�j��*/
);

CREATE TABLE dbo.commodities (					/*�ӫ~��*/
	CommodityID BIGINT NOT NULL PRIMARY KEY,	/*�ӫ~�s��*/
	CommodityName VARCHAR(30) NULL,				/*�ӫ~�W��*/
	CommodityQty INT NULL,						/*�w�s�ƶq*/
	CommodityPrice INT NULL,					/*����*/
	CommodityTag VARCHAR(20) NULL,				/*�ӫ~����*/
	CommodityImgPath VARCHAR(200) NULL,			/*�Ϥ���}*/
	CommodityDetail VARCHAR(500) NULL,			/*�ӫ~�ԲӸ�T*/
	CommoditySaleFlag tinyint NULL,             /*�O�_�P�⤤*/
	CommodityDiscount tinyint NULL,             /*�O�_���馩*/
	CommodityDisRate tinyint NULL,              /*�X��*/
	FOREIGN KEY (CommodityTag) REFERENCES commodity_tags(CommoditySubTag)
);

CREATE TABLE dbo.userinfo (				/*�ϥΪ̪�*/
	UserAccount VARCHAR(30) NOT NULL PRIMARY KEY,	/*�b��*/
	UserPassword VARCHAR(30) NULL,		/*�K�X*/
	UserName VARCHAR(20) NULL,			/*�m�W*/
	UserPhone VARCHAR(20) NULL,			/*�q��*/
	UserEmail VARCHAR(50) NULL,			/*email*/
	UserAddress VARCHAR(100) NULL,		/*�q�T�a�}*/
	UserMsg VARCHAR(200) NULL           /*�T��*/
);

CREATE TABLE dbo.carts (				/*�ʪ�����*/
	CartSeq INT NOT NULL PRIMARY KEY,   /*�ʪ����y����*/
	CartAccount VARCHAR(30) NOT NULL,	/*�b��*/
	CartCommodityID BIGINT NOT NULL,	/*�ӫ~�s��*/
	CartQty INT NULL,					/*�ʶR�ƶq*/
	FOREIGN KEY (CartAccount) REFERENCES userinfo(UserAccount),
	FOREIGN KEY (CartCommodityID) REFERENCES commodities(CommodityID)
);

CREATE TABLE dbo.orderlists (					/*�q��ӫ~��T*/
	OrderNo VARCHAR(10) NOT NULL PRIMARY KEY,	/*�q��s��*/
	OrderCommodityID BIGINT NOT NULL,			/*�ӫ~�s��*/
	OrderQty INT NULL,							/*�ƶq*/
	OrderDate DATETIME NULL,					/*���*/
	OrderPrice BIGINT NULL,						/*�`���B*/
	FOREIGN KEY (OrderCommodityID) REFERENCES commodities(CommodityID)
);

CREATE TABLE dbo.userorder (				/*�q���*/
	OrderSeq BIGINT NOT NULL PRIMARY KEY,	/*�y����*/
	OrderAccount VARCHAR(30) NOT NULL,		/*�b��*/
	OrderNo VARCHAR(10) NULL				/*�q��s��*/
	FOREIGN KEY (OrderAccount) REFERENCES userinfo(UserAccount),
	FOREIGN KEY (OrderNo) REFERENCES orderLists(OrderNo)
);



--INSERT INTO COMMODITY (COM_ID, COM_NAME, COM_COUNT, COM_PRICE, COM_TAG, COM_IMG_PATH, COM_DETAIL)
--VALUES (1, 'ī�G', 50, 25, '���G', 'images/apple.jpg', 'ī�G Detail...');

--INSERT INTO COMMODITY (COM_ID, COM_NAME, COM_COUNT, COM_PRICE, COM_TAG, COM_IMG_PATH, COM_DETAIL)
--VALUES (2, '���', 100, 70, '���G', 'images/watermelon.png', '��� Detail...');

--INSERT INTO COMMODITY (COM_ID, COM_NAME, COM_COUNT, COM_PRICE, COM_TAG, COM_IMG_PATH, COM_DETAIL)
--VALUES (3, '���q', 10, 32400, '�q��', 'images/notebook.jpg', '���q Detail...');