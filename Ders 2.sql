/*
DML (Data Manupulation Language)
	-Select
	-Insert
	-Update
	-Delete
*/
select * from Employees

select [FirstName],[LastName] from Employees

select E.FirstName,E.LastName,E.BirthDate,E.City  From Employees E

select e.FirstName,e.LastName,e.Country from Employees e
go
SELECT * FROM Employees
Go
Select E.* From Employees E
Go
Select * From Employees E Where E.TitleOfCourtesy = 'Mr.'
Go
Select * From Employees E Where E.Country='UK'
Go
Select * From Employees Where Country='UK'
Go
Select * From Products
Go
Select * From Products P Where P.CategoryID=1
Go
Select * From Products P Where P.SupplierID In(7,10,23)
Go
Select * From Products P Where P.SupplierID =7 OR P.SupplierID =10 OR P.SupplierID=23
Go
Select * From Products P Where P.UnitPrice>=20 and P.UnitPrice<=35
Go
Select * From Products P Where P.UnitPrice Between 20 And 35
Go
Select * From Products P Where P.ProductName Like 'c%'
Go
Select * From Products P Where P.ProductName Like '_h%'
Go
Select AVG(P.UnitPrice) From Products P
Go
Select SUM(P.UnitPrice) AS 'Toplam' From Products P Where P.UnitPrice Between 5 AND 45
Go
/*Tüm ürünler için ürünlerin toplam fiyatını listeleyin. */
Select 
	P.ProductName,
	P.UnitPrice,
	P.UnitsInStock,
	(P.UnitPrice*P.UnitsInStock) TotalPrice 
From Products P 
Go
Select * From Products P Order By P.ProductName ASC
Go
Select * From Products P Order By P.ProductName DESC
Go
/* İsminin baş harfi a soyadının son harfi r olan çalışanları listeleyin. */

Select * 
From Employees E 
Where E.FirstName Like 'a%' and E.LastName Like '%r'

/*c ile başlayan ürünleri stok miktarına göre artan bir şekilde listeleyin.*/

Select * 
From Products P
Where P.ProductName Like 'c%'
Order By P.UnitsInStock

--Ürünler tablosundan tüm ürünlerin  Ürün adı, Birim fiyat, Stok, Toplam Fiyat, Kdv Tutarı, Kdvli Toplam Fiyat bilgilerini stok miktarına göre azalan bir şekilde listeleyin

Select 
	P.ProductName,
	P.UnitPrice,
	P.UnitsInStock,
	(P.UnitPrice*P.UnitsInStock) TotalPrice,
	(P.UnitPrice*0.18) Kdv,
	(P.UnitPrice+P.UnitPrice*0.18) TotalPriceKdv
From Products P


--Tüm ürünleri içerisinden stok miktarı ortalama stok miktarının üstünde olan ürünleri listeleyin.

Select * 
FRom Products P
Where P.UnitsInStock > (Select AVG(UnitsInStock) From Products)

/*
	Stok miktarı 
		0 olan ürünler için Durum adında bir sütun açarak Stok Yok,
		0-15 arasında ise Stok Sınırlı
		16-50 arasında ise Stok Takviye
		50 'den büyük ise Satışta
	ifadelerini yazan bu ifadeyle birlikte ürünlerin adını, birim fiyatını, stok miktarını listeleyen SQL ifadesini yazalaım.
*/

Select 
	P.ProductName,
	P.UnitPrice,
	P.UnitsInStock,
	'Durum' =
		Case
			When P.UnitsInStock = 0 Then 'Stok yok'
			When P.UnitsInStock >0 and P.UnitsInStock<=15 Then 'Sınırlı'
			When P.UnitsInStock >=16 and P.UnitsInStock<=50 Then 'Takviye'
			When P.UnitsInStock>50 Then 'Satışta'
		End
From Products P

/*
Ürünler için fiyatı 
	0-15 arasında olanlar için %5
	15-35 arasında olanlar için %15
	35-75 arasında olanlar için %20
	75 den büyük olanlar için %25 oranında indirim uygulayın.
	Ürünlerin adını, birim fiyatını ve indirimli yeni fiyatı listeleyin.
*/

Select 
	P.ProductName,
	P.UnitPrice,
	P.UnitsInStock,
	'İnidirimli Fiyat' =
		Case
			When P.UnitPrice > 0 and P.UnitPrice <= 15 Then P.UnitPrice-P.UnitPrice*0.05
			When P.UnitPrice > 15 and P.UnitPrice <= 35 Then P.UnitPrice-P.UnitPrice*0.15
			When P.UnitPrice > 35 and P.UnitPrice <= 75 Then P.UnitPrice-P.UnitPrice*0.20
			When P.UnitPrice>75 Then P.UnitPrice-P.UnitPrice*0.25
		End
From Products P
Order By P.UnitPrice Desc