-- chunkname: @IQIGame\\UIExternalApi\\ChallengeDramaBossFormationUIApi.lua

ChallengeDramaBossFormationUIApi = BaseLangApi:Extend()

function ChallengeDramaBossFormationUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("FormationPowerText", self.GetFormationPowerText)
	self:RegisterApi("NoFormations", self.GetNoFormations)
	self:RegisterApi("MonsterPanelLabel", self.GetMonsterPanelLabel)
	self:RegisterApi("RewardLabelText", self.GetRewardLabelText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("CostItemNumText", self.GetCostItemNumText)
	self:RegisterApi("RecommendPowerText", self.GetRecommendPowerText)
end

function ChallengeDramaBossFormationUIApi:GetRecommendPowerText(recommendPower)
	return self:GetCfgText(2100005) .. "：" .. recommendPower
end

function ChallengeDramaBossFormationUIApi:GetCostItemNumText(num, notEnough)
	local color

	color = notEnough and "#e33535" or "#FFFFFF"

	return "<color=" .. color .. ">" .. num .. "</color>"
end

function ChallengeDramaBossFormationUIApi:GetConfirmBtnText()
	return self:GetCfgText(2100004)
end

function ChallengeDramaBossFormationUIApi:GetRewardLabelText()
	return self:GetCfgText(1213166)
end

function ChallengeDramaBossFormationUIApi:GetMonsterPanelLabel()
	return self:GetCfgText(2100001)
end

function ChallengeDramaBossFormationUIApi:GetNoFormations()
	return self:GetCfgText(1213047)
end

function ChallengeDramaBossFormationUIApi:GetTitleText()
	return self:GetCfgText(1213167)
end

function ChallengeDramaBossFormationUIApi:GetFormationPowerText(currentPower, recommendPower)
	local rate = recommendPower / currentPower

	if rate >= 1.25 then
		return self.TextColor[203] .. currentPower .. self.TextColor[0]
	elseif rate >= 1.05 then
		return self.TextColor[218] .. currentPower .. self.TextColor[0]
	elseif rate >= 0.95 then
		return self.TextColor[206] .. currentPower .. self.TextColor[0]
	elseif rate >= 0.75 then
		return self.TextColor[201] .. currentPower .. self.TextColor[0]
	else
		return self.TextColor[219] .. currentPower .. self.TextColor[0]
	end
end

ChallengeDramaBossFormationUIApi:Init()
