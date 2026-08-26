-- chunkname: @modules/logic/explore/map/unit/ExploreRockUnit.lua

module("modules.logic.explore.map.unit.ExploreRockUnit", package.seeall)

local ExploreRockUnit = class("ExploreRockUnit", ExploreItemUnit)

function ExploreRockUnit:needInteractAnim()
	return true
end

function ExploreRockUnit:setExitCallback(callback, callObj)
	if self._displayTr and self:isInFOV() and ExploreModel.instance:isHeroInControl(ExploreEnum.HeroLock.Spike) and ExploreModel.instance:isHeroInControl(ExploreEnum.HeroLock.Teleport) then
		self._exitCallback = callback
		self._exitCallbackObj = callObj
	else
		callback(callObj)
	end
end

function ExploreRockUnit:_releaseDisplayGo()
	if self._exitCallback then
		self._exitCallback(self._exitCallbackObj)
	end

	self._exitCallback = nil
	self._exitCallbackObj = nil

	ExploreRockUnit.super._releaseDisplayGo(self)
end

function ExploreRockUnit:onAnimEnd(preAnim, nowAnim)
	if preAnim == ExploreAnimEnum.AnimName.exit then
		if self._exitCallback then
			self._exitCallback(self._exitCallbackObj)
		end

		self._exitCallback = nil
		self._exitCallbackObj = nil
	end

	ExploreRockUnit.super.onAnimEnd(self, preAnim, nowAnim)
end

function ExploreRockUnit:onDestroy()
	self._exitCallback = nil
	self._exitCallbackObj = nil

	ExploreRockUnit.super.onDestroy(self)
end

return ExploreRockUnit
