USE testmall;

DROP TABLE IF EXISTS dbo.orderlists;
DROP TABLE IF EXISTS dbo.userorder;
DROP TABLE IF EXISTS dbo.carts;
DROP TABLE IF EXISTS dbo.userinfo;
DROP TABLE IF EXISTS dbo.commodities;
DROP TABLE IF EXISTS dbo.commodity_tags;

CREATE TABLE dbo.commodity_tags (						/*商品種類表*/
	CommoditySubTag VARCHAR(20) NOT NULL PRIMARY KEY,	/*小類*/
	CommodityMainTag VARCHAR(20) NOT NULL				/*大類*/
);

CREATE TABLE dbo.commodities (					/*商品表*/
	CommodityID BIGINT NOT NULL PRIMARY KEY,	/*商品編號*/
	CommodityName VARCHAR(30) NULL,				/*商品名稱*/
	CommodityQty INT NULL,						/*庫存數量*/
	CommodityPrice INT NULL,					/*價格*/
	CommodityTag VARCHAR(20) NULL,				/*商品分類*/
	CommodityImgPath VARCHAR(200) NULL,			/*圖片位址*/
	CommodityDetail VARCHAR(500) NULL,			/*商品詳細資訊*/
	CommoditySaleFlag tinyint NULL,             /*是否銷售中*/
	CommodityDiscount tinyint NULL,             /*是否有折扣*/
	CommodityDisRate tinyint NULL,              /*幾折*/
	FOREIGN KEY (CommodityTag) REFERENCES commodity_tags(CommoditySubTag)
);

CREATE TABLE dbo.userinfo (				/*使用者表*/
	UserAccount VARCHAR(30) NOT NULL PRIMARY KEY,	/*帳號*/
	UserPassword VARCHAR(30) NULL,		/*密碼*/
	UserName VARCHAR(20) NULL,			/*姓名*/
	UserPhone VARCHAR(20) NULL,			/*電話*/
	UserEmail VARCHAR(50) NULL,			/*email*/
	UserAddress VARCHAR(100) NULL,		/*通訊地址*/
	UserMsg VARCHAR(200) NULL           /*訊息*/
);

CREATE TABLE dbo.carts (				/*購物車表*/
	CartSeq INT NOT NULL PRIMARY KEY,   /*購物車流水號*/
	CartAccount VARCHAR(30) NOT NULL,	/*帳號*/
	CartCommodityID BIGINT NOT NULL,	/*商品編號*/
	CartQty INT NULL,					/*購買數量*/
	FOREIGN KEY (CartAccount) REFERENCES userinfo(UserAccount),
	FOREIGN KEY (CartCommodityID) REFERENCES commodities(CommodityID)
);

CREATE TABLE dbo.orderlists (					/*訂單商品資訊*/
	OrderNo VARCHAR(10) NOT NULL PRIMARY KEY,	/*訂單編號*/
	OrderCommodityID BIGINT NOT NULL,			/*商品編號*/
	OrderQty INT NULL,							/*數量*/
	OrderDate DATETIME NULL,					/*日期*/
	OrderPrice BIGINT NULL,						/*總金額*/
	FOREIGN KEY (OrderCommodityID) REFERENCES commodities(CommodityID)
);

CREATE TABLE dbo.userorder (				/*訂單表*/
	OrderSeq BIGINT NOT NULL PRIMARY KEY,	/*流水號*/
	OrderAccount VARCHAR(30) NOT NULL,		/*帳號*/
	OrderNo VARCHAR(10) NULL				/*訂單編號*/
	FOREIGN KEY (OrderAccount) REFERENCES userinfo(UserAccount),
	FOREIGN KEY (OrderNo) REFERENCES orderLists(OrderNo)
);



--INSERT INTO COMMODITY (COM_ID, COM_NAME, COM_COUNT, COM_PRICE, COM_TAG, COM_IMG_PATH, COM_DETAIL)
--VALUES (1, '蘋果', 50, 25, '水果', 'images/apple.jpg', '蘋果 Detail...');

--INSERT INTO COMMODITY (COM_ID, COM_NAME, COM_COUNT, COM_PRICE, COM_TAG, COM_IMG_PATH, COM_DETAIL)
--VALUES (2, '西瓜', 100, 70, '水果', 'images/watermelon.png', '西瓜 Detail...');

--INSERT INTO COMMODITY (COM_ID, COM_NAME, COM_COUNT, COM_PRICE, COM_TAG, COM_IMG_PATH, COM_DETAIL)
--VALUES (3, '筆電', 10, 32400, '電器', 'images/notebook.jpg', '筆電 Detail...');