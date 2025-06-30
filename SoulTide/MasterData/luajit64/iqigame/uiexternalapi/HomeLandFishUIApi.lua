-- chunkname: @IQIGame\\UIExternalApi\\HomeLandFishUIApi.lua

HomeLandFishUIApi = BaseLangApi:Extend()

function HomeLandFishUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("BtnBookLabel", self.GetBtnBookLabel)
	self:RegisterApi("BtnShopLabel", self.GetBtnShopLabel)
	self:RegisterApi("BtnBagLabel", self.GetBtnBagLabel)
	self:RegisterApi("BtnAngleLabel", self.GetBtnAngleLabel)
	self:RegisterApi("BtnFishLabel", self.GetBtnFishLabel)
	self:RegisterApi("ProgressValue", self.GetProgressValue)
	self:RegisterApi("TextTip1", self.GetTextTip1)
	self:RegisterApi("TextTip2", self.GetTextTip2)
	self:RegisterApi("BtnGiveUpLabel", self.GetBtnGiveUpLabel)
end

function HomeLandFishUIApi:GetBtnGiveUpLabel()
	return "放弃"
end

function HomeLandFishUIApi:GetTextTip2()
	return self:GetCfgText(1015747)
end

function HomeLandFishUIApi:GetTextTip1(top)
	if top then
		return self:GetCfgText(1015748)
	end

	return self:GetCfgText(1015749)
end

function HomeLandFishUIApi:GetProgressValue(per)
	return string.format("%s%%", per)
end

function HomeLandFishUIApi:GetBtnFishLabel()
	return self:GetCfgText(1015741)
end

function HomeLandFishUIApi:GetBtnAngleLabel()
	return self:GetCfgText(1015742)
end

function HomeLandFishUIApi:GetBtnBagLabel()
	return self:GetCfgText(1015743)
end

function HomeLandFishUIApi:GetBtnShopLabel()
	return self:GetCfgText(1015744)
end

function HomeLandFishUIApi:GetBtnBookLabel()
	return self:GetCfgText(1015745)
end

function HomeLandFishUIApi:GetTextTitle()
	return self:GetCfgText(1015746)
end

HomeLandFishUIApi:Init()
