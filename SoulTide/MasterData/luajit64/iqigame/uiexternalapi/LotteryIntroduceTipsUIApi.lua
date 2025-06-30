-- chunkname: @IQIGame\\UIExternalApi\\LotteryIntroduceTipsUIApi.lua

LotteryIntroduceTipsUIApi = BaseLangApi:Extend()

function LotteryIntroduceTipsUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("DescTexts", self.GetDescTexts)
end

function LotteryIntroduceTipsUIApi:GetTitleText()
	return self:GetCfgText(1317201)
end

function LotteryIntroduceTipsUIApi:GetDescTexts()
	return {
		self:GetCfgText(1317202),
		self:GetCfgText(1317203),
		self:GetCfgText(1317204),
		self:GetCfgText(1317205),
		self:GetCfgText(1317206),
		self:GetCfgText(1317207)
	}
end

LotteryIntroduceTipsUIApi:Init()
