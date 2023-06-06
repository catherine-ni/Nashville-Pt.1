
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

--Breaking out Address into Individual Colums (Address, City, State)

Select  SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress) -1 ) as StreetAddress,
SUBSTRING(propertyaddress, charindex(',', propertyaddress) +1 , Len(propertyaddress)) as City
from PortfolioProgect..NashvilleHousing

--Update table becasue you can't separate an already existing colum into 2, you need to make 2 new colums

Alter table NashvilleHousing
add StreetAddress nvarchar(255), City nvarchar(255)

Update nashvillehousing
set StreetAddress = SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress) -1 ),
City = SUBSTRING(propertyaddress, charindex(',', propertyaddress) +1 , Len(propertyaddress))

--Easier way to do it is PARSENAME

Select OwnerAddress
from PortfolioProgect..NashvilleHousing

select Parsename (Replace(owneraddress, ',', '.'),3) as Street,
Parsename (Replace(owneraddress, ',', '.'),2) as City,
Parsename (Replace(owneraddress, ',', '.'),1) as State
from PortfolioProgect..NashvilleHousing

Alter table NashvilleHousing
add OwnerStreetAddress nvarchar(255), OwnerCity nvarchar(255), OwnerState nvarchar(255)

Update nashvillehousing
set OwnerStreetAddress = Parsename (Replace(owneraddress, ',', '.'),3) as Street,
OwnerCity = Parsename (Replace(owneraddress, ',', '.'),2) as City,
OwnerState = Parsename (Replace(owneraddress, ',', '.'),1) as State

--Change Y and N to Yes and No

select Distinct(SoldAsVacant), count(soldasvacant)
from PortfolioProgect..NashvilleHousing
group by SoldAsVacant
order by 2

select SoldAsVacant,
case
  when soldasvacant = 'Y' then 'Yes'
  when soldasvacant = 'N' then 'No'
  Else Soldasvacant
end
from PortfolioProgect..NashvilleHousing
group by SoldAsVacant

update PortfolioProgect..NashvilleHousing
set soldasvacant = case
  when soldasvacant = 'Y' then 'Yes'
  when soldasvacant = 'N' then 'No'
  Else Soldasvacant
end

--Remove Duplicates