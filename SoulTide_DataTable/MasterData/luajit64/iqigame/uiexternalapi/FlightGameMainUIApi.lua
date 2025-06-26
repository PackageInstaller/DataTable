-- chunkname: @IQIGame\\UIExternalApi\\FlightGameMainUIApi.lua

FlightGameMainUIApi = BaseLangApi:Extend()

function FlightGameMainUIApi:Init()
	self:RegisterApi("TextDistance", self.GetTextDistance)
	self:RegisterApi("TextBlood", self.GetTextBlood)
	self:RegisterApi("TextSpeed", self.GetTextSpeed)
	self:RegisterApi("TextRewardNum", self.GetTextRewardNum)
	self:RegisterApi("TextHpTotal", self.GetTextHpTotal)
end

function FlightGameMainUIApi:GetTextHpTotal(num)
	return string.format("/%s", num)
end

function FlightGameMainUIApi:GetTextRewardNum(num)
	return string.format("x%s", num)
end

function FlightGameMainUIApi:GetTextSpeed(num)
	return string.format(self:GetCfgText(3300511), num)
end

function FlightGameMainUIApi:GetTextBlood(num)
	return string.format(self:GetCfgText(3300512), num)
end

function FlightGameMainUIApi:GetTextDistance(num)
	return string.format("%sm", num)
end

FlightGameMainUIApi:Init()
