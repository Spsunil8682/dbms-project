drop database if exists vehicle_insurance;

create database vehicle_insurance;

use vehicle_insurance;

drop table if exists technophiles_INCIDENT;

CREATE TABLE technophiles_INCIDENT (
	technophiles_INCIDENT_Incident_Id VARCHAR(50) NOT NULL,
	technophiles_INCIDENT_Incident_Type VARCHAR(50) NULL,
	technophiles_INCIDENT_Incident_Date date NOT NULL,
	technophiles_INCIDENT_Description VARCHAR(200) NULL,
	CONSTRAINT XPKINCIDENT_17 PRIMARY KEY (technophiles_INCIDENT_Incident_Id)
);

drop table if exists technophiles_CUSTOMER;

CREATE TABLE technophiles_CUSTOMER (
	technophiles_CUSTOMER_Cust_Id VARCHAR(20) NOT NULL,
	technophiles_CUSTOMER_Cust_FName VARCHAR(20) NOT NULL,
	technophiles_CUSTOMER_Cust_LName VARCHAR(20) NOT NULL,
	technophiles_CUSTOMER_Cust_DOB date NOT NULL,
	technophiles_CUSTOMER_Cust_Gender CHAR(2) NOT NULL,
	technophiles_CUSTOMER_Cust_Address VARCHAR(20) NOT NULL,
	technophiles_CUSTOMER_Cust_MOB_Number bigint NOT NULL,
	technophiles_CUSTOMER_Cust_Email VARCHAR(50) NULL,
	technophiles_CUSTOMER_Cust_Passport_Number VARCHAR(20) NULL,
	technophiles_CUSTOMER_Cust_Marital_Status CHAR(8) NULL,
	technophiles_CUSTOMER_Cust_PPS_Number INTEGER NULL,
	CONSTRAINT technophiles_CUSTOMER_XPKCUSTOMER_1 PRIMARY KEY (technophiles_CUSTOMER_Cust_Id)
);

drop table if exists technophiles_INCIDENT_REPORT;

CREATE TABLE technophiles_INCIDENT_REPORT (
	technophiles_INCIDENT_REPORT_Incident_Report_Id VARCHAR(20) NOT NULL,
	technophiles_INCIDENT_REPORT_Incident_Type CHAR(50) NULL,
	technophiles_INCIDENT_REPORT_Incident_Inspector VARCHAR(20) NULL,
	technophiles_INCIDENT_REPORT_Incident_Date date NULL,
	technophiles_INCIDENT_REPORT_Incident_Cost INTEGER NULL,
	technophiles_INCIDENT_REPORT_Incident_Report_Description VARCHAR(100) NULL,
	technophiles_INCIDENT_REPORT_Incident_Id VARCHAR(20) NOT NULL,
	technophiles_INCIDENT_REPORT_Cust_Id VARCHAR(20) NOT NULL,
	CONSTRAINT technophiles_INCIDENT_REPORT_XPKINCIDENT_REPORT_18 PRIMARY KEY (
		technophiles_INCIDENT_REPORT_Incident_Report_Id,
		technophiles_INCIDENT_REPORT_Incident_Id,
		technophiles_INCIDENT_REPORT_Cust_Id
	),
	CONSTRAINT R_83 FOREIGN KEY (technophiles_INCIDENT_REPORT_Incident_Id) REFERENCES technophiles_INCIDENT (technophiles_INCIDENT_Incident_Id),
	CONSTRAINT R_86 FOREIGN KEY (technophiles_INCIDENT_REPORT_Cust_Id) REFERENCES technophiles_CUSTOMER (technophiles_CUSTOMER_Cust_Id)
);

drop table if exists technophiles_INSURANCE_COMPANY;

CREATE TABLE technophiles_INSURANCE_COMPANY (
	technophiles_INSURANCE_COMPANY_Company_id int not null,
	technophiles_INSURANCE_COMPANY_Company_Name VARCHAR(50) NOT NULL,
	technophiles_INSURANCE_COMPANY_Company_Address VARCHAR(200) NULL,
	technophiles_INSURANCE_COMPANY_Company_Contact_Number bigint NULL,
	technophiles_INSURANCE_COMPANY_Company_Fax bigint NULL,
	technophiles_INSURANCE_COMPANY_Company_Email VARCHAR(50) NULL,
	technophiles_INSURANCE_COMPANY_Company_Website VARCHAR(50) NULL,
	technophiles_INSURANCE_COMPANY_Company_Location VARCHAR(50) NULL,
	technophiles_INSURANCE_COMPANY_Company_Department_Name VARCHAR(50) NULL,
	technophiles_INSURANCE_COMPANY_Company_Office_Name VARCHAR(50) NULL,
	CONSTRAINT technophiles_INSURANCE_COMPANY_XPKINSURANCE_COMPANY_15 PRIMARY KEY (technophiles_INSURANCE_COMPANY_Company_id)
);

