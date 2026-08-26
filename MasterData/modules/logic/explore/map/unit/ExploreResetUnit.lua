-- chunkname: @modules/logic/explore/map/unit/ExploreResetUnit.lua

module("modules.logic.explore.map.unit.ExploreResetUnit", package.seeall)

local ExploreResetUnit = class("ExploreResetUnit", ExploreBaseDisplayUnit)

function ExploreResetUnit:onRoleEnter(nowNode, preNode, unit)
	if not preNode then
		return
	end

	if not unit:isRole() then
		return
	end

	if unit:isMoving() then
		unit:stopMoving()
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.HeroAnim)
		ExploreController.instance:registerCallback(ExploreEvent.OnHeroMoveEnd, self.beginTrigger, self)
	else
		TaskDispatcher.runDelay(self.beginTrigger, self, 0)
	end

	self.animComp:playAnim(ExploreAnimEnum.AnimName.nToA)
end

function ExploreResetUnit:onRoleLeave(nowNode, preNode, unit)
	if not unit:isRole() then
		return
	end

	self.animComp:playAnim(ExploreAnimEnum.AnimName.aToN)
end

function ExploreResetUnit:beginTrigger()
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, self.beginTrigger, self)
	ExploreHeroResetFlow.instance:begin(self.id)
end

function ExploreResetUnit:onDestroy()
	TaskDispatcher.cancelTask(self.beginTrigger, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, self.beginTrigger, self)
	ExploreResetUnit.super.onDestroy(self)
end

return ExploreResetUnit
