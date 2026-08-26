-- chunkname: @modules/common/others/UIDragListenerHelper.lua

module("modules.common.others.UIDragListenerHelper", package.seeall)

local UIDragListenerHelper = class("UIDragListenerHelper", UserDataDispose)
local PI = math.pi
local EP = 1e-05
local abs = math.abs
local sqrt = math.sqrt
local acos = math.acos
local _180 = 180
local csTweenHelper = ZProj.TweenHelper
local csUIDragListener = SLFramework.UGUI.UIDragListener

UIDragListenerHelper.EventBegin = 1
UIDragListenerHelper.EventDragging = 2
UIDragListenerHelper.EventEnd = 3

local SwipeDirEnum = {
	Down = -1,
	Up = 1,
	Right = -1,
	Left = 1,
	None = 0
}

local function _degrees(rad)
	return _180 / PI * rad
end

local function _equals0_s(s)
	return abs(s) <= EP
end

local function _dotV2(lhs, rhs)
	return lhs.x * rhs.x + lhs.y * rhs.y
end

local function _angleInRad(fromV2, toV2)
	local sqMagFrom = _dotV2(fromV2, fromV2)
	local sqMagTo = _dotV2(toV2, toV2)

	if _equals0_s(sqMagFrom) or _equals0_s(sqMagTo) then
		return 0
	end

	local cosTheta = _dotV2(fromV2, toV2) / sqrt(sqMagFrom * sqMagTo)

	return acos(cosTheta)
end

function UIDragListenerHelper:ctor()
	self:__onInit()
	LuaEventSystem.addEventMechanism(self)

	self._dragInfo = {
		delta = {
			x = 0,
			y = 0
		}
	}
	self._swipeH = SwipeDirEnum.None
	self._swipeV = SwipeDirEnum.None

	self:clear()
end

function UIDragListenerHelper:onDestroyView()
	self:release()
	self:__onDispose()
end

function UIDragListenerHelper:create(go, userParams)
	self:release()

	self._transform = go.transform
	self._dragInfo.userParams = userParams or {}
	self._csDragObj = csUIDragListener.Get(go)

	self._csDragObj:AddDragBeginListener(self._onDragBegin, self)
	self._csDragObj:AddDragListener(self._onDragging, self)
	self._csDragObj:AddDragEndListener(self._onDragEnd, self)
end

function UIDragListenerHelper:createByScrollRect(scrollRectCmp, userParams)
	self:create(scrollRectCmp.gameObject, userParams)

	self._scrollRectCmp = scrollRectCmp
end

function UIDragListenerHelper:release()
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId_DOAnchorPos")
	self:unregisterAllCallback(UIDragListenerHelper.EventBegin)
	self:unregisterAllCallback(UIDragListenerHelper.EventDragging)
	self:unregisterAllCallback(UIDragListenerHelper.EventEnd)

	if self._csDragObj then
		self._csDragObj:RemoveDragBeginListener()
		self._csDragObj:RemoveDragListener()
		self._csDragObj:RemoveDragEndListener()
	end

	self._csDragObj = nil
	self._scrollRectCmp = nil
end

function UIDragListenerHelper:clear()
	local t = self._dragInfo

	t.hasBegin = false
	t.isDragging = false
	t.hasEnd = false
end

function UIDragListenerHelper:dragInfo()
	return self._dragInfo
end

function UIDragListenerHelper:transform()
	return self._transform
end

function UIDragListenerHelper:_refreshSwipeDir()
	local t = self._dragInfo
	local dx = t.delta.x
	local dy = t.delta.y

	self._swipeH = dx > 0 and SwipeDirEnum.Right or dx < 0 and SwipeDirEnum.Left or SwipeDirEnum.None
	self._swipeV = dy < 0 and SwipeDirEnum.Down or dy > 0 and SwipeDirEnum.Up or SwipeDirEnum.None
end