drop table if exists technophiles_DEPARTMENT;

CREATE TABLE technophiles_DEPARTMENT (
	technophiles_DEPARTMENT_Department_Name VARCHAR(50) NOT NULL,
	technophiles_DEPARTMENT_Department_ID int NOT NULL,
	technophiles_DEPARTMENT_Department_Staff CHAR(50) NULL,
	technophiles_DEPARTMENT_Company_id int NOT NULL,
	CONSTRAINT technophiles_DEPARTMENT_XPKDEPARTMENT PRIMARY KEY (
		technophiles_DEPARTMENT_Department_ID,
		technophiles_DEPARTMENT_Company_id
	),
	CONSTRAINT R_56 FOREIGN KEY (technophiles_DEPARTMENT_Company_id) REFERENCES technophiles_INSURANCE_COMPANY (technophiles_INSURANCE_COMPANY_Company_id)
);
-- CREATE UNIQUE INDEX technophiles_DEPARTMENT_XPKDEPARTMENT ON technophiles_DEPARTMENT
-- (technophiles_DEPARTMENT_Department_ID ASC, technophiles_DEPARTMENT_Company_id ASC);

drop table if exists technophiles_VEHICLE_SERVICE;

CREATE TABLE technophiles_VEHICLE_SERVICE (
	technophiles_VEHICLE_SERVICE_Department_id int NOT NULL,
	technophiles_VEHICLE_SERVICE_Vehicle_Service_Company_Name VARCHAR(50) NOT NULL,
	technophiles_VEHICLE_SERVICE_Vehicle_Service_Address VARCHAR(50) NULL,
	technophiles_VEHICLE_SERVICE_Vehicle_Service_Contact VARCHAR(50) NULL,
	technophiles_VEHICLE_SERVICE_Vehicle_Service_Incharge VARCHAR(50) NULL,
	technophiles_VEHICLE_SERVICE_Vehicle_Service_Type VARCHAR(50) NULL,
	technophiles_VEHICLE_SERVICE_Company_id int NOT NULL,
	CONSTRAINT technophiles_VEHICLE_SERVICE_XPKVEHICLE_SERVICE PRIMARY KEY (
		technophiles_VEHICLE_SERVICE_Vehicle_Service_Company_name,
		technophiles_VEHICLE_SERVICE_Department_id
	),
	CONSTRAINT R_50 FOREIGN KEY (
		technophiles_VEHICLE_SERVICE_Company_id,
		technophiles_VEHICLE_SERVICE_Department_id
	) REFERENCES technophiles_DEPARTMENT (
		technophiles_DEPARTMENT_Company_id,
		technophiles_DEPARTMENT_Department_id
	)
);

drop table if exists technophiles_VEHICLE;

CREATE TABLE technophiles_VEHICLE (
	technophiles_VEHICLE_Vehicle_Id VARCHAR(20) NOT NULL,
	technophiles_VEHICLE_Policy_Id VARCHAR(20) NULL,
	technophiles_VEHICLE_Vehicle_Registration_Number VARCHAR(20) NOT NULL,
	technophiles_VEHICLE_Vehicle_Value INTEGER NULL,
	technophiles_VEHICLE_Vehicle_Type VARCHAR(20) NOT NULL,
	technophiles_VEHICLE_Vehicle_Size INTEGER NULL,
	technophiles_VEHICLE_Vehicle_Number_Of_Seat INTEGER NULL,
	technophiles_VEHICLE_Vehicle_Manufacturer VARCHAR(20) NULL,
	technophiles_VEHICLE_Vehicle_Engine_Number INTEGER NULL,
	technophiles_VEHICLE_Vehicle_Chasis_Number INTEGER NULL,
	technophiles_VEHICLE_Vehicle_Number VARCHAR(20) NULL,
	technophiles_VEHICLE_Vehicle_Model_Number VARCHAR(20) NULL,
	technophiles_VEHICLE_Cust_Id VARCHAR(20) NOT NULL,
	CONSTRAINT technophiles_VEHICLE_XPKVEHICLE_6 PRIMARY KEY (
		technophiles_VEHICLE_Vehicle_Id,
		technophiles_VEHICLE_Cust_Id
	),
	CONSTRAINT R_92 FOREIGN KEY (technophiles_VEHICLE_Cust_Id) REFERENCES technophiles_CUSTOMER (technophiles_CUSTOMER_Cust_Id)
);

