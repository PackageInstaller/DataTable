-- chunkname: @IQIGame\\UIExternalApi\\EndlessPlusSelectRuneUIApi.lua

EndlessPlusSelectRuneUIApi = BaseLangApi:Extend()

function EndlessPlusSelectRuneUIApi:Init()
	self:RegisterApi("RuneCellLevelText", self.GetRuneCellLevelText)
	self:RegisterApi("RuneCellQualityImage", self.GetRuneCellQualityImage)
	self:RegisterApi("RuneCellFeatureImage", self.GetRuneCellFeatureImage)
	self:RegisterApi("FilterBtnText", self.GetFilterBtnText)
	self:RegisterApi("RuneNumText", self.GetRuneNumText)
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("SuitItemBg", self.GetSuitItemBg)
	self:RegisterApi("SuitItemText", self.GetSuitItemText)
	self:RegisterApi("RuneSuitLabel", self.GetRuneSuitLabel)
	self:RegisterApi("FilterEquippedToggleText", self.GetFilterEquippedToggleText)
	self:RegisterApi("RuneCell_EquipToggle_Texts", self.GetRuneCell_EquipToggle_Texts)
end

function EndlessPlusSelectRuneUIApi:GetRuneCellLevelText(level)
	return "Lv." .. level
end

function EndlessPlusSelectRuneUIApi:GetRuneCellQualityImage(quality)
	if quality == 0 then
		return self:GetResUrl(1100100)
	elseif quality == 1 then
		return self:GetResUrl(1100101)
	elseif quality == 2 then
		return self:GetResUrl(1100102)
	elseif quality == 3 then
		return self:GetResUrl(1100103)
	end
end

function EndlessPlusSelectRuneUIApi:GetRuneCellFeatureImage(feature)
	if feature == 1 then
		return self:GetResUrl(1100110)
	elseif feature == 2 then
		return self:GetResUrl(1100111)
	elseif feature == 3 then
		return self:GetResUrl(1100112)
	elseif feature == 4 then
		return self:GetResUrl(1100113)
	end
end

function EndlessPlusSelectRuneUIApi:GetFilterBtnText()
	return self:GetCfgText(2000004)
end

function EndlessPlusSelectRuneUIApi:GetRuneNumText(filteredNum, originalNum, isFilterMode)
	if isFilterMode then
		return self:GetCfgText(2200043) .. filteredNum .. "/" .. originalNum
	else
		return self:GetCfgText(2200043) .. originalNum
	end
end

function EndlessPlusSelectRuneUIApi:GetTitleText()
	return self:GetCfgText(2200010)
end

function EndlessPlusSelectRuneUIApi:GetSuitItemBg(type)
	return self:GetResUrl(1100114)
end

function EndlessPlusSelectRuneUIApi:GetSuitItemText(type, name, num)
	if type == 1 then
		return string.format("%s(%s)", name, num)
	else
		return string.format(self:GetCfgText(2200077), num)
	end
end

function EndlessPlusSelectRuneUIApi:GetRuneSuitLabel()
	return self:GetCfgText(2200061)
end

function EndlessPlusSelectRuneUIApi:GetFilterEquippedToggleText()
	return self:GetCfgText(3410961)
end

function EndlessPlusSelectRuneUIApi:GetRuneCell_EquipToggle_Texts()
	return {
		self:GetCfgText(3410962),
		self:GetCfgText(3410963)
	}
end

EndlessPlusSelectRuneUIApi:Init()
