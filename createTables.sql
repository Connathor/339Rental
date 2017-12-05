USE RENTAL;  
GO

CREATE TABLE EMPLOYEE (
	SSN char(9) NOT NULL,
	F_Name varchar(16) NOT NULL,
	L_Name varchar(16) NOT NULL,
	Loc_no tinyint NOT NULL,
	Salary int,
	PRIMARY KEY (SSN)
);
CREATE TABLE VEH_LIFESPAN(
	Type varchar(8) NOT NULL,
	Miles int NOT NULL,
	PRIMARY KEY (Type)
);
CREATE TABLE VEHICLES (
	VIN char(17) NOT NULL,
	Licence char(8) NOT NULL,
	Model varchar(10),
	Make varchar(10),
	Year smallint,
	Type varchar(8),
	isHandicapAccessable bit NOT NULL,
	Miles int,
	PRIMARY KEY (VIN),
	FOREIGN KEY (Type) REFERENCES VEH_LIFESPAN(Type)
);
CREATE TABLE VEH_AVAIL(
	VIN char(17) NOT NULL,
	isAvail bit NOT NULL,
	inMaint bit NOT NULL,
	isRented bit NOT NULL,
	isPendingPurchase bit NOT NULL,
	FOREIGN KEY (VIN) REFERENCES VEHICLES(VIN)
);
CREATE TABLE DRIVERS(
	D_SSN char(9) NOT NULL,
	isAvail bit NOT NULL,
	inRoute bit NOT NULL,
	FOREIGN KEY (D_SSN) REFERENCES EMPLOYEE(SSN)
);
CREATE TABLE VEH_LOC(
	VIN char(17) NOT NULL,
	LOC_NO tinyint NOT NULL,
	FOREIGN KEY (VIN) REFERENCES VEHICLES(VIN)
);
CREATE TABLE CUSTOMER(
	CID int NOT NULL,
	F_Name varchar(16) NOT NULL,
	L_Name varchar(16) NOT NULL,
	DOB date NOT NULL,
	LAST_FOUR_SSN tinyint NOT NULL,
	PRIMARY KEY (CID)
);
CREATE TABLE COMPLAINTS(
	COM_ID smallint NOT NULL,
	CID int NOT NULL,
	VIN char(17) NOT NULL,
	Complaint varchar(240) NOT NULL,
	Date_submited datetime NOT NULL,
	isResolved bit NOT NULL,
	PRIMARY KEY (COM_ID),
	FOREIGN KEY (VIN) REFERENCES VEHICLES(VIN),
	FOREIGN KEY (CID) REFERENCES CUSTOMER(CID)
);
CREATE TABLE POTENTIAL_PROBLEMS(
	POT_ID smallint NOT NULL,
	VIN char(17) NOT NULL,
	Problem tinyint NOT NULL,
	COMID smallint NOT NULL,
	PRIMARY KEY (POT_ID),
	FOREIGN KEY (COMID) REFERENCES COMPLAINTS(COM_ID)
);
CREATE TABLE PROBLEMS(
	P_ID smallint NOT NULL,
	Problem varchar(20) NOT NULL,
	FOREIGN KEY (P_ID) REFERENCES POTENTIAL_PROBLEMS(POT_ID)
);
CREATE TABLE LOC(
	LOC_NO smallint NOT NULL,
	state varchar(16) NOT NULL,
	city varchar(16) NOT NULL,
	address varchar(16) NOT NULL,
	PRIMARY KEY (LOC_NO)
);
CREATE TABLE DEPENDENTS (
	E_SSN char(9) NOT NULL,
	Relation varchar(16) NOT NULL,
	F_Name varchar(16) NOT NULL,
	L_Name varchar(16) NOT NULL,
	Phone_no int NOT NULL,
	address varchar(16) NOT NULL,
	priority tinyint,
	FOREIGN KEY (E_SSN) REFERENCES EMPLOYEE(SSN)
);

CREATE TABLE MANAGERS(
	M_SSN char(9) NOT NULL,
	LOC_NO tinyint NOT NULL,
	isStore bit NOT  NULL,
	FOREIGN KEY (M_SSN) REFERENCES EMPLOYEE(SSN)
);
CREATE TABLE PAYMENT(
	Pay_ID int NOT NULL,
	Pay_Type varchar(8) NOT NULL,
	PRIMARY KEY (Pay_ID)
);
CREATE TABLE RECORD_OF_SALES(
	VIN char(17) NOT NULL,
	CID int NOT NULL,
	E_SSN char(9) NOT NULL,
	LOC_NO tinyint NOT NULL,
	isRented bit NOT  NULL,
	Price smallmoney NOT NULL,
	Date date NOT NULL,
	Payment_Type varchar(10) NOT NULL,
	FOREIGN KEY (VIN) REFERENCES VEHICLES(VIN),
	FOREIGN KEY (CID) REFERENCES CUSTOMER(CID),
	FOREIGN KEY (E_SSN) REFERENCES EMPLOYEE(SSN),

);
GO