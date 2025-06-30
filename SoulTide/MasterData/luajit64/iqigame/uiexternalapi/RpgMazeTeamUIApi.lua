-- chunkname: @IQIGame\\UIExternalApi\\RpgMazeTeamUIApi.lua

RpgMazeTeamUIApi = BaseLangApi:Extend()

function RpgMazeTeamUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("LvText", self.GetLvText)
	self:RegisterApi("ExpText", self.GetExpText)
	self:RegisterApi("SubPanelToggleNameTexts", self.GetSubPanelToggleNameTexts)
	self:RegisterApi("SuitTitleText", self.GetSuitTitleText)
	self:RegisterApi("SuitEffectDescText", self.GetSuitEffectDescText)
	self:RegisterApi("PosToggleText", self.GetPosToggleText)
end

function RpgMazeTeamUIApi:GetTitleText()
	return self:GetCfgText(2300066)
end

function RpgMazeTeamUIApi:GetLvText(lv)
	return tostring(lv)
end

function RpgMazeTeamUIApi:GetExpText(exp, maxExp)
	return string.format("%s/%s", exp, maxExp)
end

function RpgMazeTeamUIApi:GetSubPanelToggleNameTexts()
	return {
		self:GetCfgText(3100301),
		self:GetCfgText(3100302),
		self:GetCfgText(3100303)
	}
end

function RpgMazeTeamUIApi:GetSuitTitleText(name)
	return self:GetCfgText(3100304) .. name .. "(3/3):"
end

function RpgMazeTeamUIApi:GetSuitEffectDescText(desc, isTrigger)
	return desc
end

function RpgMazeTeamUIApi:GetPosToggleText(type)
	if type == 1 then
		return self:GetCfgText(3100305)
	else
		return self:GetCfgText(3100306)
	end
end

RpgMazeTeamUIApi:Init()
