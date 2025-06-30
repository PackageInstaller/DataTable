-- chunkname: @IQIGame\\UIExternalApi\\LotteryRewardListUIApi.lua

LotteryRewardListUIApi = BaseLangApi:Extend()

function LotteryRewardListUIApi:Init()
	self:RegisterApi("WindowTitleText", self.GetWindowTitleText)
	self:RegisterApi("RewardTitleText", self.GetRewardTitleText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("ProbabilityText", self.GetProbabilityText)
	self:RegisterApi("RewardNameText", self.GetRewardNameText)
end

function LotteryRewardListUIApi:GetWindowTitleText()
	return self:GetCfgText(1317101)
end

function LotteryRewardListUIApi:GetRewardTitleText(titleText, canShowNum, totalNum)
	return titleText .. "(" .. canShowNum .. "/" .. totalNum .. ")"
end

function LotteryRewardListUIApi:GetTipText()
	return self.TextColor[37] .. self:GetCfgText(1317102) .. self.TextColor[0]
end

function LotteryRewardListUIApi:GetProbabilityText(text)
	return text
end

function LotteryRewardListUIApi:GetRewardNameText(name, isUnlock, type, quality)
	if type == 1 then
		return name
	else
		return self.TextColor[31] .. name .. self.TextColor[0]
	end

	return name
end

LotteryRewardListUIApi:Init()
