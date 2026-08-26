-- chunkname: @modules/logic/explore/map/unit/ExploreDisjunctorUnit.lua

module("modules.logic.explore.map.unit.ExploreDisjunctorUnit", package.seeall)

local ExploreDisjunctorUnit = class("ExploreDisjunctorUnit", ExploreBaseDisplayUnit)

function ExploreDisjunctorUnit:onTrigger()
	ExploreDisjunctorUnit.super.onTrigger(self)
	self:doRotate(self.mo.unitDir, ExploreHelper.getDir(self.mo.unitDir + 90), 0.5)

	self._lockTrigger = true

	TaskDispatcher.runDelay(self._delayUnlock, self, 2.5)
end

function ExploreDisjunctorUnit:tryTrigger(...)
	if self._lockTrigger then
		return
	end

	ExploreDisjunctorUnit.super.tryTrigger(self, ...)
end

function ExploreDisjunctorUnit:_delayUnlock()
	self._lockTrigger = false
end

function ExploreDisjunctorUnit:onDestroy()
	TaskDispatcher.cancelTask(self._delayUnlock, self)
	ExploreDisjunctorUnit.super.onDestroy(self)
end

return ExploreDisjunctorUnit
