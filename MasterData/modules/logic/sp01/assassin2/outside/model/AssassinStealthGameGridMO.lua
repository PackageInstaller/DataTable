-- chunkname: @modules/logic/sp01/assassin2/outside/model/AssassinStealthGameGridMO.lua

module("modules.logic.sp01.assassin2.outside.model.AssassinStealthGameGridMO", package.seeall)

local AssassinStealthGameGridMO = class("AssassinStealthGameGridMO")

function AssassinStealthGameGridMO:updateData(gridData)
	self.gridId = gridData.gridId
	self.hasFog = gridData.hasFog

	self:updateTrapList(gridData.traps)

	self.tracePoint = gridData.tracePoint
end

function AssassinStealthGameGridMO:updateTrapList(trapDataList)
	self._trapDict = {}

	for _, trapData in ipairs(trapDataList) do
		self._trapDict[trapData.id] = trapData.duration
	end
end

function AssassinStealthGameGridMO:hasTrapType(targetTrapType)
	local result = false

	if self._trapDict then
		for trapId, _ in pairs(self._trapDict) do
			local trapType = AssassinConfig.instance:getAssassinTrapType(trapId)

			if trapType == targetTrapType then
				result = true

				break
			end
		end
	end

	return result
end

function AssassinStealthGameGridMO:hasTrap(trapId)
	return self._trapDict and self._trapDict[trapId]
end

function AssassinStealthGameGridMO:getHasFog()
	return self.hasFog > 0
end

function AssassinStealthGameGridMO:getTracePointIndex()
	return self.tracePoint
end

return AssassinStealthGameGridMO