function UIDragListenerHelper:_onDragBegin(_, pointerEventData)
	self:clear()

	local t = self._dragInfo

	t.screenPos = pointerEventData.position
	t.hasBegin = true
	t.isDragging = true
	t.delta = pointerEventData.delta
	t.screenPos_st = t.screenPos

	self:_refreshSwipeDir()
	self.dispatchEvent(self, UIDragListenerHelper.EventBegin, self, t.userParams)
end

function UIDragListenerHelper:_onDragging(_, pointerEventData)
	local t = self._dragInfo

	t.screenPos = pointerEventData.position
	t.isDragging = true
	t.delta = pointerEventData.delta

	self:_refreshSwipeDir()
	self.dispatchEvent(self, UIDragListenerHelper.EventDragging, self, t.userParams)
end

function UIDragListenerHelper:_onDragEnd(_, pointerEventData)
	local t = self._dragInfo

	t.screenPos = pointerEventData.position
	t.delta = pointerEventData.delta
	t.hasEnd = true
	t.isDragging = false
	t.screenPos_ed = t.screenPos

	self.dispatchEvent(self, UIDragListenerHelper.EventEnd, self, t.userParams)
end

function UIDragListenerHelper:isStoped()
	local t = self._dragInfo

	return t.hasEnd == true or t.hasEnd == false and t.hasBegin == false and t.isDragging == false
end

function UIDragListenerHelper:isEndedDrag()
	return self._dragInfo.hasEnd
end

function UIDragListenerHelper:isDragging()
	return self._dragInfo.isDragging
end

function UIDragListenerHelper:isSwipeNone()
	return self._swipeH == SwipeDirEnum.None and self._swipeV == SwipeDirEnum.None
end

function UIDragListenerHelper:isSwipeRight()
	return self._swipeH == SwipeDirEnum.Right
end

function UIDragListenerHelper:isSwipeLeft()
	return self._swipeH == SwipeDirEnum.Left
end

function UIDragListenerHelper:isSwipeUp()
	return self._swipeV == SwipeDirEnum.Up
end

function UIDragListenerHelper:isSwipeDown()
	return self._swipeV == SwipeDirEnum.Down
end

function UIDragListenerHelper:isSwipeLT()
	return self:isSwipeLeft() and self:isSwipeUp()
end

function UIDragListenerHelper:isSwipeRT()
	return self:isSwipeRight() and self:isSwipeUp()
end

function UIDragListenerHelper:isSwipeLB()
	return self:isSwipeLeft() and self:isSwipeDown()
end

function UIDragListenerHelper:isSwipeRB()
	return self:isSwipeRight() and self:isSwipeDown()
end

function UIDragListenerHelper:stopMovement()
	self._scrollRectCmp:StopMovement()
	self:clear()

	self._swipeH = SwipeDirEnum.None
	self._swipeV = SwipeDirEnum.None
end

function UIDragListenerHelper:isMoveVerticalMajor()
	if self:isSwipeNone() then
		return false
	end

	local t = self._dragInfo
	local dx = math.abs(t.delta.x)
	local dy = math.abs(t.delta.y)

	return dx < dy
end

function UIDragListenerHelper:isMoveHorizontalMajor()
	if self:isSwipeNone() then
		return false
	end

	local t = self._dragInfo
	local dx = math.abs(t.delta.x)
	local dy = math.abs(t.delta.y)

	return dy < dx
end

function UIDragListenerHelper:tweenToAnchorPos(trans, anchorPosV2, duration, cb, cbObj)
	trans = trans or self._transform
	duration = duration or 0.2

	local curAnchorX, curAnchorY = recthelper.getAnchor(trans)

	csTweenHelper.KillByObj(trans)

	if math.abs(curAnchorX - anchorPosV2.x) > 10 or math.abs(curAnchorY - anchorPosV2.y) > 10 then
		GameUtil.onDestroyViewMember_TweenId(self, "_tweenId_DOAnchorPos")

		self._tweenId_DOAnchorPos = csTweenHelper.DOAnchorPos(trans, anchorPosV2.x, anchorPosV2.y, duration, cb, cbObj)
	else
		recthelper.setAnchor(trans, anchorPosV2.x, anchorPosV2.y)
	end
end

