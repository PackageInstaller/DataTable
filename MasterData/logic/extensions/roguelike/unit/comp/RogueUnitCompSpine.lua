-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/RogueUnitCompSpine.lua

module("logic.extensions.roguelike.unit.comp.RogueUnitCompSpine", package.seeall)

local M = class("RogueUnitCompSpine", UnitCompSpine, IBattleUnitComponent)

function M:onInit()
	M.super.onInit(self)

	self._goAvatar = self._unit.mountRoot:getAvatarRoot()
	self._skeletonLoader._go = self._goAvatar
	self._transformComp = self._unit.transform
	self._spineEvent = self._unit.spineEvent
	self._spineMover = self._unit.spineMover
	self._material = self._unit.material
	self._uiFollow = self._unit.uiFollow
	self._uiProxy = self._unit.uiProxy
	self._jumpTime = false
	self._jumpSkipEvents = false
	self._jumpStop = false

	self:onReuse()
end

function M:onReuse()
	self._autoIdleAnimState = false

	self:clearJumpToTime()
end

function M:onReset()
	return
end

function M:onDestroy()
	self._transformComp = nil
	self._spineEvent = nil
	self._spineMover = nil
	self._material = nil
	self._uiFollow = nil
	self._goAvatar = nil
	self._autoIdleAnimState = nil
end

function M:onUpdateTimeScale(timeScale)
	self:setPlaySpeed(timeScale)
end

function M:setDirection(dir)
	M.super.setDirection(self, dir)
end

function M:playAndAutoIdle(animState)
	self._autoIdleAnimState = animState

	self:play(animState, false, true)
end

function M:jumpToTime(time, skipEvents, stop)
	self._jumpTime = time
	self._jumpSkipEvents = skipEvents
	self._jumpStop = stop

	self:_doJumpToTime()
end

function M:clearJumpToTime()
	self._jumpTime = false
	self._jumpSkipEvents = false
	self._jumpStop = false

	if self._skeletonAnimation then
		self._skeletonAnimation:JumpToTime(0, false, false)
	end
end

function M:updateScale()
	local realScale = self:getRealScale()

	if realScale then
		self._material:setShadowScale(realScale)
		Astral.TransformUtil.SetLocalScale(self._goAvatar.transform, realScale, realScale, realScale)
	end
end

function M:containsAnimation(animationName)
	if self._skeletonAnimation then
		return self._skeletonAnimation:ContainsAnimation(animationName)
	end

	return false
end

function M:setTransfigurationScale(transfigurationScale)
	if self._transfigurationScale ~= transfigurationScale then
		self._transfigurationScale = transfigurationScale

		self:updateScale()
	end
end

function M:_onSpineEvent(e1, e2, animationName, eventName, eventParam)
	if animationName == self._autoIdleAnimState and eventName == SpineEventName.Complete then
		self._spineMover:playIdle()
	end
end

function M:_onBodyLoaded(loader)
	M.super._onBodyLoaded(self, loader)
	self:_doJumpToTime()

	self._skeletonAnimation.Skeleton.FlipX = self._isFlipX
end

function M:_doJumpToTime()
	if self._skeletonAnimation and self._jumpTime then
		self._skeletonAnimation:JumpToTime(self._jumpTime, self._jumpSkipEvents, self._jumpStop)
	end
end

return M
