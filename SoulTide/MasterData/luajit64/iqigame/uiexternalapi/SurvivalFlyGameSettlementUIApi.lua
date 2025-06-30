-- chunkname: @IQIGame\\UIExternalApi\\SurvivalFlyGameSettlementUIApi.lua

SurvivalFlyGameSettlementUIApi = BaseLangApi:Extend()

function SurvivalFlyGameSettlementUIApi:Init()
	self:RegisterApi("TextTotalNum", self.GetTextTotalNum)
	self:RegisterApi("ImageState", self.GetImageState)
	self:RegisterApi("SpendValue", self.GetSpendValue)
end

function SurvivalFlyGameSettlementUIApi:GetSpendValue(value)
	return string.format("x%s", value)
end

function SurvivalFlyGameSettlementUIApi:GetImageState(num)
	local path = UIGlobalApi.GetImagePath("/Activity/SurvivalFlyGame/SurvivalFly_02/SurvivalFlyGameSettlementUI_02/Defeat.png")

	if num == 1 then
		path = UIGlobalApi.GetImagePath("/Activity/SurvivalFlyGame/SurvivalFly_02/SurvivalFlyGameSettlementUI_02/B.png")
	elseif num == 2 then
		path = UIGlobalApi.GetImagePath("/Activity/SurvivalFlyGame/SurvivalFly_02/SurvivalFlyGameSettlementUI_02/A.png")
	elseif num == 3 then
		path = UIGlobalApi.GetImagePath("/Activity/SurvivalFlyGame/SurvivalFly_02/SurvivalFlyGameSettlementUI_02/S.png")
	end

	return path
end

function SurvivalFlyGameSettlementUIApi:GetTextTotalNum(num)
	return string.format(self:GetCfgText(3300530), num)
end

SurvivalFlyGameSettlementUIApi:Init()
