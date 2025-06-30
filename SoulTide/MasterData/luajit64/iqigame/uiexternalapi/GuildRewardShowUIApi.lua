-- chunkname: @IQIGame\\UIExternalApi\\GuildRewardShowUIApi.lua

GuildRewardShowUIApi = BaseLangApi:Extend()

function GuildRewardShowUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("BtnGetAllRewardLabel", self.GetBtnGetAllRewardLabel)
	self:RegisterApi("BtnGetRewardLabel", self.GetBtnGetRewardLabel)
	self:RegisterApi("TextStatus", self.GetTextStatus)
	self:RegisterApi("TextTargetScore", self.GetTextTargetScore)
end

function GuildRewardShowUIApi:GetTextTargetScore(num, targetNum)
	return string.format(self:GetCfgText(9100101), num, targetNum)
end

function GuildRewardShowUIApi:GetTextStatus()
	return self:GetCfgText(9100102)
end

function GuildRewardShowUIApi:GetBtnGetRewardLabel()
	return self:GetCfgText(9100103)
end

function GuildRewardShowUIApi:GetBtnGetAllRewardLabel()
	return self:GetCfgText(9100104)
end

function GuildRewardShowUIApi:GetTitleText()
	return self:GetCfgText(9100105)
end

GuildRewardShowUIApi:Init()
