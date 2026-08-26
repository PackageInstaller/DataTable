-- chunkname: @modules/logic/explore/map/unit/ExploreBonusSceneUnit.lua

module("modules.logic.explore.map.unit.ExploreBonusSceneUnit", package.seeall)

local ExploreBonusSceneUnit = class("ExploreBonusSceneUnit", ExploreBaseMoveUnit)

function ExploreBonusSceneUnit:needInteractAnim()
	return true
end

function ExploreBonusSceneUnit:canTrigger()
	if self.mo:isInteractActiveState() then
		return false
	end

	return ExploreBonusSceneUnit.super.canTrigger(self)
end

return ExploreBonusSceneUnit
