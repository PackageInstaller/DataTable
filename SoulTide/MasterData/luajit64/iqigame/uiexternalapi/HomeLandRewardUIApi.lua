-- chunkname: @IQIGame\\UIExternalApi\\HomeLandRewardUIApi.lua

HomeLandRewardUIApi = BaseLangApi:Extend()

function HomeLandRewardUIApi:Init()
	self:RegisterApi("TextTitle", self.SetTextTitle)
	self:RegisterApi("TextTitle1", self.SetTextTitle1)
	self:RegisterApi("TextTitle2", self.SetTextTitle2)
	self:RegisterApi("TextMsg", self.SetTextMsg)
	self:RegisterApi("TextBtnLab", self.SetTextBtnLab)
end

function HomeLandRewardUIApi:SetTextTitle()
	return self:GetCfgText(1015035)
end

function HomeLandRewardUIApi:SetTextTitle1()
	return self:GetCfgText(1015036)
end

function HomeLandRewardUIApi:SetTextTitle2()
	return self:GetCfgText(1015037)
end

function HomeLandRewardUIApi:SetTextMsg()
	return self:GetCfgText(1015038)
end

function HomeLandRewardUIApi:SetTextBtnLab()
	return self:GetCfgText(1015039)
end

HomeLandRewardUIApi:Init()
