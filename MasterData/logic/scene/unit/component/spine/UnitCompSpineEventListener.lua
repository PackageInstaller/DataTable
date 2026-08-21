-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/spine/UnitCompSpineEventListener.lua

module("logic.scene.unit.component.spine.UnitCompSpineEventListener", package.seeall)

local UnitCompSpineEventListener = class("UnitCompSpineEventListener", UnitComponentBase)

function UnitCompSpineEventListener:onInit()
	self._spineEventListener = false
	self._spine = self._unit.spine or false

	self._unit:addInnerEventListener(UnitActionType.SpineLoaded, self._onSpineLoaded, self)
end

function UnitCompSpineEventListener:onReset()
	if self._spineEventListener then
		self._spineEventListener:RemoveEventListener()

		self._spineEventListener = false
	end
end

function UnitCompSpineEventListener:onDestroy()
	self._unit:removeInnerEventListener(UnitActionType.SpineLoaded, self._onSpineLoaded, self)

	if self._spineEventListener and not goutil.isNil(self._spineEventListener) then
		self._spineEventListener:RemoveEventListener()

		self._spineEventListener = false
	end
end

function UnitCompSpineEventListener:_onSpineLoaded()
	local goInst = self._spine:getInst()

	if not goInst then
		if BattleLog.enableWarn then
			BattleLog.warn("UnitCompSpineEventListener::go inst is nil")
		end

		return
	end

	self._spineEventListener = Spine.SpineEventListener.Get(goInst)

	self._spineEventListener:AddEventListener(self._onSpineEvent, self)
end

function UnitCompSpineEventListener:_onSpineEvent(animationName, eventName, eventParam)
	self._unit:dispatchInnerEvent(UnitActionType.SpineEvent, animationName, eventName, eventParam)
end

return UnitCompSpineEventListener
