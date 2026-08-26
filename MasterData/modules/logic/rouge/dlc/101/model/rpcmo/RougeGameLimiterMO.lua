-- chunkname: @modules/logic/rouge/dlc/101/model/rpcmo/RougeGameLimiterMO.lua

module("modules.logic.rouge.dlc.101.model.rpcmo.RougeGameLimiterMO", package.seeall)

local RougeGameLimiterMO = pureTable("RougeGameLimiterMO")

function RougeGameLimiterMO:init(info)
	self.riskId = info.riskId
	self.riskValue = info.riskValue
	self.limitIds = tabletool.copy(info.limitIds)
	self.limitBuffIds = tabletool.copy(info.limitBuffIds)
end

function RougeGameLimiterMO:getLimiterIds()
	return self.limitIds
end

function RougeGameLimiterMO:getLimiterBuffIds()
	return self.limitBuffIds
end

function RougeGameLimiterMO:getRiskValue()
	return self.riskValue
end

return RougeGameLimiterMO
