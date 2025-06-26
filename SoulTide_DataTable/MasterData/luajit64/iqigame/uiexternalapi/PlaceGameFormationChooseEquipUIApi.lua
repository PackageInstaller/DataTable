-- chunkname: @IQIGame\\UIExternalApi\\PlaceGameFormationChooseEquipUIApi.lua

PlaceGameFormationChooseEquipUIApi = BaseLangApi:Extend()

function PlaceGameFormationChooseEquipUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("EquipPrefabBtnText", self.GetEquipPrefabBtnText)
	self:RegisterApi("UnloadAllBtnText", self.GetUnloadAllBtnText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("GoSoulBtnText", self.GetGoSoulBtnText)
	self:RegisterApi("GoEquipText", self.GetGoEquipText)
	self:RegisterApi("EquipEmptyViewText", self.GetEquipEmptyViewText)
	self:RegisterApi("TextWear", self.GetTextWear)
	self:RegisterApi("EquipClassIcon", self.GetEquipClassIcon)
	self:RegisterApi("goCellFrame", self.GetCellFrame)
	self:RegisterApi("goCellBg", self.GetCellBg)
	self:RegisterApi("goCellMoon", self.GetCellMoon)
end

function PlaceGameFormationChooseEquipUIApi:GetCellMoon(isSpecial, quality)
	if isSpecial then
		return self:GetResUrl(1301001)
	elseif quality == 1 then
		return self:GetResUrl(1301002)
	elseif quality == 2 then
		return self:GetResUrl(1301003)
	elseif quality == 3 then
		return self:GetResUrl(1301004)
	elseif quality == 4 then
		return self:GetResUrl(1301005)
	elseif quality == 5 then
		return self:GetResUrl(1301006)
	end
end

function PlaceGameFormationChooseEquipUIApi:GetCellBg(quality)
	if quality == 1 then
		return self:GetResUrl(1301007)
	elseif quality == 2 then
		return self:GetResUrl(1301008)
	elseif quality == 3 then
		return self:GetResUrl(1301009)
	elseif quality == 4 then
		return self:GetResUrl(1301010)
	elseif quality == 5 then
		return self:GetResUrl(1301011)
	end
end

function PlaceGameFormationChooseEquipUIApi:GetCellFrame(isSpecial, quality)
	if isSpecial then
		return self:GetResUrl(1301012)
	elseif quality == 1 then
		return self:GetResUrl(1301013)
	elseif quality == 2 then
		return self:GetResUrl(5100201)
	elseif quality == 3 then
		return self:GetResUrl(5100202)
	elseif quality == 4 then
		return self:GetResUrl(5100203)
	elseif quality == 5 then
		return self:GetResUrl(5100204)
	end
end

function PlaceGameFormationChooseEquipUIApi:GetEquipClassIcon(type)
	if type == 1 then
		return UIGlobalApi.GetImagePath("/Common/ComImage/SoulSkillTag_shuchu_Black.png")
	elseif type == 2 then
		return UIGlobalApi.GetImagePath("/Common/ComImage/SoulSkillTag_tanke_Black.png")
	elseif type == 3 then
		return UIGlobalApi.GetImagePath("/Common/ComImage/SoulSkillTag_zhiliao_Black.png")
	end

	return UIGlobalApi.GetImagePath("/Common/ComImage/SoulSkillTag_shuchu_Black.png")
end

function PlaceGameFormationChooseEquipUIApi:GetTextWear(isWear)
	if isWear then
		return self:GetCfgText(1001028)
	else
		return self:GetCfgText(1001015)
	end
end

function PlaceGameFormationChooseEquipUIApi:GetEquipEmptyViewText()
	return self:GetCfgText(3820016)
end

function PlaceGameFormationChooseEquipUIApi:GetGoEquipText()
	return self:GetCfgText(3820011)
end

function PlaceGameFormationChooseEquipUIApi:GetGoSoulBtnText()
	return self:GetCfgText(3820010)
end

function PlaceGameFormationChooseEquipUIApi:GetConfirmBtnText()
	return self:GetCfgText(1214306)
end

function PlaceGameFormationChooseEquipUIApi:GetUnloadAllBtnText()
	return self:GetCfgText(3820012)
end

function PlaceGameFormationChooseEquipUIApi:GetEquipPrefabBtnText()
	return self:GetCfgText(3820013)
end

function PlaceGameFormationChooseEquipUIApi:GetTitleText()
	return self:GetCfgText(3820015)
end

PlaceGameFormationChooseEquipUIApi:Init()
