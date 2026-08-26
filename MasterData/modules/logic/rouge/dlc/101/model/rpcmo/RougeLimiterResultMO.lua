-- chunkname: @modules/logic/rouge/dlc/101/model/rpcmo/RougeLimiterResultMO.lua

module("modules.logic.rouge.dlc.101.model.rpcmo.RougeLimiterResultMO", package.seeall)

local RougeLimiterResultMO = pureTable("RougeLimiterResultMO")

function RougeLimiterResultMO:init(info)
	self.addEmblem = tonumber(info.addEmblem)
	self.useLimitBuffIds = {}

	tabletool.addValues(self.useLimitBuffIds, info.useLimitBuffIds)
end

function RougeLimiterResultMO:getLimiterAddEmblem()
	return self.addEmblem or 0
end

function RougeLimiterResultMO:getLimiterUseBuffIds()
	return self.useLimitBuffIds
end

function RougeLimiterResultMO:setPreEmbleCount(embleCount)
	self.preEmbleCount = embleCount or 0
end

function RougeLimiterResultMO:getPreEmbleCount()
	return self.preEmbleCount or 0
end

return RougeLimiterResultMO
