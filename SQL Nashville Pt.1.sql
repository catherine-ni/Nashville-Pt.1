
-- Standerdize Date Format

select SaleDate
from PortfolioProgect.dbo.nashvillehousing

update PortfolioProgect.dbo.nashvillehousing
set SaleDate = convert(date, SaleDate)

--When update doesn't work for some reason just add a new row and then convert

Alter table nashvillehousing
add SaleDate1 date

Update nashvillehousing
set SaleDate1 = convert(date, saledate)

select Saledate1
from PortfolioProgect.dbo.nashvillehousing


--Add Data to the Property Address which are Null

select *
from PortfolioProgect..nashvillehousing
--where propertyaddress is null
order by parcelID

---which means, if ParcelID is the same then property address is the same. 
---Populate the NULL address with same parcelID address
---Use Self-join

select *
from PortfolioProgect..nashvillehousing a
join PortfolioProgect..nashvillehousing b
on a.parcelid = b.parcelid
and a.uniqueid <> b.uniqueid

select a.parcelid, a.propertyaddress, b.parcelid, b.propertyaddress, isnull(a.propertyaddress, b.propertyaddress)
from PortfolioProgect..nashvillehousing a
join PortfolioProgect..nashvillehousing b
on a.parcelid = b.parcelid
and a.uniqueid <> b.uniqueid
where a.propertyaddress is null

Update a
set propertyaddress = isnull(a.propertyaddress, b.propertyaddress)
from PortfolioProgect..nashvillehousing a
join PortfolioProgect..nashvillehousing b
on a.parcelid = b.parcelid
and a.uniqueid <> b.uniqueid
where a.propertyaddress is null