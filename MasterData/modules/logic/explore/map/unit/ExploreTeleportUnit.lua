-- chunkname: @modules/logic/explore/map/unit/ExploreTeleportUnit.lua

module("modules.logic.explore.map.unit.ExploreTeleportUnit", package.seeall)

local ExploreTeleportUnit = class("ExploreTeleportUnit", ExploreBaseMoveUnit)

function ExploreTeleportUnit:onTriggerDone()
	ExploreTeleportUnit.super.onTriggerDone(self)
	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Teleport)
end

return ExploreTeleportUnit
