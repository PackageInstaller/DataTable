-- chunkname: @IQIGame\\UIExternalApi\\EndlessMazeDetailUIApi.lua

EndlessMazeDetailUIApi = BaseLangApi:Extend()

function EndlessMazeDetailUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("RewardLabelText", self.GetRewardLabelText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("RecommendPowerText", self.GetRecommendPowerText)
	self:RegisterApi("FormationPowerText", self.GetFormationPowerText)
	self:RegisterApi("MonsterPanelLabel", self.GetMonsterPanelLabel)
	self:RegisterApi("FreeCountLabel", self.GetFreeCountLabel)
	self:RegisterApi("FreeCountText", self.GetFreeCountText)
	self:RegisterApi("EnergyCostText", self.GetEnergyCostText)
end

function EndlessMazeDetailUIApi:GetMonsterPanelLabel()
	return self:GetCfgText(2100001)
end

function EndlessMazeDetailUIApi:GetTitleText()
	return self:GetCfgText(2100002)
end

function EndlessMazeDetailUIApi:GetRewardLabelText()
	return self:GetCfgText(2100003)
end

function EndlessMazeDetailUIApi:GetConfirmBtnText()
	return self:GetCfgText(2100004)
end

function EndlessMazeDetailUIApi:GetRecommendPowerText(recommendPower)
	return self:GetCfgText(2100005) .. "：" .. recommendPower
end

function EndlessMazeDetailUIApi:GetFormationPowerText(currentPower, recommendPower)
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

function EndlessMazeDetailUIApi:GetFreeCountLabel()
	return self:GetCfgText(2100006)
end

function EndlessMazeDetailUIApi:GetFreeCountText(count, maxCount)
	return string.format("%s/%s", count, maxCount)
end

function EndlessMazeDetailUIApi:GetEnergyCostText(cost, currentEnergy)
	return cost
end

EndlessMazeDetailUIApi:Init()
