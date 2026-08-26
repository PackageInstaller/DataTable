-- chunkname: @modules/logic/rouge/dlc/101/controller/RougeDLCHelper101.lua

module("modules.logic.rouge.dlc.101.controller.RougeDLCHelper101", package.seeall)

local RougeDLCHelper101 = class("RougeDLCHelper101")

function RougeDLCHelper101.getLimiterBuffSpeedupCost(remainRound)
	local costMap = RougeDLCHelper101._getOrCreateBuffSpeedupCostMap()
	local speedupCost = costMap and costMap[remainRound]

	return speedupCost or 0
end

function RougeDLCHelper101._getOrCreateBuffSpeedupCostMap()
	if not RougeDLCHelper101._costMap then
		local costCo = lua_rouge_dlc_const.configDict[RougeDLCEnum101.Const.SpeedupCost]
		local costStr = costCo and costCo.value
		local costList = GameUtil.splitString2(costStr, true)

		RougeDLCHelper101._costMap = {}

		for _, part in ipairs(costList or {}) do
			local round = part[1]

			RougeDLCHelper101._costMap[round] = part[2]
		end
	end

	return RougeDLCHelper101._costMap
end

function RougeDLCHelper101.isLimiterRisker(preRiskCo, nextRiskCo)
	local isRisker = nextRiskCo ~= nil

	if preRiskCo and nextRiskCo then
		local _, maxPreRiskValue = RougeDLCHelper101._getRiskRange(preRiskCo)
		local minNextPreRiskValue = RougeDLCHelper101._getRiskRange(nextRiskCo)

		isRisker = maxPreRiskValue < minNextPreRiskValue
	end

	return isRisker
end

function RougeDLCHelper101._getRiskRange(riskCo)
	if not riskCo then
		return
	end

	local riskValues = string.splitToNumber(riskCo.range, "#")

	if not riskValues[1] then
		if not riskValues[2] then
			local maxRiskValue = 0

			return riskValues[1], maxRiskValue
		end
	end
end

function RougeDLCHelper101.isNearLimiter(preRiskCo, nextRiskCo)
	local isNear = false

	if preRiskCo and nextRiskCo then
		local minPreRiskValue, maxPreRiskValue = RougeDLCHelper101._getRiskRange(preRiskCo)
		local minNextRiskValue, maxNextRiskValue = RougeDLCHelper101._getRiskRange(nextRiskCo)

		isNear = math.abs(minNextRiskValue - maxPreRiskValue) <= 1 or math.abs(minPreRiskValue - maxNextRiskValue) <= 1
	end

	return isNear
end

return RougeDLCHelper101
