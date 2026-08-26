-- chunkname: @modules/common/others/UIGlobalDragHelper.lua

module("modules.common.others.UIGlobalDragHelper", package.seeall)

local UIGlobalDragHelper = class("UIGlobalDragHelper", UserDataDispose)
local abs = math.abs
local minDragDistance = 5
local _B = Bitwise

UIGlobalDragHelper.EventBegin = 1
UIGlobalDragHelper.EventDragging = 2
UIGlobalDragHelper.EventEnd = 3
UIGlobalDragHelper.EventMouseScrollWheel = 4

local Dir = {
	None = 0,
	Up = _B["<<"](1, 0),
	Right = _B["<<"](1, 1),
	Down = _B["<<"](1, 2),
	Left = _B["<<"](1, 3)
}

Dir.UR = _B["|"](Dir.Up, Dir.Right)
Dir.UL = _B["|"](Dir.Up, Dir.Left)
Dir.DR = _B["|"](Dir.Down, Dir.Right)
Dir.DL = _B["|"](Dir.Down, Dir.Left)
Dir.UD = _B["|"](Dir.Up, Dir.Down)
Dir.LR = _B["|"](Dir.Left, Dir.Right)
Dir.ULR = _B["|"](Dir.UR, Dir.Left)
Dir.UDL = _B["|"](Dir.UD, Dir.Left)
Dir.DLR = _B["|"](Dir.DR, Dir.Left)
Dir.UDR = _B["|"](Dir.UD, Dir.Right)
Dir.All = _B["|"](Dir.UD, Dir.LR)
UIGlobalDragHelper.Dir = Dir

local function _approximately(f0, f1, eps)
	return abs(f0 - f1) < (eps or 1e-06)
end

local function _isVertical(eDir)
	return eDir == UIGlobalDragHelper.Dir.Down or eDir == UIGlobalDragHelper.Dir.Up
end

UIGlobalDragHelper.isVertical = _isVertical

local function _isHorizontal(eDir)
	return eDir == UIGlobalDragHelper.Dir.Left or eDir == UIGlobalDragHelper.Dir.Right
end

UIGlobalDragHelper.isHorizontal = _isHorizontal

function UIGlobalDragHelper.deltaV2ToSimpleDir(deltaV2)
	assert(deltaV2.x and deltaV2.y)

	local absX = abs(deltaV2.x)
	local absY = abs(deltaV2.y)
	local bHor = absY < absX

	if bHor then
		if _approximately(deltaV2.x, 0) then
			return Dir.None
		end

		return (deltaV2.x > 0 or nil) and (Dir.Right or Dir.Left)
	else
		if _approximately(deltaV2.y, 0) then
			return Dir.None
		end

		return (deltaV2.y > 0 or nil) and (Dir.Up or Dir.Down)
	end

	return Dir.None
end

function UIGlobalDragHelper.deltaV2ToDeltaDistance(eDir, deltaV2)
	assert(deltaV2.x and deltaV2.y)

	if eDir == Dir.Down then
		return -deltaV2.y
	elseif eDir == Dir.Up then
		return deltaV2.y
	elseif eDir == Dir.Left then
		return -deltaV2.x
	elseif eDir == Dir.Right then
		return deltaV2.x
	end

	return 0
end

function UIGlobalDragHelper.deltaDistanceToDeltaV2(eDir, deltaDistance)
	assert(deltaDistance >= 0)

	if eDir == Dir.Down then
		return {
			x = 0,
			y = -deltaDistance
		}
	elseif eDir == Dir.Up then
		return {
			x = 0,
			y = deltaDistance
		}
	elseif eDir == Dir.Left then
		return {
			y = 0,
			x = -deltaDistance
		}
	elseif eDir == Dir.Right then
		return {
			y = 0,
			x = deltaDistance
		}
	end

	return {
		x = 0,
		y = 0
	}
end

function UIGlobalDragHelper:ctor()
	self:__onInit()
	LuaEventSystem.addEventMechanism(self)

	self._dragInfo = {
		delta = Vector2.New(0, 0),
		deltaNorm = Vector2.New(0, 0),
		totalDelta = Vector2.New(0, 0),
		screenPos = Vector2.New(0, 0)
	}

	self:clear()
end

function UIGlobalDragHelper:onDestroyView()
	self:release()
	self:__onDispose()
end

function UIGlobalDragHelper:create(go, userParams)
	self:release()

	self._transform = go.transform
	self._dragInfo.userParams = userParams or {}
	self._csDragObj = TouchEventMgrHepler.getTouchEventMgr(go)

	self._csDragObj:SetIgnoreUI(true)
	self._csDragObj:SetOnlyTouch(true)
	self._csDragObj:SetOnDragBeginCb(self._onDragBegin, self)
	self._csDragObj:SetOnDragCb(self._onDragging, self)
	self._csDragObj:SetOnDragEndCb(self._onDragEnd, self)
	self._csDragObj:SetScrollWheelCb(self._onMouseScrollWheelChanged, self)

	if BootNativeUtil.isMobilePlayer() then
		self._csDragObj:SetOnMultiDragCb(self._onMultiDrag, self)
	end
end

