-- chunkname: @IQIGame\\UIExternalApi\\EndlessMazeEntryUIApi.lua

EndlessMazeEntryUIApi = BaseLangApi:Extend()

function EndlessMazeEntryUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("LeftCountText", self.GetLeftCountText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("BtnTipDes", self.GetBtnTipDes)
end

function EndlessMazeEntryUIApi:GetBtnTipDes()
	return self:GetCfgText(2200082)
end

function EndlessMazeEntryUIApi:GetTitleText()
	return self:GetCfgText(2200001)
end

function EndlessMazeEntryUIApi:GetLeftCountText(leftCount)
	return string.format(self:GetCfgText(2200003) .. ": %s/5", leftCount)
end

function EndlessMazeEntryUIApi:GetTipText()
	return self:GetCfgText(2100008)
end

function EndlessMazeEntryUIApi:GetConfirmBtnText()
	return self:GetCfgText(1213003)
end

EndlessMazeEntryUIApi:Init()
