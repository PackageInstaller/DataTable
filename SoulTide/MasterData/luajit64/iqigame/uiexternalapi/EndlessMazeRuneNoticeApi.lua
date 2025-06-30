-- chunkname: @IQIGame\\UIExternalApi\\EndlessMazeRuneNoticeApi.lua

EndlessMazeRuneNoticeApi = BaseLangApi:Extend()

function EndlessMazeRuneNoticeApi:Init()
	self:RegisterApi("GetTitleText", self.GetGetTitleText)
	self:RegisterApi("UnsealTitleText", self.GetUnsealTitleText)
	self:RegisterApi("LevelUpTitleText", self.GetLevelUpTitleText)
	self:RegisterApi("GrowUpTitleText", self.GetGrowUpTitleText)
	self:RegisterApi("SplitTitleText", self.GetSplitTitleText)
	self:RegisterApi("TargetText", self.GetTargetText)
	self:RegisterApi("FinishTargetLabelText", self.GetFinishTargetLabelText)
	self:RegisterApi("LevelText", self.GetLevelText)
end

function EndlessMazeRuneNoticeApi:GetGetTitleText()
	return self:GetCfgText(2200047), self:GetCfgText(1320001)
end

function EndlessMazeRuneNoticeApi:GetUnsealTitleText()
	return self:GetCfgText(2200048), self:GetCfgText(2200049)
end

function EndlessMazeRuneNoticeApi:GetLevelUpTitleText()
	return self:GetCfgText(2200050), self:GetCfgText(1314416)
end

function EndlessMazeRuneNoticeApi:GetGrowUpTitleText()
	return self:GetCfgText(2200051), self:GetCfgText(2200052)
end

function EndlessMazeRuneNoticeApi:GetSplitTitleText()
	return self:GetCfgText(2200053), self:GetCfgText(2200054)
end

function EndlessMazeRuneNoticeApi:GetTargetText(text, finishNum, targetNum)
	return text .. "： " .. finishNum .. "/" .. targetNum
end

function EndlessMazeRuneNoticeApi:GetFinishTargetLabelText()
	return self:GetCfgText(2200046)
end

function EndlessMazeRuneNoticeApi:GetLevelText(name, level, isMaxLevel)
	if isMaxLevel then
		return name .. self:GetCfgText(1015060) .. level .. self:GetCfgText(2200045)
	else
		return name .. self:GetCfgText(1015060) .. level
	end
end

EndlessMazeRuneNoticeApi:Init()
