-- chunkname: @IQIGame\\UIExternalApi\\EndlessMazeRuneMainUIApi.lua

EndlessMazeRuneMainUIApi = BaseLangApi:Extend()

function EndlessMazeRuneMainUIApi:Init()
	self:RegisterApi("RuneCellLevelText", self.GetRuneCellLevelText)
	self:RegisterApi("RuneCellQualityImage", self.GetRuneCellQualityImage)
	self:RegisterApi("RuneCellFeatureImage", self.GetRuneCellFeatureImage)
	self:RegisterApi("FilterBtnText", self.GetFilterBtnText)
	self:RegisterApi("RuneNumText", self.GetRuneNumText)
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("SuitItemBg", self.GetSuitItemBg)
	self:RegisterApi("SuitItemText", self.GetSuitItemText)
	self:RegisterApi("RuneSuitLabel", self.GetRuneSuitLabel)
end

function EndlessMazeRuneMainUIApi:GetRuneCellLevelText(level)
	return "Lv." .. level
end

function EndlessMazeRuneMainUIApi:GetRuneCellQualityImage(quality)
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

function EndlessMazeRuneMainUIApi:GetRuneCellFeatureImage(feature)
	if feature == 1 then
		return self:GetResUrl(1100110)
	elseif feature == 2 then
		return self:GetResUrl(1100111)
	elseif feature == 3 then
		return self:GetResUrl(1100112)
	elseif feature == 4 then
		return self:GetResUrl(1100113)
	elseif feature == 5 then
		return nil
	end
end

function EndlessMazeRuneMainUIApi:GetFilterBtnText()
	return self:GetCfgText(2000004)
end

function EndlessMazeRuneMainUIApi:GetRuneNumText(filteredNum, originalNum, isFilterMode)
	if isFilterMode then
		return self:GetCfgText(2200043) .. filteredNum .. "/" .. originalNum
	else
		return self:GetCfgText(2200043) .. originalNum
	end
end

function EndlessMazeRuneMainUIApi:GetTitleText()
	return self:GetCfgText(2200010)
end

function EndlessMazeRuneMainUIApi:GetSuitItemBg(type)
	return self:GetResUrl(1100114)
end

function EndlessMazeRuneMainUIApi:GetSuitItemText(type, name, num)
	if type == 1 then
		return string.format("%s(%s)", name, num)
	else
		return string.format(self:GetCfgText(2200077), num)
	end
end

function EndlessMazeRuneMainUIApi:GetRuneSuitLabel()
	return self:GetCfgText(2200061)
end

EndlessMazeRuneMainUIApi:Init()
