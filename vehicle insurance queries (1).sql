use vehicle_insurance;

-- 1. Retrieve Customer and Vehicle details who has been 
-- involved in an incident and claim status is pending – Customer, vehicle, claim status, incident
select
    c.technophiles_CUSTOMER_Cust_Id as cust_id,
    concat(
        c.technophiles_CUSTOMER_Cust_FName,
        " ",
        c.technophiles_CUSTOMER_Cust_LName
    ) as cust_name,
--     c.technophiles_CUSTOMER_Cust_Gender as cust_gender,
    v.technophiles_VEHICLE_Vehicle_Id as vehicle_id,
--     v.technophiles_VEHICLE_Vehicle_Manufacturer as vehicle_manufacturer,
    v.technophiles_VEHICLE_Vehicle_Type as vehicle_type,
    v.technophiles_VEHICLE_Vehicle_Value as vehicle_value,
	i.technophiles_INCIDENT_REPORT_Incident_Report_Id as incident_report_id,
    i.technophiles_INCIDENT_REPORT_Incident_Type as incident_type,
    cl.technophiles_CLAIM_Claim_Status as claim_status
from
    technophiles_CUSTOMER c
    join technophiles_VEHICLE v on c.technophiles_CUSTOMER_Cust_Id = v.technophiles_VEHICLE_Cust_Id
    join technophiles_INCIDENT_REPORT i on c.technophiles_CUSTOMER_Cust_Id = i.technophiles_INCIDENT_REPORT_Cust_Id
    join (
        select
            distinct c.technophiles_CLAIM_Cust_Id,
            c.technophiles_CLAIM_Claim_Status
        from
            technophiles_CLAIM c
        where
            c.technophiles_CLAIM_Claim_Status = "Pending"
    ) as cl on cl.technophiles_CLAIM_Cust_Id = c.technophiles_CUSTOMER_Cust_Id;

-- 2. Retrieve customer details who has 
-- premium payment amount greater than the sum of all the customerIds in the database – premium payment, customer
select
    c.technophiles_CUSTOMER_Cust_Id as cust_id,
    concat(
        c.technophiles_CUSTOMER_Cust_FName,
        " ",
        c.technophiles_CUSTOMER_Cust_LName
    ) as cust_name,
    c.technophiles_CUSTOMER_Cust_Gender as cust_gender,
    p.technophiles_PREMIUM_PAYMENT_Premium_Payment_Id as payment_id,
    p.technophiles_PREMIUM_PAYMENT_Premium_Payment_Amount as payment_amount,
    (select
            sum(c.technophiles_CUSTOMER_Cust_Id)
        from
            technophiles_CUSTOMER c) as sum_of_cust_ids
from
    technophiles_CUSTOMER c
    join technophiles_PREMIUM_PAYMENT p on p.technophiles_PREMIUM_PAYMENT_Cust_Id = c.technophiles_CUSTOMER_Cust_Id
where
    p.technophiles_PREMIUM_PAYMENT_Premium_Payment_Amount > (
        select
            sum(c.technophiles_CUSTOMER_Cust_Id)
        from
            technophiles_CUSTOMER c
    );

-- 3. Retrieve Company details whose 
-- number of products is greater than departments, where the departments are located in more than one location—company, product, departments, office
select
    c.technophiles_INSURANCE_COMPANY_Company_id as company_id,
    c.technophiles_INSURANCE_COMPANY_Company_Name as company_Name,
    c.technophiles_INSURANCE_COMPANY_Company_Contact_Number as "contact_no.",
    c.technophiles_INSURANCE_COMPANY_Company_Location as company_location,
    count(distinct d.technophiles_DEPARTMENT_Department_id) as num_of_departments,
    count(p.technophiles_PRODUCT_Product_Number) as num_of_products
    
from
    technophiles_INSURANCE_COMPANY c
    join technophiles_PRODUCT p on c.technophiles_INSURANCE_COMPANY_Company_id = p.technophiles_PRODUCT_Company_id
    join (
        select
            d.*
        from
            technophiles_DEPARTMENT d
            join technophiles_OFFICE o on o.technophiles_OFFICE_Department_id = d.technophiles_DEPARTMENT_Department_id
        group by
            d.technophiles_DEPARTMENT_Department_id
        having
            count(o.technophiles_OFFICE_Office_Name) > 1
    ) as d on d.technophiles_DEPARTMENT_Company_id = c.technophiles_INSURANCE_COMPANY_Company_id
group by
    c.technophiles_INSURANCE_COMPANY_Company_id
having
    count(distinct d.technophiles_DEPARTMENT_Department_id) < count(p.technophiles_PRODUCT_Product_Number);

-- 4. Select Customers who have 
-- more than one Vehicle, where the premium for one of the Vehicles is not paid and it is involved in accident
select
    c.technophiles_CUSTOMER_Cust_Id as cust_id,
    concat(c.technophiles_CUSTOMER_Cust_FName, " ", c.technophiles_CUSTOMER_Cust_LName) as cust_name,
    c.technophiles_CUSTOMER_Cust_Gender as cust_gender,
    count(v.technophiles_VEHICLE_Vehicle_Id) as num_of_vehicles,
    r.technophiles_INCIDENT_REPORT_Incident_Report_Id as incident_report_id,
    r.technophiles_INCIDENT_REPORT_Incident_Type as incident_type,
    Premium_Payment_Amount,
    total_paid
