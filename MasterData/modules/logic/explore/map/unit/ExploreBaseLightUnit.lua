-- chunkname: @modules/logic/explore/map/unit/ExploreBaseLightUnit.lua

module("modules.logic.explore.map.unit.ExploreBaseLightUnit", package.seeall)

local ExploreBaseLightUnit = class("ExploreBaseLightUnit", ExploreBaseMoveUnit)

function ExploreBaseLightUnit:initComponents(...)
	ExploreBaseLightUnit.super.initComponents(self, ...)
	self:addComp("lightComp", ExploreUnitLightComp)
end

function ExploreBaseLightUnit:onInFOVChange(v)
	if v then
		self:setupRes()
		TaskDispatcher.cancelTask(self._releaseDisplayGo, self)
	else
		TaskDispatcher.runDelay(self._releaseDisplayGo, self, ExploreConstValue.CHECK_INTERVAL.UnitObjDestory)
	end
end

function ExploreBaseLightUnit:setActiveAnim(haveLight)
	if haveLight then
		self:playAnim(ExploreAnimEnum.AnimName.nToA)
	else
		self:playAnim(ExploreAnimEnum.AnimName.aToN)
	end
end

function ExploreBaseLightUnit:onActiveChange(nowActive)
	return
end

function ExploreBaseLightUnit:getIdleAnim()
	local mo = self.mo

	if not mo:isInteractEnabled() then
		return ExploreAnimEnum.AnimName.unable
	elseif not self:haveLight() then
		return ExploreAnimEnum.AnimName.normal
	else
		return ExploreAnimEnum.AnimName.active
	end
end

return ExploreBaseLightUnit
