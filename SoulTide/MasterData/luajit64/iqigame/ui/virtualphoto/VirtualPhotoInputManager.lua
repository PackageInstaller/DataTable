-- chunkname: @IQIGame\\UI\\VirtualPhoto\\VirtualPhotoInputManager.lua

local BaseVirtualPhotoInputManager = require("IQIGame.UI.VirtualPhoto.BaseVirtualPhotoInputManager")
local m = {}

m = extend(BaseVirtualPhotoInputManager, m)

function m.New(uiCamera, getCurrentElementFunc)
	local obj = Clone(m)

	obj:Init()

	obj.UICamera = uiCamera
	obj.GetCurrentElementFunc = getCurrentElementFunc

	return obj
end

function m:OnDoubleTap(mouseX, mouseY)
	local controller = self.GetCurrentElementFunc()

	if controller == nil then
		return
	end

	controller:Flip()
end

function m:OnDrag(state, deltaX, deltaY)
	if state == DigitalRubyShared.GestureRecognizerState.Executing then
		local controller = self.GetCurrentElementFunc()

		if controller == nil then
			return
		end

		local ratio = self.UICamera.orthographicSize * 2 / UnityEngine.Screen.height

		controller:Move(deltaX * ratio, deltaY * ratio)
	end
end

function m:OnScale(state, scale)
	if state == DigitalRubyShared.GestureRecognizerState.Executing then
		local controller = self.GetCurrentElementFunc()

		if controller == nil then
			return
		end

		controller:Scale(scale)
	end
end

function m:OnRotate(state, angle)
	if state == DigitalRubyShared.GestureRecognizerState.Executing then
		local controller = self.GetCurrentElementFunc()

		if controller == nil then
			return
		end

		controller:Rotate(angle)
	end
end

return m
