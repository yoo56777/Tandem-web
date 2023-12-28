USE testmall;

DROP TABLE IF EXISTS dbo.orderlists;
DROP TABLE IF EXISTS dbo.userorders;
DROP TABLE IF EXISTS dbo.carts;
DROP TABLE IF EXISTS dbo.userinfo;
DROP TABLE IF EXISTS dbo.commodities;
DROP TABLE IF EXISTS dbo.commodity_tags;

CREATE TABLE dbo.commodity_tags (						/*�ӫ~������*/
	CommoditySubTag VARCHAR(20) NOT NULL PRIMARY KEY,	/*�p��*/
	CommodityMainTag VARCHAR(20) NOT NULL				/*�j��*/
);

CREATE INDEX IX_main_tags ON commodity_tags(CommodityMainTag);

CREATE TABLE dbo.commodities (					/*�ӫ~��*/
	CommodityID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,	/*�ӫ~�s��*/
	CommodityName VARCHAR(30) NULL,				/*�ӫ~�W��*/
	CommodityQty INT NULL,						/*�w�s�ƶq*/
	CommodityPrice INT NULL,					/*����*/
	CommodityTag VARCHAR(20) NULL,				/*�ӫ~����*/
	CommodityImgPath VARCHAR(200) NULL,			/*�Ϥ���}*/
	CommodityDetail VARCHAR(500) NULL,			/*�ӫ~�ԲӸ�T*/
	CommoditySaleFlag BIT NULL,					/*�O�_�P�⤤*/
	CommodityDiscount BIT NULL,					/*�O�_���馩*/
	CommodityDisRate BIT NULL,					/*�X��*/
	FOREIGN KEY (CommodityTag) REFERENCES commodity_tags(CommoditySubTag)
);

CREATE INDEX IX_commodities_tag ON commodities(CommodityTag);
CREATE INDEX IX_commodities_name ON commodities(CommodityName);
CREATE INDEX IX_commodities_sale ON commodities(CommoditySaleFlag);
CREATE INDEX IX_commodities_discount ON commodities(CommodityDiscount);

CREATE TABLE dbo.userinfo (							/*�ϥΪ̪�*/
	UserAccount VARCHAR(30) NOT NULL PRIMARY KEY,	/*�b��*/
	UserPassword VARCHAR(30) NULL,					/*�K�X*/
	UserName VARCHAR(20) NULL,						/*�m�W*/
	UserPhone VARCHAR(20) NULL,						/*�q��*/
	UserEmail VARCHAR(50) NULL,						/*email*/
	UserAddress VARCHAR(100) NULL,					/*�q�T�a�}*/
	UserMsg VARCHAR(200) NULL						/*�T��*/
);

CREATE TABLE dbo.carts (							/*�ʪ�����*/
	CartSeq INT IDENTITY(1,1) NOT NULL PRIMARY KEY,	/*�ʪ����y����*/
	CartAccount VARCHAR(30) NOT NULL,				/*�b��*/
	CartCommodityID BIGINT NOT NULL,				/*�ӫ~�s��*/
	CartQty INT NULL,								/*�ʶR�ƶq*/
	FOREIGN KEY (CartAccount) REFERENCES userinfo(UserAccount),
	FOREIGN KEY (CartCommodityID) REFERENCES commodities(CommodityID)
);

CREATE INDEX IX_carts_account ON carts(CartAccount);

CREATE TABLE dbo.userorders (						/*�q���*/
	OrderNo BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,/*�q��s��*/
	OrderAccount VARCHAR(30) NOT NULL,				/*�b��*/
	OrderDate DATETIME NULL,						/*���*/
	OrderTotal BIGINT NULL,                         /*�`���B*/
	FOREIGN KEY (OrderAccount) REFERENCES userinfo(UserAccount)
);

CREATE INDEX IX_orders_account ON userorders(OrderAccount);

CREATE TABLE dbo.orderlists (						/*�q��ӫ~��T*/
	OrderNo BIGINT NOT NULL,						/*�q��s��*/
	OrderCommodityID BIGINT NOT NULL,				/*�ӫ~�s��*/
	OrderQty INT NULL,								/*�ƶq*/	
	OrderPrice BIGINT NULL,							/*�`���B*/
	OrderReturn BIT NULL,							/*���ӫ~�O�_�h�f*/
	FOREIGN KEY (OrderCommodityID) REFERENCES commodities(CommodityID),
	FOREIGN KEY (OrderNo) REFERENCES userorders(OrderNo)
);

CREATE INDEX IX_orderlist_no ON orderlists(OrderNo);