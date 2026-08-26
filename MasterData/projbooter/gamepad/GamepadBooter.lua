-- chunkname: @projbooter/gamepad/GamepadBooter.lua

module("projbooter.hotupdate.GamepadBooter", package.seeall)

local GamepadBooter = class("GamepadBooter")

function GamepadBooter:init()
	addGlobalModule("projbooter.gamepad.define.GamepadEnum", "GamepadEnum")
	addGlobalModule("projbooter.gamepad.define.GamepadEvent", "GamepadEvent")
	addGlobalModule("projbooter.gamepad.define.GamepadXBoxKey_Android", "GamepadXBoxKey_Android")
	addGlobalModule("projbooter.gamepad.define.GamepadXBoxKey", "GamepadXBoxKey")
	addGlobalModule("projbooter.gamepad.define.GamepadKeyMapEnum", "GamepadKeyMapEnum")
end

function GamepadBooter:setBootMsgBoxClick(onClickRightCallBack, onClickRightCallBackObj, onClickLeftCallBack, onClickLeftCallBackObj)
	self.onClickRightCallBack = onClickRightCallBack
	self.onClickRightCallBackObj = onClickRightCallBackObj
	self.onClickLeftCallBack = onClickLeftCallBack
	self.onClickLeftCallBackObj = onClickLeftCallBackObj

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

	self._mgrInst:SetKeyListLua(keys, axiskeys)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.UpKey, self._onClickKey, self)

	self._buttonHandleFunc = {
		[GamepadEnum.KeyCode.A] = {
			self._onClickA
		},
		[GamepadEnum.KeyCode.B] = {
			self._onClickB
		}
	}
end

function GamepadBooter:_checkGamepadModel()
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

function GamepadBooter:_onClickKey(keyCode)
	local key = self._useKeyType.JoystickKeys[keyCode]
	local func = self._buttonHandleFunc[key][1]

	if func then
		func(self)
	end
end

function GamepadBooter:_onClickA()
	if self.onClickRightCallBack then
		self.onClickRightCallBack(self.onClickRightCallBackObj)
	end
end

function GamepadBooter:_onClickB()
	if self.onClickLeftCallBack then
		self.onClickLeftCallBack(self.onClickLeftCallBackObj)
	end
end

function GamepadBooter:dispose()
	self.onClickRightCallBack = nil
	self.onClickRightCallBackObj = nil
	self.onClickLeftCallBack = nil
	self.onClickLeftCallBackObj = nil
	self._mgrInst = nil
	self._eventMgrInst = nil
	self._eventMgr = nil

	for key, value in pairs(self) do
		if type(value) == "userdata" then
			rawset(self, key, nil)
			logNormal("key = " .. tostring(key) .. " value = " .. tostring(value))
		end
	end
end

GamepadBooter.instance = GamepadBooter.New()

return GamepadBooter