from
    technophiles_CUSTOMER c
    join technophiles_VEHICLE v on c.technophiles_CUSTOMER_Cust_Id = v.technophiles_VEHICLE_Cust_Id
    join (
        select
            technophiles_PREMIUM_PAYMENT_Cust_Id,
            technophiles_PREMIUM_PAYMENT_Premium_Payment_Amount,
            sum(r.technophiles_RECEIPT_Cost) as total_paid,
            technophiles_PREMIUM_PAYMENT_Premium_Payment_Amount as Premium_Payment_Amount
        from
            technophiles_PREMIUM_PAYMENT p
            join technophiles_RECEIPT r on p.technophiles_PREMIUM_PAYMENT_Premium_Payment_Id = r.technophiles_RECEIPT_Premium_Payment_Id
            and p.technophiles_PREMIUM_PAYMENT_Cust_Id = r.technophiles_RECEIPT_Cust_Id
        group by
            p.technophiles_PREMIUM_PAYMENT_Cust_Id,
            p.technophiles_PREMIUM_PAYMENT_Premium_Payment_Id
        having
            sum(r.technophiles_RECEIPT_Cost) < technophiles_PREMIUM_PAYMENT_Premium_Payment_Amount
    ) as pr on c.technophiles_CUSTOMER_Cust_Id = pr.technophiles_PREMIUM_PAYMENT_Cust_Id
    join technophiles_INCIDENT_REPORT r on c.technophiles_CUSTOMER_Cust_Id = r.technophiles_INCIDENT_REPORT_Cust_Id
group by
    v.technophiles_VEHICLE_Cust_Id
having
    count(v.technophiles_VEHICLE_Vehicle_Id) > 1;


-- 5. Select all vehicles which have premium more than its vehicle number.
select
    c.technophiles_CUSTOMER_Cust_Id as cust_id,
    concat(
        c.technophiles_CUSTOMER_Cust_FName,
        " ",
        c.technophiles_CUSTOMER_Cust_LName
    ) as cust_name,
--     c.technophiles_CUSTOMER_Cust_Gender as cust_gender,
    v.technophiles_VEHICLE_Vehicle_Id as vehicle_id,
--     v.technophiles_VEHICLE_Vehicle_Manufacturer as vehicle_manufacturer,
    v.technophiles_VEHICLE_Vehicle_Type as vehicle_type,
    v.technophiles_VEHICLE_Vehicle_Number as vehicle_number,
    p.technophiles_PREMIUM_PAYMENT_Premium_Payment_Amount as premium_amount
from
    technophiles_CUSTOMER c
    join technophiles_VEHICLE v on c.technophiles_CUSTOMER_Cust_Id = v.technophiles_VEHICLE_Cust_Id
    join technophiles_PREMIUM_PAYMENT p on p.technophiles_PREMIUM_PAYMENT_Cust_Id = c.technophiles_CUSTOMER_Cust_Id
where
    v.technophiles_VEHICLE_Vehicle_Number <= p.technophiles_PREMIUM_PAYMENT_Premium_Payment_Amount;

-- 6. Retrieve Customer details whose 
-- Claim Amount is less than Coverage Amount and Claim Amount is greater than Sum of (CLAIM_SETTLEMENT_ID, VEHICLE_ID, CLAIM_ID, CUST_ID)
select
    c.technophiles_CUSTOMER_Cust_Id as cust_id,
    concat(c.technophiles_CUSTOMER_Cust_FName, " ", c.technophiles_CUSTOMER_Cust_LName) as cust_name,
    c.technophiles_CUSTOMER_Cust_Gender as cust_gender,
    cv.technophiles_COVERAGE_Coverage_Amount as coverage_amount,
    cl.technophiles_CLAIM_Claim_Amount as claim_amount,
    (
        cs.technophiles_CLAIM_SETTLEMENT_Claim_Settlement_Id + cs.technophiles_CLAIM_SETTLEMENT_Vehicle_Id + cs.technophiles_CLAIM_SETTLEMENT_Claim_Id + c.technophiles_CUSTOMER_Cust_Id
    ) as sum_of_ids
from
    technophiles_CUSTOMER c
    join technophiles_CLAIM cl on c.technophiles_CUSTOMER_Cust_Id = cl.technophiles_CLAIM_Cust_Id
    join technophiles_CLAIM_SETTLEMENT cs on (
        c.technophiles_CUSTOMER_Cust_Id = cs.technophiles_CLAIM_SETTLEMENT_Cust_Id
    )
    and (
        cl.technophiles_CLAIM_Claim_Id = cs.technophiles_CLAIM_SETTLEMENT_Claim_Id
    )
    join technophiles_COVERAGE cv on cs.technophiles_CLAIM_SETTLEMENT_Coverage_Id = cv.technophiles_COVERAGE_Coverage_Id
where
    cl.technophiles_CLAIM_Claim_Amount < cv.technophiles_COVERAGE_Coverage_Amount
    and cl.technophiles_CLAIM_Claim_Amount > (
        cs.technophiles_CLAIM_SETTLEMENT_Claim_Settlement_Id + cs.technophiles_CLAIM_SETTLEMENT_Vehicle_Id + cs.technophiles_CLAIM_SETTLEMENT_Claim_Id + c.technophiles_CUSTOMER_Cust_Id
    );