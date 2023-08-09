create table Shop
(
    Name nvarchar2(20),
    cost number(3)
);

create view ShopView as select Name from Shop;

CREATE TABLE Products
(
    NameProduct nvarchar2(20),
    Cost number(3)
)TABLESPACE KOD_QDATA;

select * from  PRODUCTS;