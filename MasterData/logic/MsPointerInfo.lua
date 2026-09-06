-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/comp/MsPointerInfo.lua

module("logic.extensions.spineinterface.comp.MsPointerInfo", package.seeall)

local MsPointerInfo = class("MsPointerInfo")

function MsPointerInfo:ctor()
	self._elapseSeconds = 0
	self._realElapseSeconds = 0
	self._tempVector2 = Vector2.New()
end

function MsPointerInfo:onUpdate(elapseSeconds, realElapseSeconds)
	self._elapseSeconds = elapseSeconds
	self._realElapseSeconds = realElapseSeconds
end

function MsPointerInfo:onClear()
	self._eventData = nil
	self._curTriggerBoardNameOfDrag = nil
	self._elapseSeconds = 0
	self._realElapseSeconds = 0
end

function MsPointerInfo:getEventData()
	return self._eventData
end

function MsPointerInfo:setEventData(eventData)
	self._eventData = eventData
end

function MsPointerInfo:getCurTriggerBoardNameOfDrag()
	return self._curTriggerBoardNameOfDrag
end

function MsPointerInfo:setCurTriggerBoardNameOfDrag(value)
	self._curTriggerBoardNameOfDrag = value
end

function MsPointerInfo:getDragFreeValue(dragVector, powerValue)
	return powerValue * dragVector.magnitude / 60
end

function MsPointerInfo:getDragDirectionValue(dragVector, targetAngle, powerValue)
	local targetVector
	local radianAngle = Mathf.Deg2Rad * targetAngle

	self._tempVector2:Set(Mathf.Cos(radianAngle), Mathf.Sin(radianAngle))
	self._tempVector2:SetNormalize()

	return Vector2.Dot(dragVector.normalized, self._tempVector2) * (powerValue / 60) * dragVector.magnitude
end

return MsPointerInfo
