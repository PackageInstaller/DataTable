-- chunkname: @IQIGame\\UIExternalApi\\GuildTrainingDetailInfoUIApi.lua

GuildTrainingDetailInfoUIApi = BaseLangApi:Extend()

function GuildTrainingDetailInfoUIApi:Init()
	self:RegisterApi("TextPowerNum", self.GetTextPowerNum)
	self:RegisterApi("BtnTipDes", self.GetBtnTipDes)
	self:RegisterApi("TextEndTime", self.GetTextEndTime)
	self:RegisterApi("TextMyMaxScore", self.GetTextMyMaxScore)
end

function GuildTrainingDetailInfoUIApi:GetTextMyMaxScore(score)
	return string.format(self:GetCfgText(9101603), score)
end

function GuildTrainingDetailInfoUIApi:GetTextEndTime(second)
	local str = self:GetCfgText(9101604)

	if second >= 86400 then
		str = string.format(self:GetCfgText(9101605), math.floor(second / 86400))
	elseif second >= 3600 then
		str = string.format(self:GetCfgText(9101606), math.floor(second / 3600))
	elseif second >= 60 then
		str = string.format(self:GetCfgText(9101607), math.floor(second / 60))
	end

	return str
end

function GuildTrainingDetailInfoUIApi:GetBtnTipDes()
	return self:GetCfgText(9101601)
end

function GuildTrainingDetailInfoUIApi:GetTextPowerNum(power)
	return power
end

GuildTrainingDetailInfoUIApi:Init()
