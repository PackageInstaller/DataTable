-- chunkname: @modules/logic/rouge/dlc/101/view/RougeResultReViewLimiterBuff.lua

module("modules.logic.rouge.dlc.101.view.RougeResultReViewLimiterBuff", package.seeall)

local RougeResultReViewLimiterBuff = class("RougeResultReViewLimiterBuff", RougeLimiterBuffEntry)

function RougeResultReViewLimiterBuff:ctor(totalRiskValue)
	self._totalRiskValue = totalRiskValue
end

function RougeResultReViewLimiterBuff:addEventListeners()
	return
end

function RougeResultReViewLimiterBuff:removeEventListeners()
	return
end

function RougeResultReViewLimiterBuff:getTotalRiskValue()
	return self._totalRiskValue
end

return RougeResultReViewLimiterBuff
