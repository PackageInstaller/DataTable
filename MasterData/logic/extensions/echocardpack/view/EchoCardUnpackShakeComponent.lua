-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/view/EchoCardUnpackShakeComponent.lua

module("logic.extensions.echocardpack.view.EchoCardUnpackShakeComponent", package.seeall)

local M = class("EchoCardUnpackShakeComponent")
local Input = UnityEngine.Input
local unpackState = EchoCardPackController.UnpackState
local PortraitUp = "Portrait"
local PortraitUpsideDown = "PortraitUpsideDown"
local FaceUp = "FaceUp"
local FaceDown = "FaceDown"

function M:ctor(imageContainer)
	self._compContainer = imageContainer
	self._goContainer = imageContainer.gameObject
end

function M:_init()
	self._old_y = 0
	self._new_y = 0
	self._currentDistanceY = 0
	self._distanceY = 0.4
	self._old_x = 0
	self._new_x = 0
	self._currentDistanceX = 0
	self._distanceX = 0.3
end

function M:_setEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ECHO_UNPACK_STATE_CHANGE, self._handleUnpackStateChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ECHO_UNPACK_STATE_CHANGE, self._handleUnpackStateChange, self)
	end
end

function M:onEnter()
	self:_init()

	self._curOrientation = Input.deviceOrientation
	self._curIsHorizon = self:_analysisHorizontal(self._curOrientation)

	EchoCardPackController.instance:setHorizontalState(self._curIsHorizon)
	self:_setEvents(true)
end

function M:onExit()
	self:_setEvents(false)
end

function M:Update()
	if not EchoCardPackController.instance:getModelInitState() then
		return
	end

	if self._isNotCheck then
		return
	end

	local curMobilePos = Input.acceleration

	self._new_y = curMobilePos.y
	self._currentDistanceY = self._new_y - self._old_y
	self._old_y = self._new_y
	self._new_x = curMobilePos.x
	self._currentDistanceX = self._new_x - self._old_x
	self._old_x = self._new_x

	if self._currentDistanceY > self._distanceY and self._currentDistanceX > self._distanceX then
		local state = EchoCardPackController.instance:getUnpackState()

		if state == unpackState.UnInOrder then
			GlobalDispatcher:dispatchEvent(EventType.ECHO_UNPACK_SHOW_NEXT)

			return
		end
	end

	local curDeviceOrientation = Input.deviceOrientation

	if self._curOrientation ~= curDeviceOrientation then
		self._curOrientation = curDeviceOrientation

		local orientation = tostring(curDeviceOrientation)

		if orientation == FaceUp or orientation == FaceDown then
			return
		end

		local isHorizon = self:_analysisHorizontal(orientation)

		if isHorizon ~= self._curIsHorizon then
			self._temIsHorizon = isHorizon

			removetimer(self._updateOrientation, self)
			settimer(0.4, self._updateOrientation, self, false)
		end
	end
end

function M:_updateOrientation()
	self._curIsHorizon = self._temIsHorizon

	EchoCardPackController.instance:setHorizontalState(self._curIsHorizon)
	GlobalDispatcher:dispatchEvent(EventType.ECHO_UNPACK_HV_STATE_CHANGE)
end

function M:_analysisHorizontal(orientation)
	if orientation == PortraitUp or orientation == PortraitUpsideDown then
		return false
	end

	return true
end

function M:_handleUnpackStateChange()
	local state = EchoCardPackController.instance:getUnpackState()

	if state == unpackState.Unpacking or state == unpackState.UnpackEnd then
		self._isNotCheck = true
	else
		self._isNotCheck = false

		removetimer(self._updateOrientation, self)
	end
end

function M:OnDisable()
	removetimer(self._updateOrientation, self)
end

function M:OnDestroy()
	return
end

return M
