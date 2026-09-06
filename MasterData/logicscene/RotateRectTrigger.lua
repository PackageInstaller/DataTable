-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/trigger/RotateRectTrigger.lua

module("logicscene.scene.trigger.RotateRectTrigger", package.seeall)

local RotateRectTrigger = class("RotateRectTrigger")
local POINT_LINE_POS_RELATION_TYPE_DOWN = 1
local POINT_LINE_POS_RELATION_TYPE_UP = -1
local POINT_LINE_POS_RELATION_TYPE_DIRECT = 0

function RotateRectTrigger:ctor(id)
	self._triggerId = id
	self._leftBottom = nil
	self._rightBottom = nil
	self._rightTop = nil
	self._leftTop = nil
	self._isTriggered = false
	self._transform = nil
end

function RotateRectTrigger:setTransform(transform)
	self._transform = transform
end

function RotateRectTrigger:setListener(listener, listenerObj)
	self._listener = listener
	self._listenerObj = listenerObj
end

function RotateRectTrigger:clear()
	self._leftBottom = nil
	self._rightBottom = nil
	self._rightTop = nil
	self._leftTop = nil
	self._isTriggered = false
	self._transform = nil
	self._listener = nil
	self._listenerObj = nil
	self._triggerId = nil
end

function RotateRectTrigger:calculate(rect, rot)
	local leftBottom = rect.min
	local rightTop = rect.max
	local leftTop = rect.min
	local rightBottom = rect.min

	leftTop.y = leftTop.y + rect.height
	rightBottom.x = rightBottom.x + rect.width

	local center = rect.center
	local tempVec3 = Vector3.New()

	tempVec3.x = leftBottom.x - center.x
	tempVec3.y = leftBottom.y - center.y

	local temp = Quaternion.AngleAxis(rot, Vector3.forward)

	self._leftBottom = temp * tempVec3
	tempVec3.x = rightBottom.x - center.x
	tempVec3.y = rightBottom.y - center.y
	self._rightBottom = temp * tempVec3
	tempVec3.x = rightTop.x - center.x
	tempVec3.y = rightTop.y - center.y
	self._rightTop = temp * tempVec3
	tempVec3.x = leftTop.x - center.x
	tempVec3.y = leftTop.y - center.y
	self._leftTop = temp * tempVec3
	self._leftBottom.x = self._leftBottom.x + center.x
	self._leftBottom.y = self._leftBottom.y + center.y
	self._rightBottom.x = self._rightBottom.x + center.x
	self._rightBottom.y = self._rightBottom.y + center.y
	self._rightTop.x = self._rightTop.x + center.x
	self._rightTop.y = self._rightTop.y + center.y
	self._leftTop.x = self._leftTop.x + center.x
	self._leftTop.y = self._leftTop.y + center.y
end

function RotateRectTrigger:reserState()
	self._isTriggered = false
end

function RotateRectTrigger:isInRange(posX, posY)
	local result12 = self:_getPointLinePosRelation(self._leftBottom, self._rightBottom, posX, posY)
	local result34 = self:_getPointLinePosRelation(self._leftTop, self._rightTop, posX, posY)

	if result12 * result34 > 0 then
		return false
	end

	local result23 = self:_getPointLinePosRelation(self._rightBottom, self._rightTop, posX, posY)
	local result41 = self:_getPointLinePosRelation(self._leftBottom, self._leftTop, posX, posY)

	if result23 * result41 > 0 then
		return false
	end

	return true
end

function RotateRectTrigger:update()
	if not self._transform then
		return
	end

	local posx, posy, posz = Framework.TransformUtil.GetLocalPos(self._transform, nil, nil, nil)
	local isIn = self:isInRange(posx, posy)

	if isIn then
		if not self._isTriggered then
			self._isTriggered = true

			self:_onEnterTrigger(true)
		end
	elseif self._isTriggered then
		self._isTriggered = false

		self:_onEnterTrigger(false)
	end
end

function RotateRectTrigger:_getPointLinePosRelation(lineStart, lineEnd, ptX, ptY)
	local ret = (ptY - lineStart.y) * (lineEnd.x - lineStart.x) - (lineEnd.y - lineStart.y) * (ptX - lineStart.x)

	if ret > 0 then
		return POINT_LINE_POS_RELATION_TYPE_DOWN
	elseif ret < 0 then
		return POINT_LINE_POS_RELATION_TYPE_UP
	end

	return POINT_LINE_POS_RELATION_TYPE_DIRECT
end

function RotateRectTrigger:_onEnterTrigger(entered)
	if self._listener then
		if self._listenerObj then
			self._listener(self._listenerObj, self._triggerId, entered)
		else
			self._listener(self._triggerId, entered)
		end
	end
end

return RotateRectTrigger
