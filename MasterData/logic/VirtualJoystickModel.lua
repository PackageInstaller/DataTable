-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/joystick/model/VirtualJoystickModel.lua

module("logic.extensions.joystick.model.VirtualJoystickModel", package.seeall)

local VirtualJoystickModel = class("VirtualJoystickModel", BaseModel)

function VirtualJoystickModel:ctor()
	VirtualJoystickModel.super.ctor(self)

	self._disableSignal = SignalAmount.New()
	self._joystickCtrl = nil
	self._joystickView = nil
end

function VirtualJoystickModel:onInit()
	VirtualJoystickModel.super.onInit(self)

	self._joystickCtrl = nil
	self._joystickView = nil
end

function VirtualJoystickModel:onReset()
	VirtualJoystickModel.super.onReset(self)
	self._disableSignal:clear()
end

function VirtualJoystickModel:setSmallJoystickModel(isSmallJoystickModel)
	self._joystickView:setSmallJoystickModel(isSmallJoystickModel)
end

function VirtualJoystickModel:setJoystickView(joystickView)
	self._joystickView = joystickView
end

function VirtualJoystickModel:getJoystickView()
	return self._joystickView
end

function VirtualJoystickModel:setViewRoot(rootType)
	self._joystickView:setViewRoot(rootType)
end

function VirtualJoystickModel:setJoystickCtrl(ctrl)
	self._joystickCtrl = ctrl

	self:_handleJoystickState()
end

function VirtualJoystickModel:enable(key)
	self._disableSignal:remove(key)
	self:_handleJoystickState()
end

function VirtualJoystickModel:clearSignal()
	self._disableSignal:clear()
	self:_handleJoystickState()
end

function VirtualJoystickModel:disable(key)
	if not self._disableSignal:hasKey(key) then
		self._disableSignal:add(key)
		self:_handleJoystickState()
	end
end

function VirtualJoystickModel:getJoystickCtr()
	return self._joystickCtrl
end

function VirtualJoystickModel:_handleJoystickState()
	if self._joystickView then
		local isActive = self._disableSignal:isUnactive()

		self._joystickView:setEnable(isActive)
	end
end

VirtualJoystickModel.instance = VirtualJoystickModel.New()

return VirtualJoystickModel
