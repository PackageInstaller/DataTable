-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyBagUIApi.lua

MonsterAcademyBagUIApi = BaseLangApi:Extend()

function MonsterAcademyBagUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ItemNumText", self.GetItemNumText)
	self:RegisterApi("EmptyViewText", self.GetEmptyViewText)
	self:RegisterApi("goType", self.GetType)
	self:RegisterApi("BtnItemUseLabel", self.GetBtnItemUseLabel)
	self:RegisterApi("ItemNum", self.GetItemNum)
	self:RegisterApi("BtnUseLabel", self.GetBtnUseLabel)
	self:RegisterApi("QualityBackgroundPath", self.GetQualityBackgroundPath)
end

function MonsterAcademyBagUIApi:GetQualityBackgroundPath(quality)
	if quality == 0 then
		return self:GetResUrl(2400010)
	elseif quality == 1 then
		return self:GetResUrl(2400011)
	elseif quality == 2 then
		return self:GetResUrl(2400012)
	elseif quality == 3 then
		return self:GetResUrl(2400013)
	elseif quality == 4 then
		return self:GetResUrl(2400014)
	elseif quality == 5 then
		return self:GetResUrl(2400015)
	end

	return self:GetResUrl(2400010)
end

function MonsterAcademyBagUIApi:GetBtnUseLabel()
	return self:GetCfgText(3420131)
end

function MonsterAcademyBagUIApi:GetItemNum(num)
	return string.format(self:GetCfgText(3420132), num)
end

function MonsterAcademyBagUIApi:GetBtnItemUseLabel(itemType)
	return self:GetCfgText(1015702)
end

function MonsterAcademyBagUIApi:GetType(type)
	if type == 1 then
		return self:GetCfgText(3420133)
	elseif type == 2 then
		return self:GetCfgText(3420134)
	elseif type == 3 then
		return self:GetCfgText(3420135)
	end

	return ""
end

function MonsterAcademyBagUIApi:GetEmptyViewText()
	return self:GetCfgText(3420136)
end

function MonsterAcademyBagUIApi:GetTitleText()
	return self:GetCfgText(3420081)
end

function MonsterAcademyBagUIApi:GetItemNumText()
	return "123456"
end

MonsterAcademyBagUIApi:Init()
