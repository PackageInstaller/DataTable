-- chunkname: @projbooter/gamepad/define/GamepadXBoxKey_Android.lua

module("projbooter.gamepad.define.GamepadXBoxKey_Android", package.seeall)

local GamepadXBoxKey_Android = _M
local KeyCode = UnityEngine.KeyCode

GamepadXBoxKey_Android.AxisKeys = {
	XAxis = GamepadEnum.KeyCode.LeftStickHorizontal,
	YAxis = GamepadEnum.KeyCode.LeftStickVertical,
	["3thAxis"] = GamepadEnum.KeyCode.RightStickHorizontal,
	["4thAxis"] = GamepadEnum.KeyCode.RightStickVertical
}
GamepadXBoxKey_Android.JoystickKeys = {
	[KeyCode.JoystickButton0] = GamepadEnum.KeyCode.A,
	[KeyCode.JoystickButton1] = GamepadEnum.KeyCode.B,
	[KeyCode.JoystickButton4] = GamepadEnum.KeyCode.LB,
	[KeyCode.JoystickButton5] = GamepadEnum.KeyCode.RB
}

return GamepadXBoxKey_Android
