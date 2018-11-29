DROP TABLE CreditCard;
DROP TABLE OrderInfo;
DROP TABLE Ticket;
DROP TABLE EventSection;
DROP TABLE Event;
DROP TABLE TUser;


CREATE TABLE TUser (
    uid int NOT NULL, 
    username VARCHAR(20) NOT NULL,
    upw VARCHAR(20) NOT NULL,
    firstname VARCHAR(20) NOT NULL,
    lastname VARCHAR(20) NOT NULL,
    address VARCHAR(100),
    email VARCHAR(50) NOT NULL,
    phone CHAR(15),
    PRIMARY KEY (uid)
);


CREATE TABLE Event (
    enum int NOT NULL IDENTITY PRIMARY KEY,
    ename VARCHAR(100),
    description VARCHAR(200),
    city VARCHAR(50),
    location VARCHAR(100),
    maxcapacity int,
    hostid int,
    CONSTRAINT FK_Event_TUser FOREIGN KEY (hostid) REFERENCES TUser(uid)
);


CREATE TABLE EventSection (
    enum int NOT NULL,
    etime DATETIME NOT NULL,
    currentCapacity int,
    PRIMARY KEY (enum, etime),
    CONSTRAINT FK_EventSec_Event FOREIGN KEY (enum) REFERENCES Event(enum)
);

CREATE TABLE Ticket (
    tnum int NOT NULL,
    enum int,
    tier int,
    seatnum int,
    etime DATETIME,
    PRIMARY KEY (tnum),
    CONSTRAINT FK_Ticket_EventSec FOREIGN KEY (enum, etime) REFERENCES EventSection(enum, etime)
);

CREATE TABLE OrderInfo(
	orderNo int NOT NULL IDENTITY PRIMARY KEY,
    enum int,
    etime DATETIME,
    uid int ,
    tnum int,
    amoundPaid DECIMAL(9,2),
    purchasetime DATETIME,
    CONSTRAINT FK_Order_EventSec FOREIGN KEY (enum, etime) REFERENCES EventSection(enum, etime),
    CONSTRAINT FK_Order_Ticket FOREIGN KEY (tnum) REFERENCES Ticket(tnum),
	CONSTRAINT FK_Order_TUser FOREIGN KEY (uid) REFERENCES TUser(uid)
);

CREATE TABLE CreditCard (
	uid int NOT NULL,
    cardnum int	NOT NULL,
    expirydate DATE,
    ccv int,
    fullName VARCHAR(50),
    PRIMARY KEY (cardnum, uid),
    CONSTRAINT FK_CC_TUSER FOREIGN KEY (uid) REFERENCES TUser (uid)
);

INSERT INTO TUser VALUES (1, 'user', 'pass', 'John', 'Doe', '123 Street. Kelowna, BC', 'johndoe@ticketwizard.ca', '2501234560' );
INSERT INTO TUser VALUES (2, 'user2', 'pass2', 'Winston', 'Churchhill', '321 Street. Kelowna, BC', 'wchurchhill@ticketwizard.ca', '2506543210' );
INSERT INTO TUser VALUES (3, 'user3', 'pass3', 'Will', 'Blake', '456 Street. Kelowna, BC', 'reddragon@ticketwizard.ca', '2504441234' );

INSERT INTO Event(ename, description, city, location, maxcapacity, hostid) VALUES ('ename', 'description', 'city', 'location', 100, 3);

INSERT INTO Event(ename, description, city, location, maxcapacity, hostid) VALUES( 'UBCO Mens BasketBall Game', 'Come show your support to UBCO Heat this weekend', 'Kelowna', 'UBCO Hangar, Univesity Way', 100, 3);

INSERT INTO Event(ename, description, city, location, maxcapacity, hostid) VALUES( 'Casino Night', 'Annual Casino night to raise awareness/money for some charitable cause', 'Vancouver', 'UNC Ballroom, University Way', 50, 2);

INSERT INTO Event(ename, description, city, location, maxcapacity, hostid) VALUES( 'All You Can Eat KBBQ', 'UBCO Korean Club is hosting an all you can eat KBBQ night at the UNC Ballroom. All UBCO students welcome!', 'Kelowna', 'UNC Ballroom, University Way', 30, 2);

