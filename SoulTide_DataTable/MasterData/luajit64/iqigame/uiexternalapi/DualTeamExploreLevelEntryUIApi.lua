-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreLevelEntryUIApi.lua

DualTeamExploreLevelEntryUIApi = BaseLangApi:Extend()

function DualTeamExploreLevelEntryUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("EasyModeToggleTests", self.GetEasyModeToggleTests)
	self:RegisterApi("ShopBtnText", self.GetShopBtnText)
	self:RegisterApi("LevelCellIndexText", self.GetLevelCellIndexText)
	self:RegisterApi("LevelCellOffPlotViewText", self.GetLevelCellOffPlotViewText)
	self:RegisterApi("LevelCellOffUnlockConditionText", self.GetLevelCellOffUnlockConditionText)
	self:RegisterApi("LevelCell_BossView_MainWeakLabel", self.GetLevelCell_BossView_MainWeakLabel)
end

function DualTeamExploreLevelEntryUIApi:GetTitleText(openCount)
	return self:GetCfgText(2000052)
end

function DualTeamExploreLevelEntryUIApi:GetEasyModeToggleTests()
	return {
		self:GetCfgText(3410002),
		self:GetCfgText(3410003)
	}
end

function DualTeamExploreLevelEntryUIApi:GetShopBtnText(openCount)
	if openCount == 1 then
		return self:GetCfgText(2000055)
	elseif openCount == 2 then
		return self:GetCfgText(2000073)
	elseif openCount == 3 then
		return self:GetCfgText(2000055)
	end

	return ""
end

function DualTeamExploreLevelEntryUIApi:GetLevelCellIndexText(index)
	if index < 10 then
		return "0" .. index
	else
		return tostring(index)
	end
end

function DualTeamExploreLevelEntryUIApi:GetLevelCellOffPlotViewText()
	return self:GetCfgText(3410004)
end

function DualTeamExploreLevelEntryUIApi:GetLevelCellOffUnlockConditionText(preLevelName, openTime, currentTime, closeTime, conditionName)
	if preLevelName ~= nil then
		return string.format(self:GetCfgText(3410005), preLevelName)
	end

	if openTime ~= nil and currentTime < openTime then
		return string.format("%s\r\n" .. "<size=20><color=red>" .. self:GetCfgText(3410006) .. "</color></size>", getDateTimeMText(openTime))
	end

	if closeTime ~= nil and closeTime < currentTime then
		return string.format("%s\r\n" .. "<size=20><color=red>" .. self:GetCfgText(3410007) .. "</color></size>", getDateTimeMText(closeTime))
	end

	if conditionName ~= nil then
		return conditionName
	end

	return "???"
end

function DualTeamExploreLevelEntryUIApi:GetLevelCell_BossView_MainWeakLabel()
	return self:GetCfgText(3410009)
end

DualTeamExploreLevelEntryUIApi:Init()
