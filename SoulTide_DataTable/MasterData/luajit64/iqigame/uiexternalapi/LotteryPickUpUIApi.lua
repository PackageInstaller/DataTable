-- chunkname: @IQIGame\\UIExternalApi\\LotteryPickUpUIApi.lua

LotteryPickUpUIApi = BaseLangApi:Extend()

function LotteryPickUpUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("ItemOffRightText", self.GetItemOffRightText)
	self:RegisterApi("ItemOnRightText", self.GetItemOnRightText)
end

function LotteryPickUpUIApi:GetTitleText()
	return self:GetCfgText(1317400)
end

function LotteryPickUpUIApi:GetTipText()
	return self:GetCfgText(1317401)
end

function LotteryPickUpUIApi:GetItemOffRightText()
	return self:GetCfgText(1317402)
end

function LotteryPickUpUIApi:GetItemOnRightText()
	return self:GetCfgText(1317403)
end

LotteryPickUpUIApi:Init()