drop table if exists technophiles_PREMIUM_PAYMENT;

CREATE TABLE technophiles_PREMIUM_PAYMENT (
	technophiles_PREMIUM_PAYMENT_Premium_Payment_Id VARCHAR(20) NOT NULL,
	technophiles_PREMIUM_PAYMENT_Policy_Number VARCHAR(20) NOT NULL,
	technophiles_PREMIUM_PAYMENT_Premium_Payment_Amount INTEGER NOT NULL,
	technophiles_PREMIUM_PAYMENT_Premium_Payment_Schedule DATE NOT NULL,
	technophiles_PREMIUM_PAYMENT_Receipt_Id VARCHAR(20) NOT NULL,
	technophiles_PREMIUM_PAYMENT_Cust_Id VARCHAR(20) NOT NULL,
	CONSTRAINT technophiles_PREMIUM_PAYMENT_XPKPREMIUM_PAYMENT_5 PRIMARY KEY (
		technophiles_PREMIUM_PAYMENT_Premium_Payment_Id,
		technophiles_PREMIUM_PAYMENT_Cust_Id
	),
	CONSTRAINT R_85 FOREIGN KEY (technophiles_PREMIUM_PAYMENT_Cust_Id) REFERENCES technophiles_CUSTOMER (technophiles_CUSTOMER_Cust_Id)
);

drop table if exists technophiles_RECEIPT;

CREATE TABLE technophiles_RECEIPT (
	technophiles_RECEIPT_Receipt_Id VARCHAR(20) NOT NULL,
	technophiles_RECEIPT_Time DATE NOT NULL,
	technophiles_RECEIPT_Cost INTEGER NOT NULL,
	technophiles_RECEIPT_Premium_Payment_Id VARCHAR(20) NOT NULL,
	technophiles_RECEIPT_Cust_Id VARCHAR(20) NOT NULL,
	CONSTRAINT technophiles_RECEIPT_XPKRECEIPT_21 PRIMARY KEY (
		technophiles_RECEIPT_Receipt_Id,
		technophiles_RECEIPT_Premium_Payment_Id,
		technophiles_RECEIPT_Cust_Id
	),
	CONSTRAINT R_84 FOREIGN KEY (
		technophiles_RECEIPT_Premium_Payment_Id,
		technophiles_RECEIPT_Cust_Id
	) REFERENCES technophiles_PREMIUM_PAYMENT (
		technophiles_PREMIUM_PAYMENT_Premium_Payment_Id,
		technophiles_PREMIUM_PAYMENT_Cust_Id
	)
);

drop table if exists technophiles_APPLICATION;

CREATE TABLE technophiles_APPLICATION (
	technophiles_APPLICATION_Application_Id VARCHAR(20) NOT NULL,
	technophiles_APPLICATION_Vehicle_Id VARCHAR(20) NOT NULL,
	technophiles_APPLICATION_Application_Status CHAR(8) NOT NULL,
	technophiles_APPLICATION_Coverage VARCHAR(50) NOT NULL,
	technophiles_APPLICATION_Cust_Id VARCHAR(20) NOT NULL,
	CONSTRAINT technophiles_APPLICATION_XPKAPPLICATION_2 PRIMARY KEY (
		technophiles_APPLICATION_Application_Id,
		technophiles_APPLICATION_Cust_Id
	),
	CONSTRAINT R_93 FOREIGN KEY (technophiles_APPLICATION_Cust_Id) REFERENCES technophiles_CUSTOMER (technophiles_CUSTOMER_Cust_Id)
);

drop table if exists technophiles_INSURANCE_POLICY;

