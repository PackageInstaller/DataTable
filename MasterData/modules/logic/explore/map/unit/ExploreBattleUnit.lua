-- chunkname: @modules/logic/explore/map/unit/ExploreBattleUnit.lua

module("modules.logic.explore.map.unit.ExploreBattleUnit", package.seeall)

local ExploreBattleUnit = class("ExploreBattleUnit", ExploreBaseDisplayUnit)

function ExploreBattleUnit:onResLoaded()
	ExploreBattleUnit.super.onResLoaded(self)

	local interactInfoMO = self.mo:getInteractInfoMO()

	if interactInfoMO.statusInfo.success == 1 then
		ExploreRpc.instance:sendExploreInteractRequest(self.id)
	end
end

function ExploreBattleUnit:canTrigger()
	if not self.mo:isInteractActiveState() then
		return false
	end

	local interactInfoMO = self.mo:getInteractInfoMO()

	if interactInfoMO.statusInfo.success == 1 then
		return false
	end

	return ExploreBattleUnit.super.canTrigger(self)
end

return ExploreBattleUnit
