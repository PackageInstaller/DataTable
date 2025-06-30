-- chunkname: @IQIGame\\UIExternalApi\\EndlessMazeRuneReplaceUIApi.lua

EndlessMazeRuneReplaceUIApi = BaseLangApi:Extend()

function EndlessMazeRuneReplaceUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("CancelBtnText", self.GetCancelBtnText)
end

function EndlessMazeRuneReplaceUIApi:GetTitleText()
	return self:GetCfgText(2200055)
end

function EndlessMazeRuneReplaceUIApi:GetTipText()
	return self:GetCfgText(2200056)
end

function EndlessMazeRuneReplaceUIApi:GetConfirmBtnText()
	return self:GetCfgText(2000002)
end

function EndlessMazeRuneReplaceUIApi:GetCancelBtnText()
	return self:GetCfgText(2000012)
end

EndlessMazeRuneReplaceUIApi:Init()
