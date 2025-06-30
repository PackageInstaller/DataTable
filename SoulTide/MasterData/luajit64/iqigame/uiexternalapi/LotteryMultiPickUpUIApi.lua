-- chunkname: @IQIGame\\UIExternalApi\\LotteryMultiPickUpUIApi.lua

LotteryMultiPickUpUIApi = BaseLangApi:Extend()

function LotteryMultiPickUpUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("TipText", self.GetTipText)
end

function LotteryMultiPickUpUIApi:GetTitleText()
	return self:GetCfgText(1317501)
end

function LotteryMultiPickUpUIApi:GetConfirmBtnText()
	return self:GetCfgText(1317502)
end

function LotteryMultiPickUpUIApi:GetTipText()
	return self:GetCfgText(1317503)
end

LotteryMultiPickUpUIApi:Init()