CREATE TABLE technophiles_INSURANCE_POLICY (
	technophiles_INSURANCE_POLICY_Agreement_id VARCHAR(20) NOT NULL,
	technophiles_INSURANCE_POLICY_Department_Name VARCHAR(50) NULL,
	technophiles_INSURANCE_POLICY_Policy_Number VARCHAR(20) NULL,
	technophiles_INSURANCE_POLICY_Start_Date DATE NULL,
	technophiles_INSURANCE_POLICY_Expiry_Date DATE NULL,
	technophiles_INSURANCE_POLICY_Term_Condition_Description VARCHAR(200) NULL,
	technophiles_INSURANCE_POLICY_Application_Id VARCHAR(20) NOT NULL,
	technophiles_INSURANCE_POLICY_Cust_Id VARCHAR(20) NOT NULL,
	CONSTRAINT technophiles_INSURANCE_POLICY_XPKINSURANCE_POLICY_4 PRIMARY KEY (
		technophiles_INSURANCE_POLICY_Agreement_id,
		technophiles_INSURANCE_POLICY_Application_Id,
		technophiles_INSURANCE_POLICY_Cust_Id
	),
	CONSTRAINT R_95 FOREIGN KEY (
		technophiles_INSURANCE_POLICY_Application_Id,
		technophiles_INSURANCE_POLICY_Cust_Id
	) REFERENCES technophiles_APPLICATION (
		technophiles_APPLICATION_Application_Id,
		technophiles_APPLICATION_Cust_Id
	)
);

drop table if exists technophiles_POLICY_RENEWABLE;

CREATE TABLE technophiles_POLICY_RENEWABLE (
	technophiles_POLICY_RENEWABLE_Policy_Renewable_Id VARCHAR(20) NOT NULL,
	technophiles_POLICY_RENEWABLE_Date_Of_Renewal DATETIME NOT NULL,
	technophiles_POLICY_RENEWABLE_Type_Of_Renewal CHAR(15) NOT NULL,
	technophiles_POLICY_RENEWABLE_Agreement_id VARCHAR(20) NOT NULL,
	technophiles_POLICY_RENEWABLE_Application_Id VARCHAR(20) NOT NULL,
	technophiles_POLICY_RENEWABLE_Cust_Id VARCHAR(20) NOT NULL,
	CONSTRAINT technophiles_POLICY_RENEWABLE_XPKPOLICY_RENEWABLE_16 PRIMARY KEY (
		technophiles_POLICY_RENEWABLE_Policy_Renewable_Id,
		technophiles_POLICY_RENEWABLE_Agreement_id,
		technophiles_POLICY_RENEWABLE_Application_Id,
		technophiles_POLICY_RENEWABLE_Cust_Id
	),
	CONSTRAINT R_101 FOREIGN KEY (
		technophiles_POLICY_RENEWABLE_Agreement_id,
		technophiles_POLICY_RENEWABLE_Application_Id,
		technophiles_POLICY_RENEWABLE_Cust_Id
	) REFERENCES technophiles_INSURANCE_POLICY (
		technophiles_INSURANCE_POLICY_Agreement_id,
		technophiles_INSURANCE_POLICY_Application_Id,
		technophiles_INSURANCE_POLICY_Cust_Id
	)
);

drop table if exists technophiles_MEMBERSHIP;

CREATE TABLE technophiles_MEMBERSHIP (
	technophiles_MEMBERSHIP_Membership_Id VARCHAR(20) NOT NULL,
	technophiles_MEMBERSHIP_Membership_Type CHAR(15) NOT NULL,
	technophiles_MEMBERSHIP_Organisation_Contact VARCHAR(20) NULL,
	technophiles_MEMBERSHIP_Cust_Id VARCHAR(20) NOT NULL,
	CONSTRAINT technophiles_MEMBERSHIP_XPKMEMBERSHIP_12 PRIMARY KEY (
		technophiles_MEMBERSHIP_Membership_Id,
		technophiles_MEMBERSHIP_Cust_Id
	),
	CONSTRAINT R_91 FOREIGN KEY (technophiles_MEMBERSHIP_Cust_Id) REFERENCES technophiles_CUSTOMER (technophiles_CUSTOMER_Cust_Id)
);

drop table if exists technophiles_QU0TE;

