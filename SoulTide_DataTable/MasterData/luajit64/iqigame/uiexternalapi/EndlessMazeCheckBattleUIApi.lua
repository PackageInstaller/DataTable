-- chunkname: @IQIGame\\UIExternalApi\\EndlessMazeCheckBattleUIApi.lua

EndlessMazeCheckBattleUIApi = BaseLangApi:Extend()

function EndlessMazeCheckBattleUIApi:Init()
	self:RegisterApi("TitleText1", self.GetTitleText1)
	self:RegisterApi("TitleText2", self.GetTitleText2)
	self:RegisterApi("ContentText", self.GetContentText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("CancelBtnText", self.GetCancelBtnText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("IgnoreToggleText", self.GetIgnoreToggleText)
end

function EndlessMazeCheckBattleUIApi:GetTitleText1()
	return self:GetCfgText(2200005)
end

function EndlessMazeCheckBattleUIApi:GetTitleText2()
	return self:GetCfgText(2200006)
end

function EndlessMazeCheckBattleUIApi:GetContentText()
	return self:GetCfgText(2200007)
end

function EndlessMazeCheckBattleUIApi:GetTipText(chapterType)
	return self:GetCfgText(2200008)
end

function EndlessMazeCheckBattleUIApi:GetCancelBtnText()
	return self:GetCfgText(2200009)
end

function EndlessMazeCheckBattleUIApi:GetConfirmBtnText()
	return self:GetCfgText(2200005)
end

function EndlessMazeCheckBattleUIApi:GetIgnoreToggleText()
	return self:GetCfgText(2100900)
end

EndlessMazeCheckBattleUIApi:Init()
