-- chunkname: @modules/logic/explore/map/unit/ExploreDoorOnceUnit.lua

module("modules.logic.explore.map.unit.ExploreDoorOnceUnit", package.seeall)

local ExploreDoorOnceUnit = class("ExploreDoorOnceUnit", ExploreDoor)

function ExploreDoorOnceUnit:tryTrigger(...)
	if not self.mo:isInteractActiveState() then
		ExploreDoorOnceUnit.super.tryTrigger(self, ...)
	end
end

function ExploreDoorOnceUnit:cancelTrigger(...)
	if not self.mo:isInteractActiveState() then
		ExploreDoorOnceUnit.super.cancelTrigger(self, ...)
	end
end

function ExploreDoorOnceUnit:getIdleAnim()
	if self.mo:isInteractActiveState() then
		return ExploreAnimEnum.AnimName.active
	else
		return ExploreDoorOnceUnit.super.getIdleAnim(self)
	end
end

function ExploreDoorOnceUnit:onUpdateCount(...)
	if self.mo:isInteractActiveState() then
		local animName = self.animComp._curAnim

		if animName ~= ExploreAnimEnum.AnimName.nToA then
			self:playAnim(ExploreAnimEnum.AnimName.active)
		end
	else
		ExploreDoorOnceUnit.super.onUpdateCount(self, ...)
	end
end

function ExploreDoorOnceUnit:onActiveChange(nowActive)
	if nowActive then
		local animName = self.animComp._curAnim

		if animName and animName ~= ExploreAnimEnum.AnimName.active and self.animComp:isIdleAnim() then
			self:playAnim(ExploreAnimEnum.AnimName.nToA)
			self:checkShowIcon()

			return
		end
	end

	ExploreDoorOnceUnit.super.onActiveChange(self, nowActive)
end

return ExploreDoorOnceUnit