CREATE TABLE technophiles_QU0TE (
	technophiles_QU0TE_Quote_Id VARCHAR(20) NOT NULL,
	technophiles_QU0TE_Issue_Date DATE NOT NULL,
	technophiles_QU0TE_Valid_From_Date DATE NOT NULL,
	technophiles_QU0TE_Valid_Till_Date DATE NOT NULL,
	technophiles_QU0TE_Description VARCHAR(100) NULL,
	technophiles_QU0TE_Product_Id VARCHAR(20) NOT NULL,
	technophiles_QU0TE_Coverage_Level VARCHAR(20) NOT NULL,
	technophiles_QU0TE_Application_Id VARCHAR(20) NOT NULL,
	technophiles_QU0TE_Cust_Id VARCHAR(20) NOT NULL,
	CONSTRAINT technophiles_QU0TE_XPKQU0TE_3 PRIMARY KEY (
		technophiles_QU0TE_Quote_Id,
		technophiles_QU0TE_Application_Id,
		technophiles_QU0TE_Cust_Id
	),
	CONSTRAINT R_94 FOREIGN KEY (
		technophiles_QU0TE_Application_Id,
		technophiles_QU0TE_Cust_Id
	) REFERENCES technophiles_APPLICATION (
		technophiles_APPLICATION_Application_Id,
		technophiles_APPLICATION_Cust_Id
	)
);

drop table if exists technophiles_STAFF;

CREATE TABLE technophiles_STAFF (
	technophiles_STAFF_Staff_Id VARCHAR(20) NOT NULL,
	technophiles_STAFF_Staff_Fname VARCHAR(10) NULL,
	technophiles_STAFF_Staff_LName VARCHAR(10) NULL,
	technophiles_STAFF_Staff_Adress VARCHAR(20) NULL,
	technophiles_STAFF_Staff_Contact bigint NULL,
	technophiles_STAFF_Staff_Gender CHAR(2) NULL,
	technophiles_STAFF_Staff_Marital_Status CHAR(20) NULL,
	technophiles_STAFF_Staff_Nationality CHAR(15) NULL,
	technophiles_STAFF_Staff_Qualification VARCHAR(20) NULL,
	technophiles_STAFF_Staff_Allowance INTEGER NULL,
	technophiles_STAFF_Staff_PPS_Number INTEGER NULL,
	technophiles_STAFF_Company_id int NOT NULL,
	CONSTRAINT technophiles_STAFF_XPKSTAFF_9 PRIMARY KEY (
		technophiles_STAFF_Staff_Id,
		technophiles_STAFF_Company_id
	),
	CONSTRAINT R_105 FOREIGN KEY (technophiles_STAFF_Company_id) REFERENCES technophiles_INSURANCE_COMPANY (technophiles_INSURANCE_COMPANY_Company_id)
);

drop database if exists technophiles_NOK;

CREATE TABLE technophiles_NOK (
	technophiles_NOK_Nok_Id VARCHAR(20) NOT NULL,
	technophiles_NOK_Nok_Name VARCHAR(20) NULL,
	technophiles_NOK_Nok_Address VARCHAR(20) NULL,
	technophiles_NOK_Nok_Phone_Number bigint NULL,
	technophiles_NOK_Nok_Gender CHAR(10) NULL,
	technophiles_NOK_Nok_Marital_Status CHAR(8) NULL,
	technophiles_NOK_Agreement_id VARCHAR(20) NOT NULL,
	technophiles_NOK_Application_Id VARCHAR(20) NOT NULL,
	technophiles_NOK_Cust_Id VARCHAR(20) NOT NULL,
	CONSTRAINT technophiles_NOK_XPKNOK_14 PRIMARY KEY (
		technophiles_NOK_Nok_Id,
		technophiles_NOK_Agreement_id,
		technophiles_NOK_Application_Id,
		technophiles_NOK_Cust_Id
	),
	CONSTRAINT R_99 FOREIGN KEY (
		technophiles_NOK_Agreement_id,
		technophiles_NOK_Application_Id,
		technophiles_NOK_Cust_Id
	) REFERENCES technophiles_INSURANCE_POLICY (
		technophiles_INSURANCE_POLICY_Agreement_id,
		technophiles_INSURANCE_POLICY_Application_Id,
		technophiles_INSURANCE_POLICY_Cust_Id
	)
);

