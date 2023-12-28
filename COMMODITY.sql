USE testmall;

DROP TABLE IF EXISTS dbo.orderlists;
DROP TABLE IF EXISTS dbo.userorders;
DROP TABLE IF EXISTS dbo.carts;
DROP TABLE IF EXISTS dbo.userinfo;
DROP TABLE IF EXISTS dbo.commodities;
DROP TABLE IF EXISTS dbo.commodity_tags;

CREATE TABLE dbo.commodity_tags (						/*商品種類表*/
	CommoditySubTag VARCHAR(20) NOT NULL PRIMARY KEY,	/*小類*/
	CommodityMainTag VARCHAR(20) NOT NULL				/*大類*/
);

CREATE INDEX IX_main_tags ON commodity_tags(CommodityMainTag);

CREATE TABLE dbo.commodities (					/*商品表*/
	CommodityID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,	/*商品編號*/
	CommodityName VARCHAR(30) NULL,				/*商品名稱*/
	CommodityQty INT NULL,						/*庫存數量*/
	CommodityPrice INT NULL,					/*價格*/
	CommodityTag VARCHAR(20) NULL,				/*商品分類*/
	CommodityImgPath VARCHAR(200) NULL,			/*圖片位址*/
	CommodityDetail VARCHAR(500) NULL,			/*商品詳細資訊*/
	CommoditySaleFlag BIT NULL,					/*是否銷售中*/
	CommodityDiscount BIT NULL,					/*是否有折扣*/
	CommodityDisRate BIT NULL,					/*幾折*/
	FOREIGN KEY (CommodityTag) REFERENCES commodity_tags(CommoditySubTag)
);

CREATE INDEX IX_commodities_tag ON commodities(CommodityTag);
CREATE INDEX IX_commodities_name ON commodities(CommodityName);
CREATE INDEX IX_commodities_sale ON commodities(CommoditySaleFlag);
CREATE INDEX IX_commodities_discount ON commodities(CommodityDiscount);

CREATE TABLE dbo.userinfo (							/*使用者表*/
	UserAccount VARCHAR(30) NOT NULL PRIMARY KEY,	/*帳號*/
	UserPassword VARCHAR(30) NULL,					/*密碼*/
	UserName VARCHAR(20) NULL,						/*姓名*/
	UserPhone VARCHAR(20) NULL,						/*電話*/
	UserEmail VARCHAR(50) NULL,						/*email*/
	UserAddress VARCHAR(100) NULL,					/*通訊地址*/
	UserMsg VARCHAR(200) NULL						/*訊息*/
);

CREATE TABLE dbo.carts (							/*購物車表*/
	CartSeq INT IDENTITY(1,1) NOT NULL PRIMARY KEY,	/*購物車流水號*/
	CartAccount VARCHAR(30) NOT NULL,				/*帳號*/
	CartCommodityID BIGINT NOT NULL,				/*商品編號*/
	CartQty INT NULL,								/*購買數量*/
	FOREIGN KEY (CartAccount) REFERENCES userinfo(UserAccount),
	FOREIGN KEY (CartCommodityID) REFERENCES commodities(CommodityID)
);

CREATE INDEX IX_carts_account ON carts(CartAccount);

CREATE TABLE dbo.userorders (						/*訂單表*/
	OrderNo BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,/*訂單編號*/
	OrderAccount VARCHAR(30) NOT NULL,				/*帳號*/
	OrderDate DATETIME NULL,						/*日期*/
	OrderTotal BIGINT NULL,                         /*總金額*/
	FOREIGN KEY (OrderAccount) REFERENCES userinfo(UserAccount)
);

CREATE INDEX IX_orders_account ON userorders(OrderAccount);

CREATE TABLE dbo.orderlists (						/*訂單商品資訊*/
	OrderNo BIGINT NOT NULL,						/*訂單編號*/
	OrderCommodityID BIGINT NOT NULL,				/*商品編號*/
	OrderQty INT NULL,								/*數量*/	
	OrderPrice BIGINT NULL,							/*總金額*/
	OrderReturn BIT NULL,							/*此商品是否退貨*/
	FOREIGN KEY (OrderCommodityID) REFERENCES commodities(CommodityID),
	FOREIGN KEY (OrderNo) REFERENCES userorders(OrderNo)
);

CREATE INDEX IX_orderlist_no ON orderlists(OrderNo);