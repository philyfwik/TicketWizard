DROP TABLE CreditCard;
DROP TABLE EventDiscussion;
DROP TABLE Photo;
DROP TABLE Cart;
DROP TABLE OrderInfo;
DROP TABLE Ticket;
DROP TABLE EventSection;
DROP TABLE Event;
DROP TABLE TUser;


CREATE TABLE TUser (
    uid int NOT NULL IDENTITY PRIMARY KEY, 
    username VARCHAR(20) NOT NULL,
    upw VARCHAR(20) NOT NULL,
    firstname VARCHAR(20) NOT NULL,
    lastname VARCHAR(20) NOT NULL,
    address VARCHAR(100),
    email VARCHAR(50) NOT NULL,
    phone CHAR(15),
    isadmin BIT
);


CREATE TABLE Event (
    enum int NOT NULL IDENTITY PRIMARY KEY,
    ename VARCHAR(100),
    etime DATETIME,
    description VARCHAR(200),
    city VARCHAR(50),
    location VARCHAR(100),
    maxcapacity int,
    hostid int,
    ticketPrice DECIMAL(9,2),
    category VARCHAR(20),
    currcapacity int,
    CONSTRAINT FK_Event_TUser FOREIGN KEY (hostid) REFERENCES TUser(uid)
);


CREATE TABLE Ticket (
    tnum CHAR(50) NOT NULL,
    uid int,
    enum int,
    tier int,
    seatnum int,
    etime DATETIME,
    PRIMARY KEY (tnum),
    CONSTRAINT FK_Ticket_Event FOREIGN KEY (enum) REFERENCES Event(enum),
    CONSTRAINT FK_Ticket_TUser FOREIGN KEY (uid) REFERENCES TUser(uid)
);


CREATE TABLE Cart(
	uid int NOT NULL,
	enum int NOT NULL,
	ename VARCHAR(100),
	price DECIMAL(9,2),
	quantity int,
	PRIMARY KEY(uid, enum),
	CONSTRAINT FK_Cart_TUser FOREIGN KEY (uid) REFERENCES TUser(uid),
	CONSTRAINT FK_Cart_Ticket FOREIGN KEY (enum) REFERENCES Event(enum)
);

CREATE TABLE OrderInfo(
	orderNo int NOT NULL IDENTITY PRIMARY KEY,
    enum int,
    uid int ,
    tnum CHAR(50),
    amountPaid DECIMAL(9,2),
    purchasetime DATETIME,
    CONSTRAINT FK_Order_Event FOREIGN KEY (enum) REFERENCES Event(enum),
    CONSTRAINT FK_Order_Ticket FOREIGN KEY (tnum) REFERENCES Ticket(tnum),
	CONSTRAINT FK_Order_TUser FOREIGN KEY (uid) REFERENCES TUser(uid)
);

CREATE TABLE Photo (
	photoid int NOT NULL,
	image Varbinary(max) not null,
	enum int NOT NULL,
    PRIMARY KEY (enum, photoid),
    CONSTRAINT FK_Photo_Event FOREIGN KEY (enum) REFERENCES Event(enum)
);
	

CREATE TABLE CreditCard (
	uid int NOT NULL,
    cardnum int	NOT NULL,
    expirydate DATE,
    ccv int,
    fullName VARCHAR(50),
    PRIMARY KEY (uid),
    CONSTRAINT FK_CC_TUSER FOREIGN KEY (uid) REFERENCES TUser (uid)
);

CREATE TABLE EventDiscussion(
	enum int NOT NULL IDENTITY PRIMARY KEY,
	username VARCHAR(20),
	comment VARCHAR(100),
	CONSTRAINT FK_ED_E FOREIGN KEY (enum) REFERENCES Event(enum)
);

INSERT INTO TUser VALUES ('user', 'pass', 'John', 'Doe', '123 Street. Kelowna, BC', 'johndoe@ticketwizard.ca', '2501234560', 'true' );
INSERT INTO TUser VALUES ('user2', 'pass2', 'Winston', 'Churchhill', '321 Street. Kelowna, BC', 'wchurchhill@ticketwizard.ca', '2506543210', 'false' );
INSERT INTO TUser VALUES ('user3', 'pass3', 'Will', 'Blake', '456 Street. Kelowna, BC', 'reddragon@ticketwizard.ca', '2504441234', 'false' );

INSERT INTO Event(ename, description, city, location, maxcapacity, hostid, ticketprice, category) VALUES ('ename', 'description', 'city', 'location', 100, 3, 100, 'Other');

INSERT INTO Event(ename, description, city, location, maxcapacity, hostid, ticketprice, category) VALUES ('Another Other', 'description anothher', 'city', 'location', 100, 3, 100, 'Other');

INSERT INTO Event(ename, description, city, location, maxcapacity, hostid, ticketprice, category) VALUES( 'UBCO Mens BasketBall Game', 'Come show your support to UBCO Heat this weekend', 'Kelowna', 'UBCO Hangar, Univesity Way', 100, 3, 15, 'Sports');

INSERT INTO Event(ename, description, city, location, maxcapacity, hostid, ticketprice, category) VALUES( 'Casino Night', 'Annual Casino night to raise awareness/money for some charitable cause', 'Vancouver', 'UNC Ballroom, University Way', 50, 2, 15, 'Other');

INSERT INTO Event(ename, description, city, location, maxcapacity, hostid, ticketprice, category) VALUES( 'All You Can Eat KBBQ', 'UBCO Korean Club is hosting an all you can eat KBBQ night at the UNC Ballroom. All UBCO students welcome!', 'Kelowna', 'UNC Ballroom, University Way', 30, 2, 0, 'Food');