CREATE UNIQUE INDEX technophiles_NOK_XPKNOK_14 ON technophiles_NOK (
	technophiles_NOK_Nok_Id ASC,
	technophiles_NOK_Agreement_id ASC,
	technophiles_NOK_Application_Id ASC
);

drop table if exists technophiles_PRODUCT;

CREATE TABLE technophiles_PRODUCT (
	technophiles_PRODUCT_Product_Price INTEGER NULL,
	technophiles_PRODUCT_Product_Type CHAR(15) NULL,
	technophiles_PRODUCT_Product_Number VARCHAR(20) NOT NULL,
	technophiles_PRODUCT_Company_id int NOT NULL,
	CONSTRAINT technophiles_PRODUCT_XPKPRODUCT_20 PRIMARY KEY (
		technophiles_PRODUCT_Product_Number,
		technophiles_PRODUCT_Company_id
	),
	CONSTRAINT R_107 FOREIGN KEY (technophiles_PRODUCT_Company_id) REFERENCES technophiles_INSURANCE_COMPANY (technophiles_INSURANCE_COMPANY_Company_id)
);

drop table if exists technophiles_OFFICE;

CREATE TABLE technophiles_OFFICE (
	technophiles_OFFICE_Office_Name VARCHAR(50) NOT NULL,
	technophiles_OFFICE_Office_Leader VARCHAR(50) NOT NULL,
	technophiles_OFFICE_Contact_Information VARCHAR(50) NOT NULL,
	technophiles_OFFICE_Address VARCHAR(50) NOT NULL,
	technophiles_OFFICE_Admin_Cost INTEGER NULL,
	technophiles_OFFICE_Staff VARCHAR(50) NULL,
	technophiles_OFFICE_Department_id int NOT NULL,
	technophiles_OFFICE_Company_id int NOT NULL,
	CONSTRAINT technophiles_OFFICE_XPKOFFICE_11 PRIMARY KEY (
		technophiles_OFFICE_Office_Name,
		technophiles_OFFICE_Department_id,
		technophiles_OFFICE_Company_id
	),
	CONSTRAINT R_104 FOREIGN KEY (
		technophiles_OFFICE_Company_id,
		technophiles_OFFICE_Department_id

	) REFERENCES technophiles_DEPARTMENT (
		technophiles_DEPARTMENT_Company_id,
		technophiles_DEPARTMENT_Department_id
	)
);

drop table if exists technophiles_COVERAGE;

CREATE TABLE technophiles_COVERAGE (
	technophiles_COVERAGE_Coverage_Id VARCHAR(20) NOT NULL,
	technophiles_COVERAGE_Coverage_Amount INTEGER NOT NULL,
	technophiles_COVERAGE_Coverage_Type CHAR(50) NOT NULL,
	technophiles_COVERAGE_Coverage_Level CHAR(15) NOT NULL,
	technophiles_COVERAGE_Product_Id VARCHAR(20) NOT NULL,
	technophiles_COVERAGE_Coverage_Description VARCHAR(200) NULL,
	technophiles_COVERAGE_Covearge_Terms VARCHAR(50) NULL,
	technophiles_COVERAGE_Company_id int NOT NULL,
	CONSTRAINT technophiles_COVERAGE_XPKCOVERAGE_19 PRIMARY KEY (
		technophiles_COVERAGE_Coverage_Id,
		technophiles_COVERAGE_Company_id
	),
	CONSTRAINT R_102 FOREIGN KEY (technophiles_COVERAGE_Company_id) REFERENCES technophiles_INSURANCE_COMPANY (technophiles_INSURANCE_COMPANY_Company_id)
);

drop table if exists technophiles_INSURANCE_POLICY_COVERAGE;

