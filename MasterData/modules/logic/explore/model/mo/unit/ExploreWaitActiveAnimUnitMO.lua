-- chunkname: @modules/logic/explore/model/mo/unit/ExploreWaitActiveAnimUnitMO.lua

module("modules.logic.explore.model.mo.unit.ExploreWaitActiveAnimUnitMO", package.seeall)

local ExploreWaitActiveAnimUnitMO = class("ExploreWaitActiveAnimUnitMO", ExploreBaseUnitMO)

function ExploreWaitActiveAnimUnitMO:activeStateChange(isActive)
	return
end

function ExploreWaitActiveAnimUnitMO:checkActiveCount()
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

return ExploreWaitActiveAnimUnitMO
