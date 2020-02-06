/*
	DML(Data Manupulation Language)
		-SELECT
		-INSERT
		-UPDATE
		-DELETE
*/

/*
1. Çalışanlar(Employees) tablosoundan tüm kayıtları listeleyin.
*/
Select * From Employees
Go
/*
2. Çalışanlar tablosoundan tüm çalışanların ad ve soyad bilgilerini listeleyin. 
*/
Select E.FirstName,E.LastName From Employees E
Go
Select E.FirstName,E.LastName,E.BirthDate,E.City,E.Country From Employees E
Go
/*
3. Tüm çalışanları ad alanına göre alfabetik sıralayınız.
*/
SElect E.* From Employees E Order By E.FirstName
Go
/*
4. Tüm çalışanları ad alanına göre alfabetik tersten z-a sıralayınız.
*/
SElect E.* From Employees E Order By E.FirstName Desc
Go
/*
5.Amerika da olan çalışanlarımızı listeleyelim.
*/
Select E.* 
From Employees E
Where E.Country='USA'
Go
/*
6. Amerikada yer alan Seatle şehrinde yaşayan çalışanları listeleyin.
*/
Select E.* 
From Employees E
Where E.Country='USA' AND E.City='Seattle'
Go
Select * From Products
Go
/*
7. Kategori numarası 3,5 ve 7 olan tüm ürünleri listeleyelim.
*/
Select P.* 
From Products P
Where P.CategoryID = 3 OR P.CategoryID = 5 OR P.CategoryID = 7

Select P.*
From Products P
Where P.CategoryID IN(3,5,7)
Go
/*
8. Ürün adı T ile başlayan tüm ürünlerin tüm bilgilerini listeleyelim.
*/
Select 
	P.*
From Products P
Where P.ProductName Like 'T%'
Go
/*
9. Ürün adının ikinci harfi o olan tüm ürünlerin tüm bilgilerini listeleyelim.
*/
Select 
	P.*
From Products P
Where P.ProductName Like '_o%'
Go
/*
10. Son harfi u olan tüm ürünleri listeleyelim.
*/
Select 
	P.*
From Products P
Where P.ProductName Like '%u'
Go
/*
11.Kategori adının ikinci harfi r olan ürünlerin adlarını, birim fiyatlarını, stok miktarlarını ve kategori numaralarını listeleyelim.
*/
Select 
	P.ProductName,
	P.UnitsInStock,
	P.CategoryID
From Products P
Where P.CategoryID IN(Select 
						C.CategoryID 
					  From Categories C 
					  Where C.CategoryName Like '_r%')
Go
Select * From Suppliers
/*
12. Tedarikçi firması Alman olan ürünlerin adlarını, birim fiyatlarını ve stok miktarlarını listeleyelim.
*/

Select
	P.ProductName,
	P.UnitPrice,
	P.UnitsInStock
From Products P
Where P.SupplierID IN(Select S.SupplierID 
					  From Suppliers S
					  Where S.Country='Germany')
Go
/*
13. Tüm ürünlerin ortalama fiyatını listeleyin.
*/
Select 
	AVG(P.UnitPrice) AS 'Ortalama Fiyat'
From Products P
Select 
	AVG(P.UnitPrice) 'Ortalama Fiyat'
From Products P

Select 
	AVG(P.UnitPrice) [Ortalama Fiyat]
From Products P

Select 
	AVG(P.UnitPrice) OrtalamaFiyat
From Products P
Go
/*
14. Tüm ürünlerin toplam stok miktarını bulunuz.
*/
Select 
	SUM(P.UnitsInStock) [Toplam Stok Miktarı]  
From Products P
Go
/*
15.Ürünleri tablosunda toplam kaç kayıt var. Bulunuz.
*/
Select COUNT(*) 
From Products
Go
/*
16. Tüm ürünler içinden birim fiyatı en büyük olan ürünü listeleyin.
*/
Select 
	MAX(P.UnitPrice)
From Products P
Go
/*
16. Tüm ürünler içinden birim fiyatı en küçük olan ürünü listeleyin.
*/
Select 
	MIN(P.UnitPrice)
From Products P
Go
/*
17. Tüm ürünlerin içinden stok miktarı ortalama stok miktarından büyük olan ürünleri listeleyin.
*/
Select 
* 
From Products P1
Where P1.UnitsInStock > (Select 
							AVG(P2.UnitsInStock)
						 From Products P2)
Order By P1.UnitsInStock
Go
/*
18.
	Stok miktarı 
		0 olan ürünler için Durum adında bir sütun açarak Stok Yok,
		0-15 arasında ise  Sınırlı
		16-50 arasında ise  Takviye
		50 'den büyük ise Satışta
	ifadelerini yazan, bu ifadeyle birlikte ürünlerin adını, birim fiyatını, stok miktarını listeleyen SQL ifadesini yazalım.
*/
Select 
	P.ProductName,
	P.UnitPrice,
	P.UnitsInStock,
	'Durum' = 
	(   Case
			When P.UnitsInStock = 0 Then 'Stok Yok'
			When P.UnitsInStock >0 AND P.UnitsInStock <=15 Then 'Sınırlı'
			When P.UnitsInStock >=16 AND P.UnitsInStock <=50 Then 'Takviye'
			When P.UnitsInStock >50 Then 'Satışta'
		End	)
From Products P Order By P.UnitsInStock Desc
Go
/*
19. 
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
	'Durum' = 
	(   Case
			When P.UnitPrice >= 0 and P.UnitPrice < 15 Then P.UnitPrice-P.UnitPrice*0.05
			When P.UnitPrice >=15 and P.UnitPrice < 35 Then P.UnitPrice-P.UnitPrice*0.15
			When P.UnitPrice >=35 and P.UnitPrice < 75 Then P.UnitPrice-P.UnitPrice*0.20
			When P.UnitPrice >= 75 Then P.UnitPrice-P.UnitPrice*0.25
		End	)
From Products P Order By P.UnitPrice Desc