CREATE TABLE technophiles_INSURANCE_POLICY_COVERAGE (
	technophiles_INSURANCE_POLICY_COVERAGE_Agreement_id VARCHAR(20) NOT NULL,
	technophiles_INSURANCE_POLICY_COVERAGE_Application_Id VARCHAR(20) NOT NULL,
	technophiles_INSURANCE_POLICY_COVERAGE_Cust_Id VARCHAR(20) NOT NULL,
	technophiles_INSURANCE_POLICY_COVERAGE_Coverage_Id VARCHAR(20) NOT NULL,
	technophiles_INSURANCE_POLICY_COVERAGE_Company_id int NOT NULL,
	CONSTRAINT technophiles_INSURANCE_POLICY_COVERAGE_4 PRIMARY KEY (
		technophiles_INSURANCE_POLICY_COVERAGE_Agreement_id,
		technophiles_INSURANCE_POLICY_COVERAGE_Application_Id,
		technophiles_INSURANCE_POLICY_COVERAGE_Cust_Id,
		technophiles_INSURANCE_POLICY_COVERAGE_Coverage_Id,
		technophiles_INSURANCE_POLICY_COVERAGE_Company_id
	),
	CONSTRAINT R_97 FOREIGN KEY (
		technophiles_INSURANCE_POLICY_COVERAGE_Agreement_id,
		technophiles_INSURANCE_POLICY_COVERAGE_Application_Id,
		technophiles_INSURANCE_POLICY_COVERAGE_Cust_Id
	) REFERENCES technophiles_INSURANCE_POLICY (
		technophiles_INSURANCE_POLICY_Agreement_id,
		technophiles_INSURANCE_POLICY_Application_Id,
		technophiles_INSURANCE_POLICY_Cust_Id
	),
	CONSTRAINT R_98 FOREIGN KEY (
		technophiles_INSURANCE_POLICY_COVERAGE_Coverage_Id,
		technophiles_INSURANCE_POLICY_COVERAGE_Company_id
	) REFERENCES technophiles_COVERAGE (
		technophiles_COVERAGE_Coverage_Id,
		technophiles_COVERAGE_Company_id
	)
);

drop table if exists technophiles_CLAIM;

CREATE TABLE technophiles_CLAIM (
	technophiles_CLAIM_Claim_Id VARCHAR(20) NOT NULL,
	technophiles_CLAIM_Agreement_Id VARCHAR(20) NOT NULL,
	technophiles_CLAIM_Claim_Amount INTEGER NOT NULL,
	technophiles_CLAIM_Incident_Id VARCHAR(20) NOT NULL,
	technophiles_CLAIM_Damage_Type VARCHAR(20) NOT NULL,
	technophiles_CLAIM_Date_Of_Claim DATE NOT NULL,
	technophiles_CLAIM_Claim_Status CHAR(10) NOT NULL,
	technophiles_CLAIM_Cust_Id VARCHAR(20) NOT NULL,
	CONSTRAINT technophiles_CLAIM_XPKCLAIM_7 PRIMARY KEY (
		technophiles_CLAIM_Claim_Id,
		technophiles_CLAIM_Cust_Id
	),
	CONSTRAINT R_88 FOREIGN KEY (technophiles_CLAIM_Cust_Id) REFERENCES technophiles_CUSTOMER (technophiles_CUSTOMER_Cust_Id)
);

drop table if exists technophiles_CLAIM_SETTLEMENT;

CREATE TABLE technophiles_CLAIM_SETTLEMENT (
	technophiles_CLAIM_SETTLEMENT_Claim_Settlement_Id VARCHAR(20) NOT NULL,
	technophiles_CLAIM_SETTLEMENT_Vehicle_Id VARCHAR(20) NOT NULL,
	technophiles_CLAIM_SETTLEMENT_Date_Settled DATETIME NOT NULL,
	technophiles_CLAIM_SETTLEMENT_Amount_Paid INTEGER NOT NULL,
	technophiles_CLAIM_SETTLEMENT_Coverage_Id VARCHAR(20) NOT NULL,
	technophiles_CLAIM_SETTLEMENT_Claim_Id VARCHAR(20) NOT NULL,
	technophiles_CLAIM_SETTLEMENT_Cust_Id VARCHAR(20) NOT NULL,
	CONSTRAINT technophiles_CLAIM_SETTLEMENT_XPKCLAIM_SETTLEMENT_8 PRIMARY KEY (
		technophiles_CLAIM_SETTLEMENT_Claim_Settlement_Id,
		technophiles_CLAIM_SETTLEMENT_Claim_Id,
		technophiles_CLAIM_SETTLEMENT_Cust_Id
	),
	CONSTRAINT R_90 FOREIGN KEY (
		technophiles_CLAIM_SETTLEMENT_Claim_Id,
		technophiles_CLAIM_SETTLEMENT_Cust_Id
	) REFERENCES technophiles_CLAIM (
		technophiles_CLAIM_Claim_Id,
		technophiles_CLAIM_Cust_Id
	)
);