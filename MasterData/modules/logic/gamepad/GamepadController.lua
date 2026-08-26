-- chunkname: @modules/logic/gamepad/GamepadController.lua

module("modules.logic.gamepad.GamepadController", package.seeall)

local GamepadController = class("GamepadController", BaseController)

function GamepadController:onInit()
	if GamepadBooter ~= nil then
		self:setUp()
	end
end

function GamepadController:onInitFinish()
	return
end

function GamepadController:addConstEvents()
	return
end

function GamepadController:reInit()
	return
end

function GamepadController:isOpen()
	return self._isOpen
end

function GamepadController:isDownA()
	return self._down
end

function GamepadController:getMousePosition()
	if self:isOpen() then
		return self:getScreenPos()
	else
		return UnityEngine.Input.mousePosition
	end
end

function GamepadController:getScreenPos()
	self:_updateScreenPos()

	return Vector2.New(self._screenPosV2.x, self._screenPosV2.y)
end

function GamepadController:setPointerAnchor(x, y)
	self._pointer:setAnchor(x, y)
	self:_updateScreenPos()
end

function GamepadController:setUp()
	self:_checkGamepadModel()

	if self._isOpen == false then
		return
	end

	local keys = {}

	for i, v in pairs(self._useKeyType.JoystickKeys) do
		table.insert(keys, i)
	end

	local axiskeys = {}

	for i, v in pairs(self._useKeyType.AxisKeys) do
		table.insert(axiskeys, i)
	end

	self._mgrInst = ZProj.GamepadManager.Instance
	self._eventMgrInst = ZProj.GamepadEvent.Instance
	self._eventMgr = ZProj.GamepadEvent

	self._eventMgrInst:ClearLuaListener()
	self._mgrInst:SetKeyListLua(keys, axiskeys)

	self._pointer = GamepadPointer.New()
	self._screenPosV2 = Vector2.New()

	self._eventMgrInst:AddLuaLisenter(self._eventMgr.DownKey, self._onDownKey, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.UpKey, self._onUpKey, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.ClickKey, self._onClickKey, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.AxisChange, self._onAxisChange, self)

	self._axisHandleFunc = {
		[GamepadEnum.KeyCode.LeftStickHorizontal] = self._onLeftStickHorizontal,
		[GamepadEnum.KeyCode.LeftStickVertical] = self._onLeftStickVertical,
		[GamepadEnum.KeyCode.RightStickHorizontal] = self._onRightStickHorizontal,
		[GamepadEnum.KeyCode.RightStickVertical] = self._onRightStickVertical
	}
	self._buttonHandleFunc = {
		[GamepadEnum.KeyCode.A] = {
			self._onDownA,
			self._onUpA
		},
		[GamepadEnum.KeyCode.B] = {
			self._onDownB,
			self._onUpB
		},
		[GamepadEnum.KeyCode.LB] = {},
		[GamepadEnum.KeyCode.RB] = {}
	}
end

function GamepadController:_checkGamepadModel()
	self._isOpen = SDKNativeUtil.isGamePad()

	if self._isOpen then
		local joystickNames = UnityEngine.Input.GetJoystickNames()
		local matchGamepadType = false

		if joystickNames and joystickNames.Length > 0 then
			for i = 0, joystickNames.Length - 1 do
				if matchGamepadType then
					break
				end

				local name = joystickNames[i]

				for key, mapType in pairs(GamepadKeyMapEnum.KeyMap) do
					if string.find(name, key) then
						matchGamepadType = true

						if BootNativeUtil.isAndroid() then
							self._useKeyType = mapType[2]

							break
						end

						if BootNativeUtil.isWindows() or SLFramework.FrameworkSettings.IsEditor then
							self._useKeyType = mapType[1]
						end

						break
					end
				end
			end
		end

		if matchGamepadType == false then
			if BootNativeUtil.isAndroid() then
				self._useKeyType = GamepadKeyMapEnum.KeyMap.XIAOM[2]
			elseif BootNativeUtil.isWindows() or SLFramework.FrameworkSettings.IsEditor then
				self._useKeyType = GamepadKeyMapEnum.KeyMap.XIAOM[1]
			end
		end
	end
