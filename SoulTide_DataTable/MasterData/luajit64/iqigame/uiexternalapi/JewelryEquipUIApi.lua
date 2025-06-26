-- chunkname: @IQIGame\\UIExternalApi\\JewelryEquipUIApi.lua

JewelryEquipUIApi = BaseLangApi:Extend()

function JewelryEquipUIApi:Init()
	self:RegisterApi("JewelryQualityBg", self.GetJewelryQualityBg)
end

function JewelryEquipUIApi:GetJewelryQualityBg(quality)
	if quality == 1 then
		return self:GetResUrl(2001101)
	elseif quality == 2 then
		return self:GetResUrl(2001102)
	elseif quality == 3 then
		return self:GetResUrl(2001103)
	elseif quality == 4 then
		return self:GetResUrl(2001104)
	elseif quality == 5 then
		return self:GetResUrl(2001105)
	end

	return self:GetResUrl(2001101)
end

JewelryEquipUIApi:Init()
