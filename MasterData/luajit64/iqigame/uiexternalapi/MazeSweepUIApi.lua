-- chunkname: @IQIGame\\UIExternalApi\\MazeSweepUIApi.lua

MazeSweepUIApi = BaseLangApi:Extend()

function MazeSweepUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("CloseBtnText", self.GetCloseBtnText)
	self:RegisterApi("SweepBtnText", self.GetSweepBtnText)
	self:RegisterApi("ResultText", self.GetResultText)
end

function MazeSweepUIApi:GetTitleText()
	return self:GetCfgText(2300062)
end

function MazeSweepUIApi:GetCloseBtnText()
	return self:GetCfgText(1105001)
end

function MazeSweepUIApi:GetSweepBtnText()
	return self:GetCfgText(2300063)
end

function MazeSweepUIApi:GetResultText(count)
	return self:GetCfgText(2300064) .. count .. self:GetCfgText(2300065)
end

MazeSweepUIApi:Init()