end

function GamepadController:_onDownKey(keyCode)
	local key = self._useKeyType.JoystickKeys[keyCode]
	local func = self._buttonHandleFunc[key][1]

	if func then
		func(self)
	end

	self:dispatchEvent(GamepadEvent.KeyDown, key)
end

function GamepadController:_onUpKey(keyCode)
	local key = self._useKeyType.JoystickKeys[keyCode]
	local func = self._buttonHandleFunc[key][2]

	if func then
		func(self)
	end

	self:dispatchEvent(GamepadEvent.KeyUp, key)
end

function GamepadController:_updateScreenPos()
	local x, y = self._pointer:getScreenPos()

	if x and y then
		self._screenPosV2.x = x
		self._screenPosV2.y = y
	end
end

function GamepadController:_setUIClick(isDown)
	self._mgrInst:SendClickEvent(self._screenPosV2, isDown)
end

function GamepadController:_sendDragEvent()
	self:_updateScreenPos()
	self._mgrInst:SendDragEvent(self._screenPosV2)
end

function GamepadController:_onClickKey(keyCode)
	return
end

function GamepadController:_onAxisChange(name, value)
	local key = self._useKeyType.AxisKeys[name]
	local func = self._axisHandleFunc[key]

	if func then
		func(self, value)
	end

	self:dispatchEvent(GamepadEvent.AxisChange, key, value)
end

function GamepadController:_onDownA()
	self._down = true

	self:_updateScreenPos()
	self:_setUIClick(true)
	GameGlobalMgr.instance:playTouchEffect(self._screenPosV2)

	local allTouchMgr = TouchEventMgrHepler.getAllMgrs()

	self:_clearDownActiveTouchMgrDic()

	self._downActiveTouchMgrDic = {}

	for i, v in ipairs(allTouchMgr) do
		if not gohelper.isNil(v) and v.isActiveAndEnabled then
			v:TriggerOnTouchDown(self._screenPosV2)

			self._downActiveTouchMgrDic[v] = true
		end
	end
end

function GamepadController:_onUpA()
	self._down = false

	self:_updateScreenPos()
	self:_setUIClick(false)

	if self._downActiveTouchMgrDic then
		local allTouchMgr = TouchEventMgrHepler.getAllMgrs()

		for i, v in ipairs(allTouchMgr) do
			if not gohelper.isNil(v) and v.isActiveAndEnabled and self._downActiveTouchMgrDic[v] then
				v:TriggerOnClick(self._screenPosV2)
				v:TriggerOnTouchUp(self._screenPosV2)
			end
		end
	end

	self:_clearDownActiveTouchMgrDic()
end

function GamepadController:_clearDownActiveTouchMgrDic()
	if self._downActiveTouchMgrDic then
		for v, _ in pairs(self._downActiveTouchMgrDic) do
			self._downActiveTouchMgrDic[v] = nil
		end

		self._downActiveTouchMgrDic = nil
	end
end

function GamepadController:_onDownB()
	return
end

function GamepadController:_onUpB()
	if not self._down then
		NavigateMgr.instance:onEscapeBtnClick()
	end
end

function GamepadController:_onLeftStickHorizontal(value)
	local scale = Time.deltaTime / 0.016

	self._pointer:updateX(scale * value)

	if self._down then
		self:_sendDragEvent()
	end
end

function GamepadController:_onLeftStickVertical(value)
	local scale = Time.deltaTime / 0.016

	self._pointer:updateY(-1 * scale * value)

	if self._down then
		self:_sendDragEvent()
	end
end

function GamepadController:_onRightStickHorizontal(value)
	return
end

function GamepadController:_onRightStickVertical(value)
	return
end

GamepadController.instance = GamepadController.New()

return GamepadController
