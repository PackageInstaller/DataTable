-- chunkname: @modules/logic/explore/model/mo/unit/ExploreBonusSceneUnitMO.lua

module("modules.logic.explore.model.mo.unit.ExploreBonusSceneUnitMO", package.seeall)

local ExploreBonusSceneUnitMO = class("ExploreBonusSceneUnitMO", ExploreBaseUnitMO)

function ExploreBonusSceneUnitMO:initTypeData()
	self.triggerEffects = tabletool.copy(self.triggerEffects)

	local data = {
		ExploreEnum.TriggerEvent.OpenBonusView
	}

	if self.triggerEffects[1] and self.triggerEffects[1][1] == ExploreEnum.TriggerEvent.Dialogue then
		table.insert(self.triggerEffects, 2, data)
	else
		table.insert(self.triggerEffects, 1, data)
	end
end

return ExploreBonusSceneUnitMO
