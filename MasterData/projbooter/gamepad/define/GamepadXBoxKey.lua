-- chunkname: @projbooter/gamepad/define/GamepadXBoxKey.lua

module("projbooter.gamepad.define.GamepadXBoxKey", package.seeall)

local GamepadXBoxKey = _M
local KeyCode = UnityEngine.KeyCode

GamepadXBoxKey.AxisKeys = {
	XAxis = GamepadEnum.KeyCode.LeftStickHorizontal,
	YAxis = GamepadEnum.KeyCode.LeftStickVertical,
	["5thAxis"] = GamepadEnum.KeyCode.RightStickHorizontal,
	["4thAxis"] = GamepadEnum.KeyCode.RightStickVertical
}
GamepadXBoxKey.JoystickKeys = {
	[KeyCode.JoystickButton0] = GamepadEnum.KeyCode.A,
	[KeyCode.JoystickButton1] = GamepadEnum.KeyCode.B,
	[KeyCode.JoystickButton4] = GamepadEnum.KeyCode.LB,
	[KeyCode.JoystickButton5] = GamepadEnum.KeyCode.RB
}

return GamepadXBoxKey
