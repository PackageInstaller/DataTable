-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/RogueUnitCompMeshModel.lua

module("logic.extensions.roguelike.unit.comp.RogueUnitCompMeshModel", package.seeall)

local M = class("RogueUnitCompMeshModel", UnitCompMeshModel, IBattleUnitComponent)

function M:onInit()
	M.super.onInit(self)

	self._goAvatar = self._unit.mountRoot:getAvatarRoot()
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

	self:clear()
end

function M:onUpdateTimeScale(timeScale)
	self:setPlaySpeed(timeScale)
end

function M:setBody(url)
	if self._url == url then
		return
	end

	self:clear()

	if not url then
		return
	end

	self._url = url

	self._prefabLoader:load(url, self._onBodyLoaded, self, true)
end

function M:setDirection(dir, isIgnoreChange)
	self._dir = dir

	if not isIgnoreChange then
		self._transformComp:setScaleXYZ(dir == 0 and -1 or 1, 1, -1)
	end
end

function M:getDirection()
	return self._dir
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
end

function M:_doJumpToTime()
	return
end

return M
