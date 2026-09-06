-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompSpineEvent.lua

module(..., package.seeall)

local UnitCompSpineEvent = class("UnitCompSpineEvent", UnitComponentBase)

function UnitCompSpineEvent:ctor(unit)
	UnitCompSpineEvent.super.ctor(self, unit)

	self._spineEventHandler = nil
end

function UnitCompSpineEvent:onInit()
	self._spine = self._unit.spine

	self._spine:addListener(UnitNotify.SpineLoaded, self._onSpineLoaded, self)
end

function UnitCompSpineEvent:onDestroy()
	UnitCompSpineEvent.super.onDestroy(self)

	self._spineEventHandler = nil
end

function UnitCompSpineEvent:_onSpineLoaded()
	local spineGo = self._spine:getInst()

	self._spineEventHandler = goutil.addComponentOnce(spineGo, typeof(Spine.SpineActionEventHandler))

	self._spineEventHandler:AddActionEventListener(self._onSpineEvent, self)
end

function UnitCompSpineEvent:_onSpineEvent(actionName, eventName, eventParam)
	self:dispatch(UnitNotify.SpineEvent, actionName, eventName, eventParam)
end

return UnitCompSpineEvent
