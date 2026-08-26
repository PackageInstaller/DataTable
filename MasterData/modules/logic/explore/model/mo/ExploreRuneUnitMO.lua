-- chunkname: @modules/logic/explore/model/mo/ExploreRuneUnitMO.lua

module("modules.logic.explore.model.mo.ExploreRuneUnitMO", package.seeall)

local ExploreRuneUnitMO = class("ExploreRuneUnitMO", ExploreBaseUnitMO)

function ExploreRuneUnitMO:activeStateChange(isActive)
	return
end

function ExploreRuneUnitMO:checkActiveCount()
	if not self._countSource then
		return
	end

	for _, targetId in pairs(self._countSource) do
		if self:isInteractActiveState() then
			ExploreCounterModel.instance:add(targetId, self.id)
		else
			ExploreCounterModel.instance:reduce(targetId, self.id)
		end
	end
end

return ExploreRuneUnitMO
