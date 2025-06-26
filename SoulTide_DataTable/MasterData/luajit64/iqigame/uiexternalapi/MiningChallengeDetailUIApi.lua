-- chunkname: @IQIGame\\UIExternalApi\\MiningChallengeDetailUIApi.lua

MiningChallengeDetailUIApi = BaseLangApi:Extend()

function MiningChallengeDetailUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("MonsterPanelLabel", self.GetMonsterPanelLabel)
	self:RegisterApi("RewardLabelText", self.GetRewardLabelText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("MonsterMessageLabel", self.GetMonsterMessageLabel)
	self:RegisterApi("RecommendPowerText", self.GetRecommendPowerText)
	self:RegisterApi("TextPower", self.GetTextPower)
	self:RegisterApi("NoFormations", self.GetNoFormations)
	self:RegisterApi("CostItemNumText", self.GetCostItemNumText)
end

function MiningChallengeDetailUIApi:GetCostItemNumText(num, enough)
	local color

	color = enough and "#FFFFFF" or "#e33535"

	return "<color=" .. color .. ">" .. num .. "</color>"
end

function MiningChallengeDetailUIApi:GetNoFormations()
	return self:GetCfgText(1213047)
end

function MiningChallengeDetailUIApi:GetTextPower(power, needPower)
	local rate = needPower / power

	if rate >= 1.25 then
		return self.TextColor[203] .. power .. self.TextColor[0]
	elseif rate >= 1.05 then
		return self.TextColor[218] .. power .. self.TextColor[0]
	elseif rate >= 0.95 then
		return self.TextColor[206] .. power .. self.TextColor[0]
	elseif rate >= 0.75 then
		return self.TextColor[201] .. power .. self.TextColor[0]
	else
		return self.TextColor[219] .. power .. self.TextColor[0]
	end
end

function MiningChallengeDetailUIApi:GetRecommendPowerText(recommendPower)
	return self:GetCfgText(2100005) .. "：" .. recommendPower
end

function MiningChallengeDetailUIApi:GetMonsterMessageLabel()
	return self:GetCfgText(3700531)
end

function MiningChallengeDetailUIApi:GetConfirmBtnText()
	return self:GetCfgText(3700532)
end

function MiningChallengeDetailUIApi:GetRewardLabelText()
	return self:GetCfgText(3700533)
end

function MiningChallengeDetailUIApi:GetMonsterPanelLabel()
	return self:GetCfgText(3700534)
end

function MiningChallengeDetailUIApi:GetTitleText()
	return self:GetCfgText(3700535)
end

MiningChallengeDetailUIApi:Init()
