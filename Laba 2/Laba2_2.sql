create table Shop
(
    Name nvarchar2(20),
    cost number(3)
);

create view ShopView as select Name from Shop;

DROP  VIEW  ShopView;

CREATE TABLE Products
(
    NameProduct nvarchar2(20),
    Cost number(3)
) TABLESPACE KOD_QDATA;


drop table  Products;

select * from  PRODUCTS;