function UIGlobalDragHelper:release()
	self:unregisterAllCallback(UIGlobalDragHelper.EventBegin)
	self:unregisterAllCallback(UIGlobalDragHelper.EventDragging)
	self:unregisterAllCallback(UIGlobalDragHelper.EventEnd)
	self:unregisterAllCallback(UIGlobalDragHelper.EventMouseScrollWheel)

	if self._csDragObj then
		TouchEventMgrHepler.remove(self._csDragObj)

		self._csDragObj = nil
	end
end

function UIGlobalDragHelper:clear()
	local t = self._dragInfo

	t.isDragging = false
	t.hasEnd = false

	t.screenPos:Set(0, 0)
	t.totalDelta:Set(0, 0)
	t.delta:Set(0, 0)
	t.deltaNorm:Set(0, 0)

	t.dir = Dir.None
	t.dirHorV = Dir.None
	t.scrollDelta = 0
end

function UIGlobalDragHelper:dragInfo()
	return self._dragInfo
end

function UIGlobalDragHelper:transform()
	return self._transform
end

function UIGlobalDragHelper:_onDragBegin(screenPosV3)
	self:clear()

	local t = self._dragInfo

	t.screenPos:Set(screenPosV3.x, screenPosV3.y)
	t.totalDelta:Set(screenPosV3.x, screenPosV3.y)
end

function UIGlobalDragHelper:_onDragging(screenPosV3)
	local screenPos = Vector2.New(screenPosV3.x, screenPosV3.y)
	local t = self._dragInfo
	local totalMagnitude = t.totalDelta.magnitude

	if totalMagnitude < minDragDistance then
		t.totalDelta = t.totalDelta + screenPosV3

		return
	end

	self:_updateDelta(t.screenPos, screenPos)

	t.screenPos = screenPos

	if t.isDragging == false then
		t.isDragging = true

		self.dispatchEvent(self, UIGlobalDragHelper.EventBegin, self, t.userParams)
	else
		self.dispatchEvent(self, UIGlobalDragHelper.EventDragging, self, t.userParams)
	end
end

local function _calcDeltaNormalized(outV2, inV2)
	local sx = 1920 / UnityEngine.Screen.width
	local sy = 1080 / UnityEngine.Screen.height
	local s = math.max(sx, sy)

	outV2:Set(inV2.x * s, inV2.y * s)
end

function UIGlobalDragHelper:_updateDelta(lastScreenPos, nowScreenPos)
	local t = self._dragInfo

	t.delta = nowScreenPos - lastScreenPos

	_calcDeltaNormalized(t.deltaNorm, t.delta)

	t.dir = Dir.None
	t.dirHorV = Dir.None

	local absX = abs(t.delta.x)
	local absY = abs(t.delta.y)
	local isMoveHor = not _approximately(absX, 0)
	local isMoveVer = not _approximately(absY, 0)

	if isMoveHor then
		t.dir = t.delta.x > 0 and _B["|"](t.dir, Dir.Right) or _B["|"](t.dir, Dir.Left)
	end

	if isMoveVer then
		t.dir = t.delta.y > 0 and _B["|"](t.dir, Dir.Up) or _B["|"](t.dir, Dir.Down)
	end

	if isMoveHor or isMoveVer then
		if absY < absX then
			if t.delta.x > 0 then
				t.dirHorV = Dir.Right or Dir.Left
			end
		elseif t.delta.y > 0 then
			t.dirHorV = Dir.Up or Dir.Down
		end
	end
end

function UIGlobalDragHelper:isDirNone()
	local t = self._dragInfo

	return t.dir == Dir.None
end

function UIGlobalDragHelper:isSimpleVertical()
	local t = self._dragInfo

	return _isVertical(t.dirHorV)
end

function UIGlobalDragHelper:isSimpleHorizontal()
	local t = self._dragInfo

	return _isHorizontal(t.dirHorV)
end

function UIGlobalDragHelper:getSimpleDirDelta(isNorm)
	local t = self._dragInfo

	if self:isDirNone() then
		return 0
	end

	if self:isSimpleVertical() then
		return (isNorm or nil) and (t.deltaNorm.y or t.delta.y)
	else
		return (isNorm or nil) and (t.deltaNorm.x or t.delta.x)
	end
end

function UIGlobalDragHelper:_onDragEnd(screenPosV3)
	local screenPos = Vector2.New(screenPosV3.x, screenPosV3.y)
	local t = self._dragInfo

	self:_updateDelta(t.screenPos, screenPos)

	t.screenPos = screenPos
	t.hasEnd = true
	t.isDragging = false

	self.dispatchEvent(self, UIGlobalDragHelper.EventEnd, self, t.userParams)
end

function UIGlobalDragHelper:_onMouseScrollWheelChanged(delta)
	local t = self._dragInfo

	t.scrollDelta = delta

	self.dispatchEvent(self, UIGlobalDragHelper.EventMouseScrollWheel, self, t.userParams)
end

function UIGlobalDragHelper:_onMultiDrag(isEnLarger, delta)
	self:_onMouseScrollWheelChanged(delta * 0.01)
end

function UIGlobalDragHelper:isStoped()
	local t = self._dragInfo

	return t.hasEnd == true or t.hasEnd == false and t.isDragging == false
end

function UIGlobalDragHelper:isEndedDrag()
	return self._dragInfo.hasEnd
end

function UIGlobalDragHelper:isDragging()
	return self._dragInfo.isDragging
end

return UIGlobalDragHelper