function UIDragListenerHelper:screenPosV2ToAnchorPosV2(trans, screenPosV2)
	trans = trans or self._transform
	screenPosV2 = screenPosV2 or self._dragInfo.screenPos

	return (recthelper.screenPosToAnchorPos(screenPosV2, trans.parent))
end

function UIDragListenerHelper:tweenToScreenPos(trans, screenPosV2, duration, cb, cbObj)
	local anchorPosV2 = self:screenPosV2ToAnchorPosV2(trans, screenPosV2)

	self:tweenToAnchorPos(trans, anchorPosV2, duration, cb, cbObj)
end

function UIDragListenerHelper:tweenToMousePos()
	local t = self._dragInfo

	self:tweenToScreenPos(self._transform, t.screenPos)
end

function UIDragListenerHelper:tweenToMousePosWithConstrainedDirV2(constrainedDir, towardsEndTrans)
	assert(tonumber(constrainedDir.x) ~= nil and tonumber(constrainedDir.y) ~= nil)

	local trans = self._transform
	local t = self._dragInfo
	local toV2 = recthelper.screenPosToAnchorPos(t.screenPos, trans.parent)
	local x, y = recthelper.getAnchor(trans)
	local formV2 = Vector2.New(x, y)
	local curDir = toV2 - formV2
	local d = _dotV2(curDir, constrainedDir)

	toV2.x = formV2.x + constrainedDir.x * d
	toV2.y = formV2.y + constrainedDir.y * d

	if towardsEndTrans then
		local endToV2 = recthelper.rectToRelativeAnchorPos(towardsEndTrans.position, trans.parent)
		local maxDistanceDelta = Vector2.Distance(endToV2, formV2)

		toV2 = Vector2.MoveTowards(formV2, toV2, maxDistanceDelta)
	end

	self:tweenToAnchorPos(trans, toV2)
end

function UIDragListenerHelper:quaternionToMouse(trans, centerScreenPosV2)
	centerScreenPosV2 = centerScreenPosV2 or recthelper.uiPosToScreenPos(trans)

	local t = self._dragInfo
	local v2_end = t.screenPos
	local v2_start = v2_end - t.delta
	local v2_from = v2_start - centerScreenPosV2
	local v2_to = v2_end - centerScreenPosV2
	local v3_from = Vector3.New(v2_from.x, v2_from.y, 0)
	local v3_to = Vector3.New(v2_to.x, v2_to.y, 0)
	local q = Quaternion.FromToRotation(v3_from, v3_to)
	local angleInDeg, v3_axis = q:ToAngleAxis()
	local d = v3_axis.z
	local isClockWise

	if d < 0 then
		isClockWise = true
	elseif d > 0 then
		isClockWise = false
	end

	return q, angleInDeg, isClockWise
end

function UIDragListenerHelper:rotateZToMousePos(trans, centerScreenPosV2)
	local q, angleInDeg, isClockWise = self:quaternionToMouse(trans, centerScreenPosV2)

	trans.rotation = trans.rotation * q

	return q, angleInDeg, isClockWise
end

function UIDragListenerHelper:rotateZToMousePosWithCenterTrans(trans, centerTrans)
	local centerScreenPosV2 = recthelper.uiPosToScreenPos(centerTrans)

	self:rotateZToMousePos(trans, centerScreenPosV2)
end

function UIDragListenerHelper:degreesFromBeginDrag(trans, centerScreenPosV2)
	local t = self._dragInfo

	if not t.screenPos_st then
		return 0
	end

	trans = trans or self:transform()
	centerScreenPosV2 = centerScreenPosV2 or recthelper.uiPosToScreenPos(trans)

	local v2_end = t.screenPos
	local v2_from = t.screenPos_st - centerScreenPosV2
	local v2_to = v2_end - centerScreenPosV2

	return _degrees(_angleInRad(v2_from, v2_to))
end

function UIDragListenerHelper:setAnchorByMousePos(trans)
	local anchorPosV2 = self:screenPosV2ToAnchorPosV2(trans)

	recthelper.setAnchor(trans, anchorPosV2)
end

return UIDragListenerHelper
