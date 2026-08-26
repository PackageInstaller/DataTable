-- chunkname: @modules/logic/explore/model/mo/unit/ExploreLightBallMO.lua

module("modules.logic.explore.model.mo.unit.ExploreLightBallMO", package.seeall)

local ExploreLightBallMO = class("ExploreLightBallMO", ExploreObstacleMO)

function ExploreLightBallMO:initTypeData()
	self.triggerByClick = false
	self.showRes = lua_explore_unit.configDict[ExploreEnum.ItemType.LightBall].asset
	self.isPhotic = true
	self.triggerEffects = {}

	local data = {
		ExploreEnum.TriggerEvent.ItemUnit,
		""
	}

	table.insert(self.triggerEffects, data)
end

function ExploreLightBallMO:getUnitClass()
	return ExploreLightBallUnit
end

function ExploreLightBallMO:isInteractEnabled()
	return true
end

return ExploreLightBallMO
