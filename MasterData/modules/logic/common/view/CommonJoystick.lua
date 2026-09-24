-- chunkname: @modules/logic/common/view/CommonJoystick.lua

module("modules.logic.common.view.CommonJoystick", package.seeall)

local CommonJoystick = class("CommonJoystick", LuaCompBase)

CommonJoystick.InputType = {
	Dynamic = 1,
	FixedCenter = 0
}

function CommonJoystick:ctor(inputType, noKeyboard)
	self._inputType = inputType or CommonJoystick.InputType.FixedCenter
	self._noKeyboard = noKeyboard
end

function CommonJoystick:init(go)
	self.go = go
	self._joystickWrapCs = go:GetComponent(typeof(ZProj.JoystickWrap))
	self._goeffectdir = gohelper.findChild(go, "vx_control")
	self._transeffectdir = self._goeffectdir.transform
	self._transhandle = gohelper.findChild(go, "handle").transform
	self._goeffecthandle = gohelper.findChild(go, "handle/vx_handle_light")
	self._inputX = 0
	self._inputY = 0
	self._inGuide = false

	gohelper.setActive(self._goeffectdir, false)
	gohelper.setActive(self._goeffecthandle, false)
	self._joystickWrapCs:SetInputType(self._inputType)
end

function CommonJoystick:setCallback(valueChangeCallback, pointDownCallback, pointUpCallback, callbackObj)
	self._valueChangeCallback = valueChangeCallback
	self._pointDownCallback = pointDownCallback
	self._pointUpCallback = pointUpCallback
	self._callbackObj = callbackObj
end

function CommonJoystick:addEventListeners()
	self._joystickWrapCs:AddOnValueChanged(self._onValueChange, self)
	self._joystickWrapCs:AddPointerDownCallBack(self._onPointDown, self)
	self._joystickWrapCs:AddPointerUpCallBack(self._onPointUp, self)
end

function CommonJoystick:removeEventListeners()
	self._joystickWrapCs:RemovePointerDownCallBack()
	self._joystickWrapCs:RemovePointerUpCallBack()
	self._joystickWrapCs:RemoveOnValueChanged()
end

function CommonJoystick:onUpdate()
	local inGuide = GuideController.instance:isAnyGuideRunning()

	if inGuide and not self._inGuide and self._joystickWrapCs.IsDraging then
		self:reset()
	end

	self._inGuide = inGuide

	if self._noKeyboard or self._joystickWrapCs.IsDraging then
		return
	end

	local inputX = UnityEngine.Input.GetAxisRaw("Horizontal")
	local inputY = UnityEngine.Input.GetAxisRaw("Vertical")

	if inGuide then
		inputY = 0
		inputX = 0
	end

	if self._inputX ~= inputX or self._inputY ~= inputY then
		local radius = self._joystickWrapCs.maxRadius

		transformhelper.setLocalPosXY(self._transhandle, inputX * radius, inputY * radius)

		local x, y = transformhelper.getLocalPos(self._transhandle)
		local ratio = y > 0 and 1 or -1
		local angle = Vector2.Angle(Vector2.right, Vector2.New(x, y)) * ratio

		transformhelper.setEulerAngles(self._transeffectdir, 0, 0, angle)

		if inputX == 0 and inputY == 0 then
			self:_onPointUp()
		else
			self:_onPointDown()
		end

		if self._valueChangeCallback then
			self._valueChangeCallback(self._callbackObj, self._inputX, self._inputY)
		end
	end
end

function CommonJoystick:_onPointDown()
	gohelper.setActive(self._goeffectdir, true)
	gohelper.setActive(self._goeffecthandle, true)

	if self._pointDownCallback then
		self._pointDownCallback(self._callbackObj)
	end
end

function CommonJoystick:_onPointUp()
	gohelper.setActive(self._goeffectdir, false)
	gohelper.setActive(self._goeffecthandle, false)

	if self._pointUpCallback then
		self._pointUpCallback(self._callbackObj)
	end
end

function CommonJoystick:_onValueChange(lockDirX, lockDirY, lockDirIndex, InputX, InputY)
	if self._inputX ~= InputX or self._inputY ~= InputY then
		self._inputX = InputX
		self._inputY = InputY

		if self._valueChangeCallback then
			self._valueChangeCallback(self._callbackObj, self._inputX, self._inputY)
		end
	end
end

function CommonJoystick:getInput()
	return self._inputX, self._inputY
end

function CommonJoystick:reset()
	if self._joystickWrapCs and not gohelper.isNil(self._joystickWrapCs) then
		self._joystickWrapCs:RestJoystick()
	end

	self:_onPointUp()

	if self._inputX ~= 0 or self._inputY ~= 0 then
		self._inputX, self._inputY = 0, 0

		if self._valueChangeCallback then
			self._valueChangeCallback(self._callbackObj, 0, 0)
		end
	end
end

CommonJoystick.prefabPath = "modules/party_game/ui/viewres/common/common_joystick.prefab"

return CommonJoystick
