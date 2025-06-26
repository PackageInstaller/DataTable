-- chunkname: @IQIGame\\UIExternalApi\\EndlessPlusMazeDetailUIApi.lua

EndlessPlusMazeDetailUIApi = BaseLangApi:Extend()

function EndlessPlusMazeDetailUIApi:Init()
	self:RegisterApi("CostItemNumText", self.GetCostItemNumText)
	self:RegisterApi("FormationPowerText", self.GetFormationPowerText)
	self:RegisterApi("RecommendPowerText", self.GetRecommendPowerText)
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
end

function EndlessPlusMazeDetailUIApi:GetCostItemNumText(num, notEnough)
	local color

	color = notEnough and "#e33535" or "#FFFFFF"

	return "<color=" .. color .. ">" .. num .. "</color>"
end

function EndlessPlusMazeDetailUIApi:GetFormationPowerText(currentPower, recommendPower)
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

function EndlessPlusMazeDetailUIApi:GetRecommendPowerText(recommendPower)
	return self:GetCfgText(2100005) .. "：" .. recommendPower
end

function EndlessPlusMazeDetailUIApi:GetTitleText()
	return self:GetCfgText(2100002)
end

function EndlessPlusMazeDetailUIApi:GetConfirmBtnText()
	return self:GetCfgText(2100004)
end

EndlessPlusMazeDetailUIApi:Init()
