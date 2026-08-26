-- chunkname: @modules/logic/common/view/VirtualFixedJoystick.lua

module("modules.logic.common.view.VirtualFixedJoystick", package.seeall)

local VirtualFixedJoystick = class("VirtualFixedJoystick", LuaCompBase)
local MAX_INPUT = 1
local CENTER_PIVOT = 0.5
local CENTER_POS = 0

function VirtualFixedJoystick:init(go)
	self.go = go
	self._gobg = gohelper.findChild(self.go, "#go_background")
	self._transbg = self._gobg.transform
	self._transbg.pivot.x = CENTER_PIVOT
	self._transbg.pivot.y = CENTER_PIVOT
	self._radius = self._transbg.sizeDelta.x / 2
	self._gohandle = gohelper.findChild(self.go, "#go_background/#go_handle")
	self._transhandle = self._gohandle.transform
	self._transhandle.anchorMin.x = CENTER_PIVOT
	self._transhandle.anchorMin.y = CENTER_PIVOT
	self._transhandle.anchorMax.x = CENTER_PIVOT
	self._transhandle.anchorMax.y = CENTER_PIVOT
	self._transhandle.pivot.x = CENTER_PIVOT
	self._transhandle.pivot.y = CENTER_PIVOT
	self._transhandlePos = Vector2.zero
	self._input = Vector2.zero
	self._click = SLFramework.UGUI.UIClickListener.Get(self.go)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self.go)
end

function VirtualFixedJoystick:addEventListeners()
	self._click:AddClickDownListener(self._onClickDown, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._click:AddClickUpListener(self._onClickUp, self)
end

function VirtualFixedJoystick:removeEventListeners()
	self._click:RemoveClickDownListener()
	self._drag:RemoveDragListener()
	self._click:RemoveClickUpListener()
end

function VirtualFixedJoystick:_onClickDown(param, pos, delta)
	if self._dragging then
		return
	end

	self._dragging = true

	self:_handleInput(pos)
end

function VirtualFixedJoystick:_onDrag(param, eventData)
	if not self._dragging then
		return
	end

	self:_handleInput(eventData.position)
end

function VirtualFixedJoystick:_handleInput(pos)
	local anchorX, anchorY = recthelper.screenPosToAnchorPos2(pos, self._transbg)
	local x = (anchorX - CENTER_POS) / self._radius
	local y = (anchorY - CENTER_POS) / self._radius

	self:setInPutValue(x, y)
end

function VirtualFixedJoystick:_onClickUp(param, pos, delta)
	if not self._dragging then
		return
	end

	self:reset()
end

function VirtualFixedJoystick:setInPutValue(x, y)
	self._input.x = x or CENTER_POS
	self._input.y = y or CENTER_POS

	if self._input.magnitude > MAX_INPUT then
		self._input = self._input.normalized
	end

	self:refreshHandlePos()
end

function VirtualFixedJoystick:refreshHandlePos()
	local posX = self._input.x * self._radius
	local posY = self._input.y * self._radius

	posX = GameUtil.clamp(posX, -self._radius, self._radius)
	posY = GameUtil.clamp(posY, -self._radius, self._radius)

	transformhelper.setLocalPosXY(self._transhandle, posX, posY)

	self._transhandlePos.x = posX
	self._transhandlePos.y = posY
end

function VirtualFixedJoystick:getStrength()
	return self._transhandlePos.magnitude / self._radius
end

function VirtualFixedJoystick:getIsDragging()
	return self._dragging
end

function VirtualFixedJoystick:getInputValue()
	return self._input
end

function VirtualFixedJoystick:reset()
	self:setInPutValue()

	self._dragging = false
end

function VirtualFixedJoystick:onDestroy()
	return
end

return VirtualFixedJoystick
