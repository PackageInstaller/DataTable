-- chunkname: @IQIGame\\UIExternalApi\\EndlessMazeRuneSelectUIApi.lua

EndlessMazeRuneSelectUIApi = BaseLangApi:Extend()

function EndlessMazeRuneSelectUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ToggleEffectLabel", self.GetToggleEffectLabel)
	self:RegisterApi("AbortBtnLabel", self.GetAbortBtnLabel)
	self:RegisterApi("AbortRewardLabel", self.GetAbortRewardLabel)
	self:RegisterApi("AbortNoRewardBtnText", self.GetAbortNoRewardBtnText)
end

function EndlessMazeRuneSelectUIApi:GetTitleText()
	return self:GetCfgText(2200057)
end

function EndlessMazeRuneSelectUIApi:GetToggleEffectLabel()
	return self:GetCfgText(2200058)
end

function EndlessMazeRuneSelectUIApi:GetAbortBtnLabel()
	return self:GetCfgText(2200063)
end

function EndlessMazeRuneSelectUIApi:GetAbortRewardLabel()
	return self:GetCfgText(2200062)
end

function EndlessMazeRuneSelectUIApi:GetAbortNoRewardBtnText()
	return self:GetCfgText(2200063)
end

EndlessMazeRuneSelectUIApi:Init()
